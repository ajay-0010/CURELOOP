import 'package:json_annotation/json_annotation.dart';

part 'profile_models.g.dart';

@JsonSerializable()
class PatientProfile {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? dateOfBirth;
  final String? bloodGroup;
  final String? emergencyContactName;
  final String? emergencyContactPhone;

  PatientProfile({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.dateOfBirth,
    this.bloodGroup,
    this.emergencyContactName,
    this.emergencyContactPhone,
  });

  factory PatientProfile.fromJson(Map<String, dynamic> json) => _$PatientProfileFromJson(json);
  Map<String, dynamic> toJson() => _$PatientProfileToJson(this);
}

@JsonSerializable()
class Allergy {
  final String id;
  final String name;
  final String severity; // Low, Medium, High
  final String? reaction;

  Allergy({
    required this.id,
    required this.name,
    required this.severity,
    this.reaction,
  });

  factory Allergy.fromJson(Map<String, dynamic> json) => _$AllergyFromJson(json);
  Map<String, dynamic> toJson() => _$AllergyToJson(this);
}

@JsonSerializable()
class FamilyMember {
  final String id;
  final String name;
  final String relation;
  final String? dateOfBirth;

  FamilyMember({
    required this.id,
    required this.name,
    required this.relation,
    this.dateOfBirth,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) => _$FamilyMemberFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
}
