import '../app_database.dart';

class ProfileDao {
  final AppDatabase db;

  ProfileDao(this.db);

  Future<PatientProfileEntity?> getProfile([String id = 'p1']) async {
    return (db.select(db.patientProfiles)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> upsertProfile(PatientProfilesCompanion profile) async {
    await db.into(db.patientProfiles).insertOnConflictUpdate(profile);
  }

  Future<List<AllergyEntity>> getAllergies([String patientId = 'p1']) async {
    return (db.select(db.allergies)
          ..where((tbl) => tbl.patientId.equals(patientId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
        .get();
  }

  Future<void> insertAllergy(AllergiesCompanion allergy) async {
    await db.into(db.allergies).insertOnConflictUpdate(allergy);
  }

  Future<void> deleteAllergy(String id) async {
    await (db.delete(db.allergies)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<FamilyMemberEntity>> getFamilyMembers([String patientId = 'p1']) async {
    return (db.select(db.familyMembers)
          ..where((tbl) => tbl.patientId.equals(patientId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.createdAt)]))
        .get();
  }

  Future<void> insertFamilyMember(FamilyMembersCompanion member) async {
    await db.into(db.familyMembers).insertOnConflictUpdate(member);
  }

  Future<void> deleteFamilyMember(String id) async {
    await (db.delete(db.familyMembers)..where((tbl) => tbl.id.equals(id))).go();
  }
}
