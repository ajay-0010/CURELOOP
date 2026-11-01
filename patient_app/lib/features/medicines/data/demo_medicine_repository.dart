import 'medicine_repository.dart';
import 'models/medicine_models.dart';

class DemoMedicineRepository implements IMedicineRepository {
  final List<DoseEvent> _doses = [
    DoseEvent(
      id: 'dose-1',
      prescriptionId: 'demo-rx-1',
      prescriptionMedicineId: 'demo-med-1',
      medicineName: 'Metformin 500mg',
      dosage: '1 tablet',
      scheduledAt: DateTime.now().subtract(const Duration(hours: 1)),
      status: DoseStatus.taken,
      foodTiming: FoodTiming.beforeFood,
    ),
    DoseEvent(
      id: 'dose-2',
      prescriptionId: 'demo-rx-1',
      prescriptionMedicineId: 'demo-med-2',
      medicineName: 'Amlodipine 5mg',
      dosage: '1 tablet',
      scheduledAt: DateTime.now().add(const Duration(hours: 2)),
      status: DoseStatus.scheduled,
      foodTiming: FoodTiming.afterFood,
    ),
    DoseEvent(
      id: 'dose-3',
      prescriptionId: 'demo-rx-1',
      prescriptionMedicineId: 'demo-med-3',
      medicineName: 'Vitamin D3',
      dosage: '1 capsule',
      scheduledAt: DateTime.now().add(const Duration(hours: 8)),
      status: DoseStatus.scheduled,
      foodTiming: FoodTiming.afterFood,
    ),
  ];

  @override
  Future<List<DoseEvent>> getTodayDoses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _doses.toList();
  }

  @override
  Future<List<DoseEvent>> getUpcomingDoses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _doses.where((d) => d.status == DoseStatus.scheduled).toList();
  }

  @override
  Future<List<DoseEvent>> getHistoryDoses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _doses.where((d) => d.status != DoseStatus.scheduled).toList();
  }

  @override
  Future<DoseEvent> markDoseTaken(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _doses.indexWhere((d) => d.id == id);
    final current = _doses[index];
    final updated = DoseEvent(
      id: current.id,
      prescriptionId: current.prescriptionId,
      prescriptionMedicineId: current.prescriptionMedicineId,
      medicineName: current.medicineName,
      dosage: current.dosage,
      scheduledAt: current.scheduledAt,
      foodTiming: current.foodTiming,
      status: DoseStatus.taken,
      takenAt: DateTime.now(),
    );
    _doses[index] = updated;
    return updated;
  }

  @override
  Future<DoseEvent> markDoseSkipped(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _doses.indexWhere((d) => d.id == id);
    final current = _doses[index];
    final updated = DoseEvent(
      id: current.id,
      prescriptionId: current.prescriptionId,
      prescriptionMedicineId: current.prescriptionMedicineId,
      medicineName: current.medicineName,
      dosage: current.dosage,
      scheduledAt: current.scheduledAt,
      foodTiming: current.foodTiming,
      status: DoseStatus.skipped,
      skippedAt: DateTime.now(),
    );
    _doses[index] = updated;
    return updated;
  }
}
