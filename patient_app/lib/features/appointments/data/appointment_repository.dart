import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/config/dev_config.dart';
import 'models/appointment_models.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/repositories/sqlite_appointment_repository.dart';

part 'appointment_repository.g.dart';

abstract class IAppointmentRepository {
  Future<Appointment> createAppointment(Map<String, dynamic> data);
  Future<List<Appointment>> getAppointments({required String filter});
  Future<Appointment> getAppointment(String id);
  Future<Appointment> updateAppointment(String id, Map<String, dynamic> data);
  Future<void> deleteAppointment(String id);
  Future<Appointment> completeAppointment(String id);
}

class HttpAppointmentRepository implements IAppointmentRepository {
  final Dio _dio;

  HttpAppointmentRepository(this._dio);

  @override
  Future<Appointment> createAppointment(Map<String, dynamic> data) async {
    final response = await _dio.post('/appointments', data: data);
    return Appointment.fromJson(response.data);
  }

  @override
  Future<List<Appointment>> getAppointments({required String filter}) async {
    final response = await _dio.get('/appointments', queryParameters: {'filter': filter});
    return (response.data as List).map((e) => Appointment.fromJson(e)).toList();
  }

  @override
  Future<Appointment> getAppointment(String id) async {
    final response = await _dio.get('/appointments/$id');
    return Appointment.fromJson(response.data);
  }

  @override
  Future<Appointment> updateAppointment(String id, Map<String, dynamic> data) async {
    final response = await _dio.put('/appointments/$id', data: data);
    return Appointment.fromJson(response.data);
  }

  @override
  Future<void> deleteAppointment(String id) async {
    await _dio.delete('/appointments/$id');
  }

  @override
  Future<Appointment> completeAppointment(String id) async {
    final response = await _dio.post('/appointments/$id/complete');
    return Appointment.fromJson(response.data);
  }
}

@riverpod
IAppointmentRepository appointmentRepository(AppointmentRepositoryRef ref) {
  if (kFrontendDemoMode) {
    final db = ref.watch(appDatabaseProvider);
    return SqliteAppointmentRepository(db);
  }
  return HttpAppointmentRepository(ref.watch(dioClientProvider));
}
