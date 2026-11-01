import '../app_database.dart';

class PrescriptionWithMedicines {
  final PrescriptionEntity prescription;
  final List<PrescriptionMedicineEntity> medicines;

  PrescriptionWithMedicines({
    required this.prescription,
    required this.medicines,
  });
}

class PrescriptionDao {
  final AppDatabase db;

  PrescriptionDao(this.db);

  Future<List<PrescriptionWithMedicines>> getPrescriptions([String patientId = 'p1']) async {
    final rxList = await (db.select(db.prescriptions)
          ..where((tbl) => tbl.patientId.equals(patientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .get();

    final result = <PrescriptionWithMedicines>[];
    for (final rx in rxList) {
      final meds = await (db.select(db.prescriptionMedicines)
            ..where((tbl) => tbl.prescriptionId.equals(rx.id)))
          .get();
      result.add(PrescriptionWithMedicines(prescription: rx, medicines: meds));
    }
    return result;
  }

  Future<PrescriptionWithMedicines?> getPrescription(String id) async {
    final rx = await (db.select(db.prescriptions)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (rx == null) return null;

    final meds = await (db.select(db.prescriptionMedicines)
          ..where((tbl) => tbl.prescriptionId.equals(id)))
        .get();
    return PrescriptionWithMedicines(prescription: rx, medicines: meds);
  }

  Future<void> insertPrescription(PrescriptionsCompanion prescription) async {
    await db.into(db.prescriptions).insertOnConflictUpdate(prescription);
  }

  Future<void> insertMedicine(PrescriptionMedicinesCompanion medicine) async {
    await db.into(db.prescriptionMedicines).insertOnConflictUpdate(medicine);
  }

  Future<void> updatePrescription(String id, PrescriptionsCompanion companion) async {
    await (db.update(db.prescriptions)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<void> updateMedicine(String id, PrescriptionMedicinesCompanion companion) async {
    await (db.update(db.prescriptionMedicines)..where((tbl) => tbl.id.equals(id))).write(companion);
  }

  Future<void> deletePrescription(String id) async {
    await (db.delete(db.prescriptions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<AllergyEntity>> getPatientAllergies([String patientId = 'p1']) async {
    return (db.select(db.allergies)..where((tbl) => tbl.patientId.equals(patientId))).get();
  }
}
