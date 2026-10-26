import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/profile_models.dart';
import '../../data/profile_repository.dart';

part 'profile_providers.g.dart';

@riverpod
Future<PatientProfile> patientProfile(PatientProfileRef ref) {
  return ref.watch(profileRepositoryProvider).getProfile();
}

@riverpod
Future<List<Allergy>> patientAllergies(PatientAllergiesRef ref) {
  return ref.watch(profileRepositoryProvider).getAllergies();
}

@riverpod
Future<List<FamilyMember>> patientFamily(PatientFamilyRef ref) {
  return ref.watch(profileRepositoryProvider).getFamilyMembers();
}
