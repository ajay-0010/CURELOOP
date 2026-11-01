import '../app_database.dart';

class AppointmentDao {
  final AppDatabase db;

  AppointmentDao(this.db);

  Future<AppointmentEntity?> getAppointment(String id) async {
    return (db.select(db.appointments)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<List<AppointmentEntity>> getAppointments({required String filter, String patientId = 'p1'}) async {
    final query = db.select(db.appointments)..where((tbl) => tbl.patientId.equals(patientId));
    if (filter == 'upcoming') {
      query
        ..where((tbl) => tbl.status.equals('scheduled'))
        ..orderBy([(tbl) => OrderingTerm.asc(tbl.appointmentDatetime)]);
    } else {
      query
        ..where((tbl) => tbl.status.isNotValue('scheduled'))
        ..orderBy([(tbl) => OrderingTerm.desc(tbl.appointmentDatetime)]);
    }
    return query.get();
  }

  Future<void> insertAppointment(AppointmentsCompanion appointment) async {
    await db.into(db.appointments).insertOnConflictUpdate(appointment);
  }

  Future<void> updateAppointment(String id, AppointmentsCompanion companion) async {
    await (db.update(db.appointments)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<void> deleteAppointment(String id) async {
    await (db.delete(db.appointments)..where((tbl) => tbl.id.equals(id))).go();
  }
}
