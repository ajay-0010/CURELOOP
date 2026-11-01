import '../../../features/medicines/data/medicine_repository.dart';
import '../../../features/medicines/data/models/medicine_models.dart';
import '../app_database.dart';
import '../daos/medicine_dao.dart';

class SqliteMedicineRepository implements IMedicineRepository {
  final MedicineDao _dao;

  SqliteMedicineRepository(AppDatabase db) : _dao = MedicineDao(db);

  DoseEvent _toModel(DoseEventEntity data) {
    DoseStatus status;
    switch (data.status) {
      case 'SCHEDULED':
        status = DoseStatus.scheduled;
        break;
      case 'TAKEN':
        status = DoseStatus.taken;
        break;
      case 'SKIPPED':
        status = DoseStatus.skipped;
        break;
      case 'MISSED':
        status = DoseStatus.missed;
        break;
      default:
        status = DoseStatus.unknown;
    }

    FoodTiming? foodTiming;
    switch (data.foodTiming) {
      case 'BEFORE_FOOD':
        foodTiming = FoodTiming.beforeFood;
        break;
      case 'AFTER_FOOD':
        foodTiming = FoodTiming.afterFood;
        break;
      case 'WITH_FOOD':
        foodTiming = FoodTiming.withFood;
        break;
      case 'NO_INSTRUCTION':
        foodTiming = FoodTiming.noInstruction;
        break;
      default:
        foodTiming = null;
    }

    return DoseEvent(
      id: data.id,
      prescriptionId: data.prescriptionId,
      prescriptionMedicineId: data.prescriptionMedicineId,
      medicineName: data.medicineName,
      dosage: data.dosage,
      scheduledAt: data.scheduledAt,
      status: status,
      foodTiming: foodTiming,
      takenAt: data.takenAt,
      skippedAt: data.skippedAt,
      skipReason: data.skipReason,
    );
  }

  @override
  Future<List<DoseEvent>> getTodayDoses() async {
    final rows = await _dao.getTodayDoses();
    return rows.map(_toModel).toList();
  }

  @override
  Future<List<DoseEvent>> getUpcomingDoses() async {
    final rows = await _dao.getUpcomingDoses();
    return rows.map(_toModel).toList();
  }

  @override
  Future<List<DoseEvent>> getHistoryDoses() async {
    final rows = await _dao.getHistoryDoses();
    return rows.map(_toModel).toList();
  }

  @override
  Future<DoseEvent> markDoseTaken(String id) async {
    final now = DateTime.now();
    await _dao.updateDoseEvent(
      id,
      DoseEventsCompanion(
        status: const Value('TAKEN'),
        takenAt: Value(now),
      ),
    );
    final updated = await _dao.getDoseEvent(id);
    if (updated == null) {
      throw Exception('DoseEvent not found: $id');
    }
    return _toModel(updated);
  }

  @override
  Future<DoseEvent> markDoseSkipped(String id) async {
    final now = DateTime.now();
    await _dao.updateDoseEvent(
      id,
      DoseEventsCompanion(
        status: const Value('SKIPPED'),
        skippedAt: Value(now),
      ),
    );
    final updated = await _dao.getDoseEvent(id);
    if (updated == null) {
      throw Exception('DoseEvent not found: $id');
    }
    return _toModel(updated);
  }
}
