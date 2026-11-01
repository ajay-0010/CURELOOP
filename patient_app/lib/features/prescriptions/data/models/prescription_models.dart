import 'package:json_annotation/json_annotation.dart';

part 'prescription_models.g.dart';

enum PrescriptionStatus {
  @JsonValue('DRAFT') draft,
  @JsonValue('PENDING_CONFIRMATION') pendingConfirmation,
  @JsonValue('CONFIRMED') confirmed,
  @JsonValue('UNKNOWN') unknown
}

enum FoodTiming {
  @JsonValue('BEFORE_FOOD') beforeFood,
  @JsonValue('AFTER_FOOD') afterFood,
  @JsonValue('WITH_FOOD') withFood,
  @JsonValue('NO_INSTRUCTION') noInstruction
}

@JsonSerializable(explicitToJson: true)
class PrescriptionMedicine {
  final String? id;
  @JsonKey(name: 'prescription_id')
  final String? prescriptionId;
  @JsonKey(name: 'medicine_name')
  final String? medicineName;
  final String? dosage;
  final String? frequency;
  @JsonKey(name: 'duration_days')
  final int? durationDays;
  @JsonKey(name: 'food_timing')
  final FoodTiming? foodTiming;
  final String? instructions;

  PrescriptionMedicine({
    this.id,
    this.prescriptionId,
    this.medicineName,
    this.dosage,
    this.frequency,
    this.durationDays,
    this.foodTiming,
    this.instructions,
  });

  factory PrescriptionMedicine.fromJson(Map<String, dynamic> json) => _$PrescriptionMedicineFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionMedicineToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Prescription {
  final String id;
  @JsonKey(name: 'patient_id')
  final String patientId;
  
  @JsonKey(defaultValue: PrescriptionStatus.unknown, unknownEnumValue: PrescriptionStatus.unknown)
  final PrescriptionStatus status;
  
  @JsonKey(name: 'doctor_name')
  final String? doctorName;
  @JsonKey(name: 'clinic_name')
  final String? clinicName;
  @JsonKey(name: 'prescription_date')
  final String prescriptionDate;
  final String? notes;
  final List<PrescriptionMedicine> medicines;

  Prescription({
    required this.id,
    required this.patientId,
    this.status = PrescriptionStatus.unknown,
    this.doctorName,
    this.clinicName,
    required this.prescriptionDate,
    this.notes,
    this.medicines = const [],
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => _$PrescriptionFromJson(json);
  Map<String, dynamic> toJson() => _$PrescriptionToJson(this);
}

@JsonSerializable()
class SafetyResult {
  @JsonKey(name: 'is_safe')
  final bool isSafe;
  final List<String> warnings;
  final String? disclaimer;

  SafetyResult({
    required this.isSafe,
    this.warnings = const [],
    this.disclaimer,
  });

  factory SafetyResult.fromJson(Map<String, dynamic> json) => _$SafetyResultFromJson(json);
  Map<String, dynamic> toJson() => _$SafetyResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExtractedField {
  final dynamic value;
  final String confidence;

  ExtractedField({
    this.value,
    required this.confidence,
  });

  factory ExtractedField.fromJson(Map<String, dynamic> json) => _$ExtractedFieldFromJson(json);
  Map<String, dynamic> toJson() => _$ExtractedFieldToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CandidateMedicine {
  @JsonKey(name: 'medicine_name')
  final ExtractedField medicineName;
  final ExtractedField dosage;
  final ExtractedField frequency;
  @JsonKey(name: 'duration_days')
  final ExtractedField durationDays;
  @JsonKey(name: 'food_timing')
  final ExtractedField foodTiming;

  CandidateMedicine({
    required this.medicineName,
    required this.dosage,
    required this.frequency,
    required this.durationDays,
    required this.foodTiming,
  });

  factory CandidateMedicine.fromJson(Map<String, dynamic> json) => _$CandidateMedicineFromJson(json);
  Map<String, dynamic> toJson() => _$CandidateMedicineToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OCRExtractionResponse {
  @JsonKey(name: 'prescription_id')
  final String prescriptionId;
  @JsonKey(name: 'document_key')
  final String documentKey;
  @JsonKey(name: 'doctor_name')
  final String? doctorName;
  final List<CandidateMedicine> medicines;
  @JsonKey(name: 'raw_text')
  final String rawText;
  @JsonKey(name: 'provider_name')
  final String providerName;

  OCRExtractionResponse({
    required this.prescriptionId,
    required this.documentKey,
    this.doctorName,
    required this.medicines,
    required this.rawText,
    required this.providerName,
  });

  factory OCRExtractionResponse.fromJson(Map<String, dynamic> json) => _$OCRExtractionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OCRExtractionResponseToJson(this);
}
