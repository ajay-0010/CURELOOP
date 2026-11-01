import 'package:drift/drift.dart';
export 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tables.dart';
import 'connection/connection.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  PatientProfiles,
  Prescriptions,
  PrescriptionMedicines,
  MedicineSchedules,
  DoseEvents,
  Appointments,
  Allergies,
  FamilyMembers,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
      final count = await (select(patientProfiles)..limit(1)).get();
      if (count.isEmpty) {
        await seedInitialData();
      }
    },
  );

  Future<void> seedInitialData() async {
    final now = DateTime.now();

    // 1. Patient Profile
    await into(patientProfiles).insert(
      PatientProfilesCompanion.insert(
        id: 'p1',
        name: 'Jane Doe',
        phone: const Value('+1 555 123 4567'),
        email: const Value('jane.doe@example.com'),
        dateOfBirth: const Value('1985-04-12'),
        bloodGroup: const Value('O+'),
        emergencyContactName: const Value('John Doe'),
        emergencyContactPhone: const Value('+1 555 987 6543'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );

    // 2. Allergies
    await into(allergies).insert(
      AllergiesCompanion.insert(
        id: 'a1',
        patientId: const Value('p1'),
        name: 'Penicillin',
        severity: 'High',
        reaction: const Value('Anaphylaxis'),
        createdAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(allergies).insert(
      AllergiesCompanion.insert(
        id: 'a2',
        patientId: const Value('p1'),
        name: 'Peanuts',
        severity: 'Medium',
        reaction: const Value('Hives'),
        createdAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );

    // 3. Family Members
    await into(familyMembers).insert(
      FamilyMembersCompanion.insert(
        id: 'f1',
        patientId: const Value('p1'),
        name: 'John Doe',
        relation: 'Spouse',
        dateOfBirth: const Value('1983-06-15'),
        createdAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(familyMembers).insert(
      FamilyMembersCompanion.insert(
        id: 'f2',
        patientId: const Value('p1'),
        name: 'Jimmy Doe',
        relation: 'Son',
        dateOfBirth: const Value('2010-09-01'),
        createdAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );

    // 4. Initial Confirmed Prescription
    final rxDate = now.subtract(const Duration(days: 10));
    await into(prescriptions).insert(
      PrescriptionsCompanion.insert(
        id: 'demo-rx-1',
        patientId: 'p1',
        doctorName: const Value('Dr. Sharma'),
        clinicName: const Value('General Hospital'),
        prescriptionDate: rxDate.toIso8601String(),
        notes: const Value('Regular follow up'),
        status: 'CONFIRMED',
        createdAt: Value(rxDate),
        updatedAt: Value(rxDate),
      ),
      mode: InsertMode.insertOrReplace,
    );

    // 5. Prescription Medicines
    await into(prescriptionMedicines).insert(
      PrescriptionMedicinesCompanion.insert(
        id: 'demo-med-1',
        prescriptionId: 'demo-rx-1',
        medicineName: 'Metformin 500mg',
        dosage: '1 tablet',
        frequency: 'Twice daily',
        durationDays: const Value(30),
        foodTiming: const Value('BEFORE_FOOD'),
        instructions: const Value('Before breakfast and dinner'),
        createdAt: Value(rxDate),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(prescriptionMedicines).insert(
      PrescriptionMedicinesCompanion.insert(
        id: 'demo-med-2',
        prescriptionId: 'demo-rx-1',
        medicineName: 'Amlodipine 5mg',
        dosage: '1 tablet',
        frequency: 'Once daily',
        durationDays: const Value(30),
        foodTiming: const Value('AFTER_FOOD'),
        instructions: const Value('Morning after breakfast'),
        createdAt: Value(rxDate),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(prescriptionMedicines).insert(
      PrescriptionMedicinesCompanion.insert(
        id: 'demo-med-3',
        prescriptionId: 'demo-rx-1',
        medicineName: 'Vitamin D3',
        dosage: '1 capsule',
        frequency: 'Weekly',
        durationDays: const Value(60),
        foodTiming: const Value('AFTER_FOOD'),
        instructions: const Value('Once a week on Sunday'),
        createdAt: Value(rxDate),
      ),
      mode: InsertMode.insertOrReplace,
    );

    // 6. Active Medicine Schedules for confirmed prescription
    await into(medicineSchedules).insert(
      MedicineSchedulesCompanion.insert(
        id: 'sched-1',
        prescriptionId: 'demo-rx-1',
        prescriptionMedicineId: 'demo-med-1',
        medicineName: 'Metformin 500mg',
        dosage: '1 tablet',
        frequency: 'Twice daily',
        timesPerDay: const Value(2),
        startDate: rxDate,
        endDate: Value(rxDate.add(const Duration(days: 30))),
        isActive: const Value(true),
        createdAt: Value(rxDate),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(medicineSchedules).insert(
      MedicineSchedulesCompanion.insert(
        id: 'sched-2',
        prescriptionId: 'demo-rx-1',
        prescriptionMedicineId: 'demo-med-2',
        medicineName: 'Amlodipine 5mg',
        dosage: '1 tablet',
        frequency: 'Once daily',
        timesPerDay: const Value(1),
        startDate: rxDate,
        endDate: Value(rxDate.add(const Duration(days: 30))),
        isActive: const Value(true),
        createdAt: Value(rxDate),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(medicineSchedules).insert(
      MedicineSchedulesCompanion.insert(
        id: 'sched-3',
        prescriptionId: 'demo-rx-1',
        prescriptionMedicineId: 'demo-med-3',
        medicineName: 'Vitamin D3',
        dosage: '1 capsule',
        frequency: 'Weekly',
        timesPerDay: const Value(1),
        startDate: rxDate,
        endDate: Value(rxDate.add(const Duration(days: 60))),
        isActive: const Value(true),
        createdAt: Value(rxDate),
      ),
      mode: InsertMode.insertOrReplace,
    );

    // 7. Dose Events
    await into(doseEvents).insert(
      DoseEventsCompanion.insert(
        id: 'dose-1',
        prescriptionId: 'demo-rx-1',
        prescriptionMedicineId: 'demo-med-1',
        scheduleId: const Value('sched-1'),
        medicineName: 'Metformin 500mg',
        dosage: '1 tablet',
        scheduledAt: now.subtract(const Duration(hours: 1)),
        status: 'TAKEN',
        foodTiming: const Value('BEFORE_FOOD'),
        takenAt: Value(now.subtract(const Duration(minutes: 50))),
        createdAt: Value(now.subtract(const Duration(hours: 1))),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(doseEvents).insert(
      DoseEventsCompanion.insert(
        id: 'dose-2',
        prescriptionId: 'demo-rx-1',
        prescriptionMedicineId: 'demo-med-2',
        scheduleId: const Value('sched-2'),
        medicineName: 'Amlodipine 5mg',
        dosage: '1 tablet',
        scheduledAt: now.add(const Duration(hours: 2)),
        status: 'SCHEDULED',
        foodTiming: const Value('AFTER_FOOD'),
        createdAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(doseEvents).insert(
      DoseEventsCompanion.insert(
        id: 'dose-3',
        prescriptionId: 'demo-rx-1',
        prescriptionMedicineId: 'demo-med-3',
        scheduleId: const Value('sched-3'),
        medicineName: 'Vitamin D3',
        dosage: '1 capsule',
        scheduledAt: now.add(const Duration(hours: 8)),
        status: 'SCHEDULED',
        foodTiming: const Value('AFTER_FOOD'),
        createdAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );

    // 8. Appointments
    await into(appointments).insert(
      AppointmentsCompanion.insert(
        id: 'demo-apt-1',
        patientId: 'p1',
        doctorName: 'Dr. Sharma',
        clinicName: const Value('Cardiology Clinic'),
        appointmentDatetime: now.add(const Duration(days: 3)),
        status: 'scheduled',
        notes: const Value('Routine cardiac checkup'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
      mode: InsertMode.insertOrReplace,
    );
    await into(appointments).insert(
      AppointmentsCompanion.insert(
        id: 'demo-apt-2',
        patientId: 'p1',
        doctorName: 'Dr. Gupta',
        clinicName: const Value('General Practice'),
        appointmentDatetime: now.subtract(const Duration(days: 15)),
        status: 'completed',
        notes: const Value('Annual wellness visit'),
        createdAt: Value(now.subtract(const Duration(days: 15))),
        updatedAt: Value(now.subtract(const Duration(days: 15))),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
