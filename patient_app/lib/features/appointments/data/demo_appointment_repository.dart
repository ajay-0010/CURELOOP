import 'appointment_repository.dart';
import 'models/appointment_models.dart';

class DemoAppointmentRepository implements IAppointmentRepository {
  final List<Appointment> _appointments = [
    Appointment(
      id: 'demo-apt-1',
      patientId: 'demo-patient',
      doctorName: 'Dr. Sharma',
      clinicName: 'Cardiology Clinic',
      appointmentDatetime: DateTime.now().add(const Duration(days: 3)),
      status: AppointmentStatus.scheduled,
    ),
    Appointment(
      id: 'demo-apt-2',
      patientId: 'demo-patient',
      doctorName: 'Dr. Gupta',
      clinicName: 'General Practice',
      appointmentDatetime: DateTime.now().subtract(const Duration(days: 15)),
      status: AppointmentStatus.completed,
    ),
  ];

  @override
  Future<Appointment> createAppointment(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final apt = Appointment(
      id: 'apt-${DateTime.now().millisecondsSinceEpoch}',
      patientId: 'demo-patient',
      doctorName: data['doctor_name'] ?? 'Doctor',
      clinicName: data['clinic_name'],
      appointmentDatetime: DateTime.parse(data['appointment_datetime']),
      status: AppointmentStatus.scheduled,
    );
    _appointments.add(apt);
    return apt;
  }

  @override
  Future<List<Appointment>> getAppointments({required String filter}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (filter == 'upcoming') {
      return _appointments.where((a) => a.status == AppointmentStatus.scheduled).toList();
    } else {
      return _appointments.where((a) => a.status != AppointmentStatus.scheduled).toList();
    }
  }

  @override
  Future<Appointment> getAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _appointments.firstWhere((a) => a.id == id);
  }

  @override
  Future<Appointment> updateAppointment(String id, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _appointments.indexWhere((a) => a.id == id);
    final current = _appointments[index];
    final updated = Appointment(
      id: current.id,
      patientId: current.patientId,
      doctorName: data['doctor_name'] ?? current.doctorName,
      clinicName: data['clinic_name'] ?? current.clinicName,
      appointmentDatetime: data['appointment_datetime'] != null ? DateTime.parse(data['appointment_datetime']) : current.appointmentDatetime,
      timezone: current.timezone,
      notes: current.notes,
      status: current.status,
    );
    _appointments[index] = updated;
    return updated;
  }

  @override
  Future<void> deleteAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _appointments.removeWhere((a) => a.id == id);
  }

  @override
  Future<Appointment> completeAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _appointments.indexWhere((a) => a.id == id);
    final current = _appointments[index];
    final updated = Appointment(
      id: current.id,
      patientId: current.patientId,
      doctorName: current.doctorName,
      clinicName: current.clinicName,
      appointmentDatetime: current.appointmentDatetime,
      timezone: current.timezone,
      notes: current.notes,
      status: AppointmentStatus.completed,
    );
    _appointments[index] = updated;
    return updated;
  }
}
