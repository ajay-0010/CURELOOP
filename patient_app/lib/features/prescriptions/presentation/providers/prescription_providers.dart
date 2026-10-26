import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/prescription_repository.dart';
import '../../data/models/prescription_models.dart';

part 'prescription_providers.g.dart';

@riverpod
Future<List<Prescription>> prescriptionList(PrescriptionListRef ref) {
  return ref.watch(prescriptionRepositoryProvider).getPrescriptions();
}

@riverpod
Future<Prescription> prescriptionDetail(PrescriptionDetailRef ref, String id) {
  return ref.watch(prescriptionRepositoryProvider).getPrescription(id);
}

@riverpod
Future<SafetyResult> safetyCheck(SafetyCheckRef ref, String id) {
  return ref.watch(prescriptionRepositoryProvider).checkSafety(id);
}
