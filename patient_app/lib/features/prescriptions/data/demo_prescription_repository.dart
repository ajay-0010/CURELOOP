import 'dart:io';
import 'prescription_repository.dart';
import 'models/prescription_models.dart';

class DemoPrescriptionRepository implements IPrescriptionRepository {
  final List<Prescription> _prescriptions = [
    Prescription(
      id: 'demo-rx-1',
      patientId: 'demo-patient',
      doctorName: 'Dr. Sharma',
      status: PrescriptionStatus.confirmed,
      prescriptionDate: DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      medicines: [
        PrescriptionMedicine(
          id: 'demo-med-1',
          medicineName: 'Metformin 500mg',
          dosage: '1 tablet',
          frequency: 'Twice daily',
          durationDays: 30,
          foodTiming: FoodTiming.beforeFood,
        ),
      ],
    ),
  ];

  @override
  Future<List<Prescription>> getPrescriptions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _prescriptions.toList();
  }

  @override
  Future<Prescription> getPrescription(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _prescriptions.firstWhere((p) => p.id == id);
  }

  @override
  Future<Prescription> createManualPrescription(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final rx = Prescription(
      id: 'rx-${DateTime.now().millisecondsSinceEpoch}',
      patientId: 'demo-patient',
      doctorName: data['doctor_name'] ?? 'Unknown Doctor',
      status: PrescriptionStatus.draft,
      prescriptionDate: DateTime.now().toIso8601String(),
      medicines: [],
    );
    _prescriptions.insert(0, rx);
    return rx;
  }

  @override
  Future<Prescription> submitForConfirmation(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _prescriptions.indexWhere((p) => p.id == id);
    final current = _prescriptions[index];
    final updated = Prescription(
      id: current.id,
      patientId: current.patientId,
      doctorName: current.doctorName,
      clinicName: current.clinicName,
      prescriptionDate: current.prescriptionDate,
      notes: current.notes,
      medicines: current.medicines,
      status: PrescriptionStatus.pendingConfirmation,
    );
    _prescriptions[index] = updated;
    return updated;
  }

  @override
  Future<void> deletePrescription(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _prescriptions.removeWhere((p) => p.id == id);
  }

  @override
  Future<Prescription> confirmPrescription(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _prescriptions.indexWhere((p) => p.id == id);
    final current = _prescriptions[index];
    final updated = Prescription(
      id: current.id,
      patientId: current.patientId,
      doctorName: current.doctorName,
      clinicName: current.clinicName,
      prescriptionDate: current.prescriptionDate,
      notes: current.notes,
      medicines: current.medicines,
      status: PrescriptionStatus.confirmed,
    );
    _prescriptions[index] = updated;
    return updated;
  }

  @override
  Future<SafetyResult> checkSafety(String id) async {
    await Future.delayed(const Duration(milliseconds: 600));
    // Simulate an allergy alert for demo purposes
    return SafetyResult(
      isSafe: false,
      warnings: [
        'You have a logged allergy to Penicillin. This prescription contains Amoxicillin.',
      ],
    );
  }

  @override
  Future<OCRExtractionResponse> uploadOcrImage(File file) async {
    await Future.delayed(const Duration(seconds: 2));
    return OCRExtractionResponse(
      prescriptionId: 'ocr-${DateTime.now().millisecondsSinceEpoch}',
      documentKey: 'demo-doc-key',
      doctorName: 'Dr. Ramesh Sharma',
      providerName: 'Local OCR Demo',
      rawText: 'Amoxicillin 500mg 1 cap 3x daily with food',
      medicines: [
        CandidateMedicine(
          medicineName: ExtractedField(value: 'Amoxicillin 500mg', confidence: '0.95'),
          dosage: ExtractedField(value: '1 capsule', confidence: '0.90'),
          frequency: ExtractedField(value: 'Three times daily', confidence: '0.92'),
          durationDays: ExtractedField(value: 7, confidence: '0.85'),
          foodTiming: ExtractedField(value: 'With or after food', confidence: '0.88'),
        ),
      ],
    );
  }

  @override
  Future<Prescription> updatePrescription(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _prescriptions.indexWhere((p) => p.id == id);
    final current = _prescriptions[index];
    final updated = Prescription(
      id: current.id,
      patientId: current.patientId,
      doctorName: data['doctor_name'] ?? current.doctorName,
      clinicName: data['clinic_name'] ?? current.clinicName,
      prescriptionDate: data['prescription_date'] ?? current.prescriptionDate,
      notes: data['notes'] ?? current.notes,
      medicines: current.medicines,
      status: current.status,
    );
    _prescriptions[index] = updated;
    return updated;
  }

  @override
  Future<Prescription> updatePrescriptionMedicine(String id, String medId, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _prescriptions.firstWhere((p) => p.id == id); // Simplified for demo
  }
}
