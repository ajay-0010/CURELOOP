import '../../../features/appointments/data/appointment_repository.dart';
import '../../../features/appointments/data/models/appointment_models.dart';
import '../app_database.dart';
import '../daos/appointment_dao.dart';

class SqliteAppointmentRepository implements IAppointmentRepository {
  final AppointmentDao _dao;

  SqliteAppointmentRepository(AppDatabase db) : _dao = AppointmentDao(db);

  Appointment _toModel(AppointmentEntity data) {
    AppointmentStatus status;
    switch (data.status) {
      case 'scheduled':
        status = AppointmentStatus.scheduled;
        break;
      case 'completed':
        status = AppointmentStatus.completed;
        break;
      case 'cancelled':
        status = AppointmentStatus.cancelled;
        break;
      default:
        status = AppointmentStatus.unknown;
    }

    return Appointment(
      id: data.id,
      patientId: data.patientId,
      doctorName: data.doctorName,
      clinicName: data.clinicName,
      appointmentDatetime: data.appointmentDatetime,
      timezone: data.timezone,
      notes: data.notes,
      status: status,
    );
  }

  @override
  Future<Appointment> createAppointment(Map<String, dynamic> data) async {
    final now = DateTime.now();
    final id = data['id'] ?? 'apt-${now.millisecondsSinceEpoch}';
    final dt = data['appointment_datetime'] is DateTime
        ? (data['appointment_datetime'] as DateTime)
        : DateTime.parse(data['appointment_datetime'].toString());

    await _dao.insertAppointment(
      AppointmentsCompanion(
        id: Value(id),
        patientId: Value(data['patient_id'] ?? 'p1'),
        doctorName: Value(data['doctor_name'] ?? 'Doctor'),
        clinicName: Value(data['clinic_name']),
        appointmentDatetime: Value(dt),
        timezone: Value(data['timezone']),
        notes: Value(data['notes']),
        status: const Value('scheduled'),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );

    final created = await _dao.getAppointment(id);
    return _toModel(created!);
  }

  @override
  Future<List<Appointment>> getAppointments({required String filter}) async {
    final rows = await _dao.getAppointments(filter: filter);
    return rows.map(_toModel).toList();
  }

  @override
  Future<Appointment> getAppointment(String id) async {
    final row = await _dao.getAppointment(id);
    if (row == null) {
      throw Exception('Appointment not found: $id');
    }
    return _toModel(row);
  }

  @override
  Future<Appointment> updateAppointment(String id, Map<String, dynamic> data) async {
    final existing = await _dao.getAppointment(id);
    if (existing == null) {
      throw Exception('Appointment not found: $id');
    }

    DateTime? dt;
    if (data['appointment_datetime'] != null) {
      dt = data['appointment_datetime'] is DateTime
          ? (data['appointment_datetime'] as DateTime)
          : DateTime.parse(data['appointment_datetime'].toString());
    }

    await _dao.updateAppointment(
      id,
      AppointmentsCompanion(
        doctorName: data['doctor_name'] != null ? Value(data['doctor_name']) : const Value.absent(),
        clinicName: data['clinic_name'] != null ? Value(data['clinic_name']) : const Value.absent(),
        appointmentDatetime: dt != null ? Value(dt) : const Value.absent(),
        timezone: data['timezone'] != null ? Value(data['timezone']) : const Value.absent(),
        notes: data['notes'] != null ? Value(data['notes']) : const Value.absent(),
        status: data['status'] != null ? Value(data['status']) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final updated = await _dao.getAppointment(id);
    return _toModel(updated!);
  }

  @override
  Future<void> deleteAppointment(String id) async {
    await _dao.deleteAppointment(id);
  }

  @override
  Future<Appointment> completeAppointment(String id) async {
    await _dao.updateAppointment(
      id,
      AppointmentsCompanion(
        status: const Value('completed'),
        updatedAt: Value(DateTime.now()),
      ),
    );
    final updated = await _dao.getAppointment(id);
    return _toModel(updated!);
  }
}
