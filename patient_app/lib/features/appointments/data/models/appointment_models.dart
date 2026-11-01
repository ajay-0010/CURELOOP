import 'package:json_annotation/json_annotation.dart';

part 'appointment_models.g.dart';

enum AppointmentStatus {
  @JsonValue('scheduled') scheduled,
  @JsonValue('completed') completed,
  @JsonValue('cancelled') cancelled,
  @JsonValue('unknown') unknown
}

@JsonSerializable(explicitToJson: true)
class Appointment {
  final String id;
  @JsonKey(name: 'patient_id')
  final String patientId;
  @JsonKey(name: 'doctor_name')
  final String doctorName;
  @JsonKey(name: 'clinic_name')
  final String? clinicName;
  @JsonKey(name: 'appointment_datetime')
  final DateTime appointmentDatetime;
  final String? timezone;
  final String? notes;
  @JsonKey(defaultValue: AppointmentStatus.unknown, unknownEnumValue: AppointmentStatus.unknown)
  final AppointmentStatus status;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorName,
    this.clinicName,
    required this.appointmentDatetime,
    this.timezone,
    this.notes,
    this.status = AppointmentStatus.unknown,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
