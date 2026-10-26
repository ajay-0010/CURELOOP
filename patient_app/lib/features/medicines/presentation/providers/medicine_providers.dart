import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/medicine_models.dart';
import '../../data/medicine_repository.dart';

part 'medicine_providers.g.dart';

@riverpod
Future<List<DoseEvent>> todayDoses(TodayDosesRef ref) {
  return ref.watch(medicineRepositoryProvider).getTodayDoses();
}

@riverpod
Future<List<DoseEvent>> upcomingDoses(UpcomingDosesRef ref) {
  return ref.watch(medicineRepositoryProvider).getUpcomingDoses();
}

@riverpod
Future<List<DoseEvent>> historyDoses(HistoryDosesRef ref) {
  return ref.watch(medicineRepositoryProvider).getHistoryDoses();
}

