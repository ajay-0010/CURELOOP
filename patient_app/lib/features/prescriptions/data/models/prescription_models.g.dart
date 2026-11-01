// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrescriptionMedicine _$PrescriptionMedicineFromJson(
        Map<String, dynamic> json) =>
    PrescriptionMedicine(
      id: json['id'] as String?,
      prescriptionId: json['prescription_id'] as String?,
      medicineName: json['medicine_name'] as String?,
      dosage: json['dosage'] as String?,
      frequency: json['frequency'] as String?,
      durationDays: (json['duration_days'] as num?)?.toInt(),
      foodTiming: $enumDecodeNullable(_$FoodTimingEnumMap, json['food_timing']),
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$PrescriptionMedicineToJson(
        PrescriptionMedicine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prescription_id': instance.prescriptionId,
      'medicine_name': instance.medicineName,
      'dosage': instance.dosage,
      'frequency': instance.frequency,
      'duration_days': instance.durationDays,
      'food_timing': _$FoodTimingEnumMap[instance.foodTiming],
      'instructions': instance.instructions,
    };

const _$FoodTimingEnumMap = {
  FoodTiming.beforeFood: 'BEFORE_FOOD',
  FoodTiming.afterFood: 'AFTER_FOOD',
  FoodTiming.withFood: 'WITH_FOOD',
  FoodTiming.noInstruction: 'NO_INSTRUCTION',
};

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) => Prescription(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      status: $enumDecodeNullable(_$PrescriptionStatusEnumMap, json['status'],
              unknownValue: PrescriptionStatus.unknown) ??
          PrescriptionStatus.unknown,
      doctorName: json['doctor_name'] as String?,
      clinicName: json['clinic_name'] as String?,
      prescriptionDate: json['prescription_date'] as String,
      notes: json['notes'] as String?,
      medicines: (json['medicines'] as List<dynamic>?)
              ?.map((e) =>
                  PrescriptionMedicine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patientId,
      'status': _$PrescriptionStatusEnumMap[instance.status]!,
      'doctor_name': instance.doctorName,
      'clinic_name': instance.clinicName,
      'prescription_date': instance.prescriptionDate,
      'notes': instance.notes,
      'medicines': instance.medicines.map((e) => e.toJson()).toList(),
    };

const _$PrescriptionStatusEnumMap = {
  PrescriptionStatus.draft: 'DRAFT',
  PrescriptionStatus.pendingConfirmation: 'PENDING_CONFIRMATION',
  PrescriptionStatus.confirmed: 'CONFIRMED',
  PrescriptionStatus.unknown: 'UNKNOWN',
};

SafetyResult _$SafetyResultFromJson(Map<String, dynamic> json) => SafetyResult(
      isSafe: json['is_safe'] as bool,
      warnings: (json['warnings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      disclaimer: json['disclaimer'] as String?,
    );

Map<String, dynamic> _$SafetyResultToJson(SafetyResult instance) =>
    <String, dynamic>{
      'is_safe': instance.isSafe,
      'warnings': instance.warnings,
      'disclaimer': instance.disclaimer,
    };

ExtractedField _$ExtractedFieldFromJson(Map<String, dynamic> json) =>
    ExtractedField(
      value: json['value'],
      confidence: json['confidence'] as String,
    );

Map<String, dynamic> _$ExtractedFieldToJson(ExtractedField instance) =>
    <String, dynamic>{
      'value': instance.value,
      'confidence': instance.confidence,
    };

CandidateMedicine _$CandidateMedicineFromJson(Map<String, dynamic> json) =>
    CandidateMedicine(
      medicineName: ExtractedField.fromJson(
          json['medicine_name'] as Map<String, dynamic>),
      dosage: ExtractedField.fromJson(json['dosage'] as Map<String, dynamic>),
      frequency:
          ExtractedField.fromJson(json['frequency'] as Map<String, dynamic>),
      durationDays: ExtractedField.fromJson(
          json['duration_days'] as Map<String, dynamic>),
      foodTiming:
          ExtractedField.fromJson(json['food_timing'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CandidateMedicineToJson(CandidateMedicine instance) =>
    <String, dynamic>{
      'medicine_name': instance.medicineName.toJson(),
      'dosage': instance.dosage.toJson(),
      'frequency': instance.frequency.toJson(),
      'duration_days': instance.durationDays.toJson(),
      'food_timing': instance.foodTiming.toJson(),
    };

OCRExtractionResponse _$OCRExtractionResponseFromJson(
        Map<String, dynamic> json) =>
    OCRExtractionResponse(
      prescriptionId: json['prescription_id'] as String,
      documentKey: json['document_key'] as String,
      doctorName: json['doctor_name'] as String?,
      medicines: (json['medicines'] as List<dynamic>)
          .map((e) => CandidateMedicine.fromJson(e as Map<String, dynamic>))
          .toList(),
      rawText: json['raw_text'] as String,
      providerName: json['provider_name'] as String,
    );

Map<String, dynamic> _$OCRExtractionResponseToJson(
        OCRExtractionResponse instance) =>
    <String, dynamic>{
      'prescription_id': instance.prescriptionId,
      'document_key': instance.documentKey,
      'doctor_name': instance.doctorName,
      'medicines': instance.medicines.map((e) => e.toJson()).toList(),
      'raw_text': instance.rawText,
      'provider_name': instance.providerName,
    };
