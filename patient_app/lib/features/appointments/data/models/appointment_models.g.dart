// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      doctorName: json['doctor_name'] as String,
      clinicName: json['clinic_name'] as String?,
      appointmentDatetime:
          DateTime.parse(json['appointment_datetime'] as String),
      timezone: json['timezone'] as String?,
      notes: json['notes'] as String?,
      status: $enumDecodeNullable(_$AppointmentStatusEnumMap, json['status'],
              unknownValue: AppointmentStatus.unknown) ??
          AppointmentStatus.unknown,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patientId,
      'doctor_name': instance.doctorName,
      'clinic_name': instance.clinicName,
      'appointment_datetime': instance.appointmentDatetime.toIso8601String(),
      'timezone': instance.timezone,
      'notes': instance.notes,
      'status': _$AppointmentStatusEnumMap[instance.status]!,
    };

const _$AppointmentStatusEnumMap = {
  AppointmentStatus.scheduled: 'scheduled',
  AppointmentStatus.completed: 'completed',
  AppointmentStatus.cancelled: 'cancelled',
  AppointmentStatus.unknown: 'unknown',
};
