import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:cureloop_patient/core/database/app_database.dart' hide isNotNull;
import 'package:cureloop_patient/core/database/repositories/sqlite_prescription_repository.dart';
import 'package:cureloop_patient/core/database/repositories/sqlite_medicine_repository.dart';
import 'package:cureloop_patient/core/database/repositories/sqlite_appointment_repository.dart';
import 'package:cureloop_patient/core/database/repositories/sqlite_profile_repository.dart';
import 'package:cureloop_patient/features/prescriptions/data/models/prescription_models.dart';
import 'package:cureloop_patient/features/medicines/data/models/medicine_models.dart';
import 'package:cureloop_patient/features/appointments/data/models/appointment_models.dart';
import 'package:cureloop_patient/features/profile/data/models/profile_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late SqlitePrescriptionRepository rxRepo;
  late SqliteMedicineRepository medRepo;
  late SqliteAppointmentRepository aptRepo;
  late SqliteProfileRepository profileRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    // Trigger initialization and seed
    await db.customSelect('SELECT 1').get();

    rxRepo = SqlitePrescriptionRepository(db);
    medRepo = SqliteMedicineRepository(db);
    aptRepo = SqliteAppointmentRepository(db);
    profileRepo = SqliteProfileRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('1. Database Initialization and Seeding', () {
    test('initializes and seeds demo patient profile, allergies, and family members', () async {
      final profile = await profileRepo.getProfile();
      expect(profile.name, 'Jane Doe');
      expect(profile.bloodGroup, 'O+');

      final allergies = await profileRepo.getAllergies();
      expect(allergies.length, 2);
      expect(allergies.any((a) => a.name == 'Penicillin'), isTrue);

      final family = await profileRepo.getFamilyMembers();
      expect(family.length, 2);
      expect(family.any((f) => f.name == 'John Doe'), isTrue);
    });

    test('initializes and seeds demo prescriptions and dose events', () async {
      final prescriptions = await rxRepo.getPrescriptions();
      expect(prescriptions.length, 1);
      expect(prescriptions.first.doctorName, 'Dr. Sharma');
      expect(prescriptions.first.status, PrescriptionStatus.confirmed);
      expect(prescriptions.first.medicines.length, 3);

      final todayDoses = await medRepo.getTodayDoses();
      expect(todayDoses.length, greaterThanOrEqualTo(1));
    });
  });

  group('2. Prescriptions Lifecycle & State Machine', () {
    test('creates manual prescription as DRAFT without activating schedule', () async {
      final newRx = await rxRepo.createManualPrescription({
        'doctor_name': 'Dr. Watson',
        'clinic_name': 'Baker Street Clinic',
        'prescription_date': DateTime.now().toIso8601String(),
        'medicines': [
          {
            'medicine_name': 'Amoxicillin 500mg',
            'dosage': '1 capsule',
            'frequency': '1-0-1',
            'duration_days': 5,
            'food_timing': 'AFTER_FOOD',
          }
        ],
      });

      expect(newRx.status, PrescriptionStatus.draft);
      expect(newRx.doctorName, 'Dr. Watson');
      expect(newRx.medicines.length, 1);

      // Verify no schedule is active yet
      final schedules = await db.select(db.medicineSchedules).get();
      final rxSchedules = schedules.where((s) => s.prescriptionId == newRx.id);
      expect(rxSchedules, isEmpty);
    });

    test('transitions from DRAFT to PENDING_CONFIRMATION', () async {
      final newRx = await rxRepo.createManualPrescription({
        'doctor_name': 'Dr. Strange',
        'medicines': [
          {
            'medicine_name': 'Paracetamol 650mg',
            'dosage': '1 tablet',
            'frequency': '1-0-0',
            'duration_days': 3,
            'food_timing': 'AFTER_FOOD',
          }
        ],
      });

      final submitted = await rxRepo.submitForConfirmation(newRx.id);
      expect(submitted.status, PrescriptionStatus.pendingConfirmation);

      final fetched = await rxRepo.getPrescription(newRx.id);
      expect(fetched.status, PrescriptionStatus.pendingConfirmation);
    });

    test('safety check detects allergy conflicts with patient profile', () async {
      final rxWithAllergy = await rxRepo.createManualPrescription({
        'doctor_name': 'Dr. Gregory House',
        'medicines': [
          {
            'medicine_name': 'Amoxicillin 500mg',
            'dosage': '1 capsule',
            'frequency': '1-0-1',
            'duration_days': 7,
            'food_timing': 'AFTER_FOOD',
          }
        ],
      });

      final safety = await rxRepo.checkSafety(rxWithAllergy.id);
      expect(safety.isSafe, isFalse);
      expect(safety.warnings.any((w) => w.contains('Penicillin') && w.contains('Amoxicillin')), isTrue);
    });

    test('explicit confirmation transitions to CONFIRMED and activates schedules & doses', () async {
      final rx = await rxRepo.createManualPrescription({
        'doctor_name': 'Dr. Bruce Banner',
        'medicines': [
          {
            'medicine_name': 'Ibuprofen 400mg',
            'dosage': '1 tablet',
            'frequency': 'Twice daily',
            'duration_days': 5,
            'food_timing': 'AFTER_FOOD',
          }
        ],
      });

      await rxRepo.submitForConfirmation(rx.id);
      final confirmed = await rxRepo.confirmPrescription(rx.id);

      expect(confirmed.status, PrescriptionStatus.confirmed);

      // Verify active schedules exist
      final schedules = await db.select(db.medicineSchedules).get();
      final active = schedules.where((s) => s.prescriptionId == rx.id && s.isActive);
      expect(active, isNotEmpty);

      // Verify dose events were generated
      final doses = await db.select(db.doseEvents).get();
      final rxDoses = doses.where((d) => d.prescriptionId == rx.id);
      expect(rxDoses, isNotEmpty);
    });
  });

  group('3. Medicine Dose Tracking', () {
    test('markDoseTaken updates status to TAKEN and sets takenAt', () async {
      final today = await medRepo.getTodayDoses();
      final scheduledDose = today.firstWhere((d) => d.status == DoseStatus.scheduled, orElse: () => today.first);

      final updated = await medRepo.markDoseTaken(scheduledDose.id);
      expect(updated.status, DoseStatus.taken);
      expect(updated.takenAt, isNotNull);

      final history = await medRepo.getHistoryDoses();
      expect(history.any((d) => d.id == scheduledDose.id && d.status == DoseStatus.taken), isTrue);
    });

    test('markDoseSkipped updates status to SKIPPED and sets skippedAt', () async {
      final today = await medRepo.getTodayDoses();
      final scheduledDose = today.firstWhere((d) => d.status == DoseStatus.scheduled, orElse: () => today.first);

      final updated = await medRepo.markDoseSkipped(scheduledDose.id);
      expect(updated.status, DoseStatus.skipped);
      expect(updated.skippedAt, isNotNull);

      final history = await medRepo.getHistoryDoses();
      expect(history.any((d) => d.id == scheduledDose.id && d.status == DoseStatus.skipped), isTrue);
    });
  });

  group('4. Appointments Persistence & Operations', () {
    test('saves and retrieves scheduled appointments', () async {
      final appt = await aptRepo.createAppointment({
        'doctor_name': 'Dr. Meredith Grey',
        'clinic_name': 'Grey Sloan Memorial',
        'appointment_datetime': DateTime.now().add(const Duration(days: 4)).toIso8601String(),
        'notes': 'Post-op consultation',
      });

      expect(appt.doctorName, 'Dr. Meredith Grey');
      expect(appt.status, AppointmentStatus.scheduled);

      final upcoming = await aptRepo.getAppointments(filter: 'upcoming');
      expect(upcoming.any((a) => a.id == appt.id), isTrue);
    });

    test('completes appointment and moves to past filter', () async {
      final appt = await aptRepo.createAppointment({
        'doctor_name': 'Dr. Derek Shepherd',
        'clinic_name': 'Neurology Clinic',
        'appointment_datetime': DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      });

      final completed = await aptRepo.completeAppointment(appt.id);
      expect(completed.status, AppointmentStatus.completed);

      final past = await aptRepo.getAppointments(filter: 'past');
      expect(past.any((a) => a.id == appt.id), isTrue);
    });
  });

  group('5. Allergies and Family Profiles Persistence', () {
    test('adds, retrieves, and removes allergies', () async {
      final newAllergy = Allergy(
        id: 'a-test-1',
        name: 'Aspirin',
        severity: 'Low',
        reaction: 'Mild rash',
      );

      await profileRepo.addAllergy(newAllergy);
      var allergies = await profileRepo.getAllergies();
      expect(allergies.any((a) => a.id == 'a-test-1' && a.name == 'Aspirin'), isTrue);

      await profileRepo.removeAllergy('a-test-1');
      allergies = await profileRepo.getAllergies();
      expect(allergies.any((a) => a.id == 'a-test-1'), isFalse);
    });

    test('adds and retrieves family members', () async {
      final member = FamilyMember(
        id: 'f-test-1',
        name: 'Alice Doe',
        relation: 'Daughter',
        dateOfBirth: '2015-08-20',
      );

      await profileRepo.addFamilyMember(member);
      final family = await profileRepo.getFamilyMembers();
      expect(family.any((f) => f.id == 'f-test-1' && f.name == 'Alice Doe'), isTrue);
    });
  });

  group('6. Deleting Records Safely', () {
    test('deletes appointment cleanly', () async {
      final appt = await aptRepo.createAppointment({
        'doctor_name': 'Dr. To Delete',
        'appointment_datetime': DateTime.now().toIso8601String(),
      });

      await aptRepo.deleteAppointment(appt.id);
      final upcoming = await aptRepo.getAppointments(filter: 'upcoming');
      expect(upcoming.any((a) => a.id == appt.id), isFalse);
    });

    test('deletes prescription with cascade delete', () async {
      final rx = await rxRepo.createManualPrescription({
        'doctor_name': 'Dr. Cascade Test',
        'medicines': [
          {
            'medicine_name': 'Test Med',
            'dosage': '1',
            'frequency': '1-0-0',
            'duration_days': 2,
          }
        ],
      });

      await rxRepo.deletePrescription(rx.id);
      final all = await rxRepo.getPrescriptions();
      expect(all.any((p) => p.id == rx.id), isFalse);

      final meds = await db.select(db.prescriptionMedicines).get();
      expect(meds.any((m) => m.prescriptionId == rx.id), isFalse);
    });
  });

  group('7. Data Persistence Across Database Reopening', () {
    test('data remains intact after closing and reopening database file', () async {
      final tempDir = await Directory.systemTemp.createTemp('cureloop_db_test_');
      final dbFile = File('${tempDir.path}/test_persist.sqlite');

      // 1. Open first instance, modify data, and close
      var fileDb = AppDatabase(NativeDatabase(dbFile));
      await fileDb.customSelect('SELECT 1').get();

      var fileProfileRepo = SqliteProfileRepository(fileDb);
      var fileAptRepo = SqliteAppointmentRepository(fileDb);

      await fileProfileRepo.updateProfile(
        PatientProfile(
          id: 'p1',
          name: 'Jane Updated Doe',
          phone: '+1 555 999 8888',
          bloodGroup: 'AB+',
        ),
      );

      await fileAptRepo.createAppointment({
        'id': 'persisted-apt-1',
        'doctor_name': 'Dr. Persisted',
        'clinic_name': 'Permanent Clinic',
        'appointment_datetime': DateTime.now().add(const Duration(days: 10)).toIso8601String(),
        'notes': 'Persistent data test',
      });

      await fileDb.close();

      // 2. Open second instance on the exact same SQLite file
      fileDb = AppDatabase(NativeDatabase(dbFile));
      await fileDb.customSelect('SELECT 1').get();

      fileProfileRepo = SqliteProfileRepository(fileDb);
      fileAptRepo = SqliteAppointmentRepository(fileDb);

      final reopenedProfile = await fileProfileRepo.getProfile();
      expect(reopenedProfile.name, 'Jane Updated Doe');
      expect(reopenedProfile.phone, '+1 555 999 8888');
      expect(reopenedProfile.bloodGroup, 'AB+');

      final reopenedApt = await fileAptRepo.getAppointment('persisted-apt-1');
      expect(reopenedApt.doctorName, 'Dr. Persisted');
      expect(reopenedApt.clinicName, 'Permanent Clinic');
      expect(reopenedApt.notes, 'Persistent data test');

      await fileDb.close();
      await tempDir.delete(recursive: true);
    });
  });
}
