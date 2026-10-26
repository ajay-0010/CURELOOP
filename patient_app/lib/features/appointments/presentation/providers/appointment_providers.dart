import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/appointment_models.dart';
import '../../data/appointment_repository.dart';

part 'appointment_providers.g.dart';

@riverpod
Future<List<Appointment>> upcomingAppointments(UpcomingAppointmentsRef ref) {
  return ref.watch(appointmentRepositoryProvider).getAppointments(filter: 'upcoming');
}

@riverpod
Future<List<Appointment>> pastAppointments(PastAppointmentsRef ref) {
  return ref.watch(appointmentRepositoryProvider).getAppointments(filter: 'past');
}

@riverpod
Future<Appointment> appointmentDetail(AppointmentDetailRef ref, String id) {
  return ref.watch(appointmentRepositoryProvider).getAppointment(id);
}

