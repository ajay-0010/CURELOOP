import '../app_database.dart';

class MedicineDao {
  final AppDatabase db;

  MedicineDao(this.db);

  Future<List<DoseEventEntity>> getTodayDoses() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

    return (db.select(db.doseEvents)
          ..where((tbl) => tbl.scheduledAt.isBiggerOrEqualValue(startOfDay) & tbl.scheduledAt.isSmallerOrEqualValue(endOfDay))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.scheduledAt)]))
        .get();
  }

  Future<List<DoseEventEntity>> getUpcomingDoses() async {
    return (db.select(db.doseEvents)
          ..where((tbl) => tbl.status.equals('SCHEDULED'))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.scheduledAt)]))
        .get();
  }

  Future<List<DoseEventEntity>> getHistoryDoses() async {
    return (db.select(db.doseEvents)
          ..where((tbl) => tbl.status.isNotValue('SCHEDULED'))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.scheduledAt)]))
        .get();
  }

  Future<DoseEventEntity?> getDoseEvent(String id) async {
    return (db.select(db.doseEvents)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> updateDoseEvent(String id, DoseEventsCompanion companion) async {
    await (db.update(db.doseEvents)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<void> insertDoseEvent(DoseEventsCompanion companion) async {
    await db.into(db.doseEvents).insertOnConflictUpdate(companion);
  }

  Future<void> insertSchedule(MedicineSchedulesCompanion companion) async {
    await db.into(db.medicineSchedules).insertOnConflictUpdate(companion);
  }

  Future<List<MedicineScheduleEntity>> getActiveSchedules() async {
    return (db.select(db.medicineSchedules)..where((tbl) => tbl.isActive.equals(true))).get();
  }
}
