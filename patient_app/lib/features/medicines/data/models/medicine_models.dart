import 'package:json_annotation/json_annotation.dart';

part 'medicine_models.g.dart';

enum DoseStatus {
  @JsonValue('SCHEDULED') scheduled,
  @JsonValue('TAKEN') taken,
  @JsonValue('SKIPPED') skipped,
  @JsonValue('MISSED') missed,
  @JsonValue('UNKNOWN') unknown
}

enum FoodTiming {
  @JsonValue('BEFORE_FOOD') beforeFood,
  @JsonValue('AFTER_FOOD') afterFood,
  @JsonValue('WITH_FOOD') withFood,
  @JsonValue('NO_INSTRUCTION') noInstruction
}

@JsonSerializable()
class DoseEvent {
  final String id;
  @JsonKey(name: 'prescription_id')
  final String prescriptionId;
  @JsonKey(name: 'prescription_medicine_id')
  final String prescriptionMedicineId;
  @JsonKey(name: 'scheduled_at')
  final DateTime scheduledAt;
  
  @JsonKey(defaultValue: DoseStatus.unknown, unknownEnumValue: DoseStatus.unknown)
  final DoseStatus status;

  @JsonKey(name: 'taken_at')
  final DateTime? takenAt;
  @JsonKey(name: 'skipped_at')
  final DateTime? skippedAt;
  @JsonKey(name: 'skip_reason')
  final String? skipReason;

  @JsonKey(name: 'medicine_name')
  final String? medicineName;
  final String? dosage;
  @JsonKey(name: 'food_timing')
  final FoodTiming? foodTiming;

  DoseEvent({
    required this.id,
    required this.prescriptionId,
    required this.prescriptionMedicineId,
    required this.scheduledAt,
    this.status = DoseStatus.unknown,
    this.takenAt,
    this.skippedAt,
    this.skipReason,
    this.medicineName,
    this.dosage,
    this.foodTiming,
  });

  factory DoseEvent.fromJson(Map<String, dynamic> json) => _$DoseEventFromJson(json);
  Map<String, dynamic> toJson() => _$DoseEventToJson(this);
}
