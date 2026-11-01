import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/config/dev_config.dart';
import 'models/medicine_models.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/repositories/sqlite_medicine_repository.dart';

part 'medicine_repository.g.dart';

abstract class IMedicineRepository {
  Future<List<DoseEvent>> getTodayDoses();
  Future<List<DoseEvent>> getUpcomingDoses();
  Future<List<DoseEvent>> getHistoryDoses();
  Future<DoseEvent> markDoseTaken(String id);
  Future<DoseEvent> markDoseSkipped(String id);
}

class HttpMedicineRepository implements IMedicineRepository {
  final Dio _dio;

  HttpMedicineRepository(this._dio);

  @override
  Future<List<DoseEvent>> getTodayDoses() async {
    final response = await _dio.get('/doses/today');
    return (response.data as List).map((e) => DoseEvent.fromJson(e)).toList();
  }

  @override
  Future<List<DoseEvent>> getUpcomingDoses() async {
    final response = await _dio.get('/doses/upcoming');
    return (response.data as List).map((e) => DoseEvent.fromJson(e)).toList();
  }

  @override
  Future<List<DoseEvent>> getHistoryDoses() async {
    final response = await _dio.get('/doses/history');
    return (response.data as List).map((e) => DoseEvent.fromJson(e)).toList();
  }

  @override
  Future<DoseEvent> markDoseTaken(String id) async {
    final response = await _dio.post('/doses/$id/taken');
    return DoseEvent.fromJson(response.data);
  }

  @override
  Future<DoseEvent> markDoseSkipped(String id) async {
    final response = await _dio.post('/doses/$id/skip');
    return DoseEvent.fromJson(response.data);
  }
}

@riverpod
IMedicineRepository medicineRepository(MedicineRepositoryRef ref) {
  if (kFrontendDemoMode) {
    final db = ref.watch(appDatabaseProvider);
    return SqliteMedicineRepository(db);
  }
  return HttpMedicineRepository(ref.watch(dioClientProvider));
}
