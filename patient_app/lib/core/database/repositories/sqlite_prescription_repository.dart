import 'dart:io';
import '../../../features/prescriptions/data/models/prescription_models.dart';
import '../../../features/prescriptions/data/prescription_repository.dart';
import '../app_database.dart';
import '../daos/prescription_dao.dart';
import '../daos/medicine_dao.dart';

class SqlitePrescriptionRepository implements IPrescriptionRepository {
  final PrescriptionDao _dao;
  final MedicineDao _medDao;

  SqlitePrescriptionRepository(AppDatabase db)
      : _dao = PrescriptionDao(db),
        _medDao = MedicineDao(db);

  PrescriptionStatus _parseStatus(String status) {
    switch (status) {
      case 'DRAFT':
        return PrescriptionStatus.draft;
      case 'PENDING_CONFIRMATION':
        return PrescriptionStatus.pendingConfirmation;
      case 'CONFIRMED':
        return PrescriptionStatus.confirmed;
      default:
        return PrescriptionStatus.unknown;
    }
  }

  FoodTiming? _parseFoodTiming(String? timing) {
    if (timing == null) return null;
    switch (timing.toUpperCase()) {
      case 'BEFORE_FOOD':
      case 'BEFOREFOOD':
      case 'BEFORE':
        return FoodTiming.beforeFood;
      case 'AFTER_FOOD':
      case 'AFTERFOOD':
      case 'AFTER':
        return FoodTiming.afterFood;
      case 'WITH_FOOD':
      case 'WITHFOOD':
      case 'WITH':
        return FoodTiming.withFood;
      case 'NO_INSTRUCTION':
      case 'NOINSTRUCTION':
      case 'NONE':
        return FoodTiming.noInstruction;
      default:
        return FoodTiming.noInstruction;
    }
  }

  Prescription _toModel(PrescriptionWithMedicines pwm) {
    return Prescription(
      id: pwm.prescription.id,
      patientId: pwm.prescription.patientId,
      status: _parseStatus(pwm.prescription.status),
      doctorName: pwm.prescription.doctorName,
      clinicName: pwm.prescription.clinicName,
      prescriptionDate: pwm.prescription.prescriptionDate,
      notes: pwm.prescription.notes,
      medicines: pwm.medicines.map((m) {
        return PrescriptionMedicine(
          id: m.id,
          prescriptionId: m.prescriptionId,
          medicineName: m.medicineName,
          dosage: m.dosage,
          frequency: m.frequency,
          durationDays: m.durationDays,
          foodTiming: _parseFoodTiming(m.foodTiming),
          instructions: m.instructions,
        );
      }).toList(),
    );
  }

  @override
  Future<List<Prescription>> getPrescriptions() async {
    final list = await _dao.getPrescriptions();
    return list.map(_toModel).toList();
  }

  @override
  Future<Prescription> getPrescription(String id) async {
    final pwm = await _dao.getPrescription(id);
    if (pwm == null) {
      throw Exception('Prescription not found: $id');
    }
    return _toModel(pwm);
  }

