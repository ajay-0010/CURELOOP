// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoseEvent _$DoseEventFromJson(Map<String, dynamic> json) => DoseEvent(
      id: json['id'] as String,
      prescriptionId: json['prescription_id'] as String,
      prescriptionMedicineId: json['prescription_medicine_id'] as String,
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      status: $enumDecodeNullable(_$DoseStatusEnumMap, json['status'],
              unknownValue: DoseStatus.unknown) ??
          DoseStatus.unknown,
      takenAt: json['taken_at'] == null
          ? null
          : DateTime.parse(json['taken_at'] as String),
      skippedAt: json['skipped_at'] == null
          ? null
          : DateTime.parse(json['skipped_at'] as String),
      skipReason: json['skip_reason'] as String?,
      medicineName: json['medicine_name'] as String?,
      dosage: json['dosage'] as String?,
      foodTiming: $enumDecodeNullable(_$FoodTimingEnumMap, json['food_timing']),
    );

Map<String, dynamic> _$DoseEventToJson(DoseEvent instance) => <String, dynamic>{
      'id': instance.id,
      'prescription_id': instance.prescriptionId,
      'prescription_medicine_id': instance.prescriptionMedicineId,
      'scheduled_at': instance.scheduledAt.toIso8601String(),
      'status': _$DoseStatusEnumMap[instance.status]!,
      'taken_at': instance.takenAt?.toIso8601String(),
      'skipped_at': instance.skippedAt?.toIso8601String(),
      'skip_reason': instance.skipReason,
      'medicine_name': instance.medicineName,
      'dosage': instance.dosage,
      'food_timing': _$FoodTimingEnumMap[instance.foodTiming],
    };

const _$DoseStatusEnumMap = {
  DoseStatus.scheduled: 'SCHEDULED',
  DoseStatus.taken: 'TAKEN',
  DoseStatus.skipped: 'SKIPPED',
  DoseStatus.missed: 'MISSED',
  DoseStatus.unknown: 'UNKNOWN',
};

const _$FoodTimingEnumMap = {
  FoodTiming.beforeFood: 'BEFORE_FOOD',
  FoodTiming.afterFood: 'AFTER_FOOD',
  FoodTiming.withFood: 'WITH_FOOD',
  FoodTiming.noInstruction: 'NO_INSTRUCTION',
};
