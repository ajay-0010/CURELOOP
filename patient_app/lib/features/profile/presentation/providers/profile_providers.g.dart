// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientProfileHash() => r'a30d39037422054631e9b591125c634a8920bb73';

/// See also [patientProfile].
@ProviderFor(patientProfile)
final patientProfileProvider =
    AutoDisposeFutureProvider<PatientProfile>.internal(
  patientProfile,
  name: r'patientProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PatientProfileRef = AutoDisposeFutureProviderRef<PatientProfile>;
String _$patientAllergiesHash() => r'9f1bd757ddea3fe9859888fe262e8940d7d74d99';

/// See also [patientAllergies].
@ProviderFor(patientAllergies)
final patientAllergiesProvider =
    AutoDisposeFutureProvider<List<Allergy>>.internal(
  patientAllergies,
  name: r'patientAllergiesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientAllergiesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PatientAllergiesRef = AutoDisposeFutureProviderRef<List<Allergy>>;
String _$patientFamilyHash() => r'f3e2b810f01156ccb73e417780d70ffd9623120a';

/// See also [patientFamily].
@ProviderFor(patientFamily)
final patientFamilyProvider =
    AutoDisposeFutureProvider<List<FamilyMember>>.internal(
  patientFamily,
  name: r'patientFamilyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientFamilyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PatientFamilyRef = AutoDisposeFutureProviderRef<List<FamilyMember>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