  @override
  Future<Prescription> createManualPrescription(Map<String, dynamic> data) async {
    final now = DateTime.now();
    final rxId = 'rx-${now.millisecondsSinceEpoch}';

    await _dao.insertPrescription(
      PrescriptionsCompanion(
        id: Value(rxId),
        patientId: Value(data['patient_id'] ?? 'p1'),
        doctorName: Value(data['doctor_name'] ?? 'Unknown Doctor'),
        clinicName: Value(data['clinic_name']),
        prescriptionDate: Value(data['prescription_date'] ?? now.toIso8601String()),
        notes: Value(data['notes']),
        status: const Value('DRAFT'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    final rawMeds = data['medicines'] as List<dynamic>? ?? [];
    for (int i = 0; i < rawMeds.length; i++) {
      final m = rawMeds[i] as Map<String, dynamic>;
      final medId = 'med-${now.millisecondsSinceEpoch}-$i';
      await _dao.insertMedicine(
        PrescriptionMedicinesCompanion(
          id: Value(medId),
          prescriptionId: Value(rxId),
          medicineName: Value(m['medicine_name'] ?? ''),
          dosage: Value(m['dosage'] ?? ''),
          frequency: Value(m['frequency'] ?? ''),
          durationDays: Value(m['duration_days'] is int ? m['duration_days'] : int.tryParse(m['duration_days']?.toString() ?? '')),
          foodTiming: Value(m['food_timing']?.toString() ?? 'NO_INSTRUCTION'),
          instructions: Value(m['instructions']),
          createdAt: Value(now),
        ),
      );
    }

    final created = await _dao.getPrescription(rxId);
    return _toModel(created!);
  }

  @override
  Future<Prescription> submitForConfirmation(String id) async {
    final pwm = await _dao.getPrescription(id);
    if (pwm == null) throw Exception('Prescription not found: $id');

    for (final med in pwm.medicines) {
      if (med.medicineName.trim().isEmpty ||
          med.dosage.trim().isEmpty ||
          med.frequency.trim().isEmpty ||
          med.durationDays == null) {
        throw Exception('Incomplete medication details in prescription.');
      }
    }

    await _dao.updatePrescription(
      id,
      PrescriptionsCompanion(
        status: const Value('PENDING_CONFIRMATION'),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final updated = await _dao.getPrescription(id);
    return _toModel(updated!);
  }

  @override
  Future<void> deletePrescription(String id) async {
    await _dao.deletePrescription(id);
  }

  @override
  Future<Prescription> confirmPrescription(String id) async {
    final pwm = await _dao.getPrescription(id);
    if (pwm == null) throw Exception('Prescription not found: $id');

    final now = DateTime.now();

    // 1. Update prescription status to CONFIRMED
    await _dao.updatePrescription(
      id,
      PrescriptionsCompanion(
        status: const Value('CONFIRMED'),
        updatedAt: Value(now),
      ),
    );

    // 2. Activate medicine schedule and create scheduled dose events
    for (int i = 0; i < pwm.medicines.length; i++) {
      final med = pwm.medicines[i];
      final schedId = 'sched-${med.id}';
      final freq = med.frequency.toLowerCase();
      final duration = med.durationDays ?? 30;

      int timesPerDay = 1;
      List<int> scheduledHours = [9]; // default 9 AM

      if (freq.contains('1-0-1') || freq.contains('twice') || freq.contains('2x') || freq.contains('bid')) {
        timesPerDay = 2;
        scheduledHours = [9, 21];
      } else if (freq.contains('1-1-1') || freq.contains('three') || freq.contains('3x') || freq.contains('tid')) {
        timesPerDay = 3;
        scheduledHours = [8, 14, 20];
      } else if (freq.contains('1-0-0') || freq.contains('0-1-0') || freq.contains('0-0-1') || freq.contains('once') || freq.contains('1x')) {
        timesPerDay = 1;
        scheduledHours = [9];
      } else if (freq.contains('weekly')) {
        timesPerDay = 1;
        scheduledHours = [9];
      }

      final startDate = now;
      final endDate = now.add(Duration(days: duration));

      await _medDao.insertSchedule(
        MedicineSchedulesCompanion(
          id: Value(schedId),
          prescriptionId: Value(id),
          prescriptionMedicineId: Value(med.id),
          medicineName: Value(med.medicineName),
          dosage: Value(med.dosage),
          frequency: Value(med.frequency),
          timesPerDay: Value(timesPerDay),
          startDate: Value(startDate),
          endDate: Value(endDate),
          isActive: const Value(true),
          createdAt: Value(now),
        ),
      );

      // Generate scheduled doses for the next 7 days (or duration)
      final daysToGenerate = duration < 7 ? duration : 7;
      for (int day = 0; day < daysToGenerate; day++) {
        for (final hour in scheduledHours) {
          final scheduledTime = DateTime(now.year, now.month, now.day + day, hour);
          final doseId = 'dose-${med.id}-$day-$hour';

          await _medDao.insertDoseEvent(
            DoseEventsCompanion(
              id: Value(doseId),
              prescriptionId: Value(id),
              prescriptionMedicineId: Value(med.id),
              scheduleId: Value(schedId),
              medicineName: Value(med.medicineName),
              dosage: Value(med.dosage),
              scheduledAt: Value(scheduledTime),
              status: const Value('SCHEDULED'),
              foodTiming: Value(med.foodTiming),
              createdAt: Value(now),
            ),
          );
        }
      }
    }

    final updated = await _dao.getPrescription(id);
    return _toModel(updated!);
  }

  @override
  Future<SafetyResult> checkSafety(String id) async {
    final pwm = await _dao.getPrescription(id);
    if (pwm == null) throw Exception('Prescription not found: $id');

    final allergies = await _dao.getPatientAllergies('p1');
    final warnings = <String>[];

    for (final med in pwm.medicines) {
      final medNameLower = med.medicineName.toLowerCase();
      for (final allergy in allergies) {
        final allergyNameLower = allergy.name.toLowerCase();

        // Check exact or cross-reactivity (Penicillin / Amoxicillin)
        final isCrossAllergy = (allergyNameLower.contains('penicillin') && medNameLower.contains('amoxicillin')) ||
            (allergyNameLower.contains('amoxicillin') && medNameLower.contains('penicillin'));

        final isDirectMatch = medNameLower.contains(allergyNameLower) || allergyNameLower.contains(medNameLower);

        if (isCrossAllergy || isDirectMatch) {
          warnings.add('You have a logged allergy to ${allergy.name}. This prescription contains ${med.medicineName}.');
        }
      }
    }

    if (warnings.isNotEmpty) {
      return SafetyResult(
        isSafe: false,
        warnings: warnings,
        disclaimer: 'Please verify this medication with a qualified healthcare professional before proceeding.',
      );
    }

    return SafetyResult(isSafe: true, warnings: const []);
  }

  @override
  Future<OCRExtractionResponse> uploadOcrImage(File file) async {
    // Generate deterministic simulated OCR extraction
    final now = DateTime.now();
    final prescriptionId = 'ocr-${now.millisecondsSinceEpoch}';

    // Persist the draft prescription in SQLite
    await _dao.insertPrescription(
      PrescriptionsCompanion(
        id: Value(prescriptionId),
        patientId: const Value('p1'),
        doctorName: const Value('Dr. Ramesh Sharma'),
        clinicName: const Value('Apollo Clinic'),
        prescriptionDate: Value(now.toIso8601String()),
        notes: const Value('Extracted via OCR'),
        status: const Value('DRAFT'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    final medId = 'ocr-med-${now.millisecondsSinceEpoch}';
    await _dao.insertMedicine(
      PrescriptionMedicinesCompanion(
        id: Value(medId),
        prescriptionId: Value(prescriptionId),
        medicineName: const Value('Amoxicillin 500mg'),
        dosage: const Value('1 capsule'),
        frequency: const Value('Three times daily'),
        durationDays: const Value(7),
        foodTiming: const Value('WITH_FOOD'),
        instructions: const Value('With or after food'),
        createdAt: Value(now),
      ),
    );

    return OCRExtractionResponse(
      prescriptionId: prescriptionId,
      documentKey: 'doc-${now.millisecondsSinceEpoch}',
      doctorName: 'Dr. Ramesh Sharma',
      providerName: 'Local SQLite OCR',
      rawText: 'Amoxicillin 500mg 1 cap 3x daily with food',
      medicines: [
        CandidateMedicine(
          medicineName: ExtractedField(value: 'Amoxicillin 500mg', confidence: 'HIGH'),
          dosage: ExtractedField(value: '1 capsule', confidence: 'HIGH'),
          frequency: ExtractedField(value: 'Three times daily', confidence: 'HIGH'),
          durationDays: ExtractedField(value: 7, confidence: 'HIGH'),
          foodTiming: ExtractedField(value: 'With or after food', confidence: 'HIGH'),
        ),
      ],
    );
  }

  @override
  Future<Prescription> updatePrescription(String id, Map<String, dynamic> data) async {
    await _dao.updatePrescription(
      id,
      PrescriptionsCompanion(
        doctorName: data['doctor_name'] != null ? Value(data['doctor_name']) : const Value.absent(),
        clinicName: data['clinic_name'] != null ? Value(data['clinic_name']) : const Value.absent(),
        prescriptionDate: data['prescription_date'] != null ? Value(data['prescription_date']) : const Value.absent(),
        notes: data['notes'] != null ? Value(data['notes']) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final updated = await _dao.getPrescription(id);
    return _toModel(updated!);
  }

  @override
  Future<Prescription> updatePrescriptionMedicine(String id, String medId, Map<String, dynamic> data) async {
    await _dao.updateMedicine(
      medId,
      PrescriptionMedicinesCompanion(
        medicineName: data['medicine_name'] != null ? Value(data['medicine_name']) : const Value.absent(),
        dosage: data['dosage'] != null ? Value(data['dosage']) : const Value.absent(),
        frequency: data['frequency'] != null ? Value(data['frequency']) : const Value.absent(),
        durationDays: data['duration_days'] != null
            ? Value(data['duration_days'] is int ? data['duration_days'] : int.tryParse(data['duration_days'].toString()))
            : const Value.absent(),
        foodTiming: data['food_timing'] != null ? Value(data['food_timing'].toString()) : const Value.absent(),
        instructions: data['instructions'] != null ? Value(data['instructions']) : const Value.absent(),
      ),
    );

    final updated = await _dao.getPrescription(id);
    return _toModel(updated!);
  }
}
