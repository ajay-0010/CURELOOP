import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/config/dev_config.dart';
import 'dart:io';
import 'models/prescription_models.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/repositories/sqlite_prescription_repository.dart';

part 'prescription_repository.g.dart';

abstract class IPrescriptionRepository {
  Future<List<Prescription>> getPrescriptions();
  Future<Prescription> getPrescription(String id);
  Future<Prescription> createManualPrescription(Map<String, dynamic> data);
  Future<Prescription> submitForConfirmation(String id);
  Future<void> deletePrescription(String id);
  Future<Prescription> confirmPrescription(String id);
  Future<SafetyResult> checkSafety(String id);
  Future<OCRExtractionResponse> uploadOcrImage(File file);
  Future<Prescription> updatePrescription(String id, Map<String, dynamic> data);
  Future<Prescription> updatePrescriptionMedicine(String id, String medId, Map<String, dynamic> data);
}

class HttpPrescriptionRepository implements IPrescriptionRepository {
  final Dio _dio;
  HttpPrescriptionRepository(this._dio);

  @override
  Future<List<Prescription>> getPrescriptions() async {
    final response = await _dio.get('/prescriptions');
    return (response.data as List).map((e) => Prescription.fromJson(e)).toList();
  }

  @override
  Future<Prescription> getPrescription(String id) async {
    final response = await _dio.get('/prescriptions/$id');
    return Prescription.fromJson(response.data);
  }

  @override
  Future<Prescription> createManualPrescription(Map<String, dynamic> data) async {
    final response = await _dio.post('/prescriptions', data: data);
    return Prescription.fromJson(response.data);
  }

  @override
  Future<Prescription> submitForConfirmation(String id) async {
    final response = await _dio.post('/prescriptions/$id/submit-for-confirmation');
    return Prescription.fromJson(response.data);
  }

  @override
  Future<void> deletePrescription(String id) async {
    await _dio.delete('/prescriptions/$id');
  }

  @override
  Future<Prescription> confirmPrescription(String id) async {
    final response = await _dio.post('/prescriptions/$id/confirm');
    return Prescription.fromJson(response.data);
  }

  @override
  Future<SafetyResult> checkSafety(String id) async {
    final response = await _dio.get('/prescriptions/$id/safety-check');
    return SafetyResult.fromJson(response.data);
  }

  @override
  Future<OCRExtractionResponse> uploadOcrImage(File file) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
    });
    final response = await _dio.post('/prescriptions/ocr', data: formData);
    return OCRExtractionResponse.fromJson(response.data);
  }

  @override
  Future<Prescription> updatePrescription(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('/prescriptions/$id', data: data);
    return Prescription.fromJson(response.data);
  }

  @override
  Future<Prescription> updatePrescriptionMedicine(String id, String medId, Map<String, dynamic> data) async {
    final response = await _dio.put('/prescriptions/$id/medicines/$medId', data: data);
    return Prescription.fromJson(response.data);
  }
}

@riverpod
IPrescriptionRepository prescriptionRepository(PrescriptionRepositoryRef ref) {
  if (kFrontendDemoMode) {
    final db = ref.watch(appDatabaseProvider);
    return SqlitePrescriptionRepository(db);
  }
  return HttpPrescriptionRepository(ref.watch(dioClientProvider));
}
