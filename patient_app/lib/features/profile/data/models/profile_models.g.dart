// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientProfile _$PatientProfileFromJson(Map<String, dynamic> json) =>
    PatientProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactPhone: json['emergencyContactPhone'] as String?,
    );

Map<String, dynamic> _$PatientProfileToJson(PatientProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth,
      'bloodGroup': instance.bloodGroup,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactPhone': instance.emergencyContactPhone,
    };

Allergy _$AllergyFromJson(Map<String, dynamic> json) => Allergy(
      id: json['id'] as String,
      name: json['name'] as String,
      severity: json['severity'] as String,
      reaction: json['reaction'] as String?,
    );

Map<String, dynamic> _$AllergyToJson(Allergy instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'severity': instance.severity,
      'reaction': instance.reaction,
    };

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) => FamilyMember(
      id: json['id'] as String,
      name: json['name'] as String,
      relation: json['relation'] as String,
      dateOfBirth: json['dateOfBirth'] as String?,
    );

Map<String, dynamic> _$FamilyMemberToJson(FamilyMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'relation': instance.relation,
      'dateOfBirth': instance.dateOfBirth,
    };
