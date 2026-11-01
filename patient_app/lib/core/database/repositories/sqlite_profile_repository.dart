import '../../../features/profile/data/models/profile_models.dart';
import '../../../features/profile/data/profile_repository.dart';
import '../app_database.dart';
import '../daos/profile_dao.dart';

class SqliteProfileRepository implements ProfileRepository {
  final ProfileDao _dao;

  SqliteProfileRepository(AppDatabase db) : _dao = ProfileDao(db);

  @override
  Future<PatientProfile> getProfile() async {
    final data = await _dao.getProfile('p1');
    if (data == null) {
      return PatientProfile(
        id: 'p1',
        name: 'Jane Doe',
        phone: '+1 555 123 4567',
        email: 'jane.doe@example.com',
        dateOfBirth: '1985-04-12',
        bloodGroup: 'O+',
        emergencyContactName: 'John Doe',
        emergencyContactPhone: '+1 555 987 6543',
      );
    }
    return PatientProfile(
      id: data.id,
      name: data.name,
      phone: data.phone,
      email: data.email,
      dateOfBirth: data.dateOfBirth,
      bloodGroup: data.bloodGroup,
      emergencyContactName: data.emergencyContactName,
      emergencyContactPhone: data.emergencyContactPhone,
    );
  }

  @override
  Future<void> updateProfile(PatientProfile profile) async {
    await _dao.upsertProfile(
      PatientProfilesCompanion(
        id: Value(profile.id),
        name: Value(profile.name),
        phone: Value(profile.phone),
        email: Value(profile.email),
        dateOfBirth: Value(profile.dateOfBirth),
        bloodGroup: Value(profile.bloodGroup),
        emergencyContactName: Value(profile.emergencyContactName),
        emergencyContactPhone: Value(profile.emergencyContactPhone),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<List<Allergy>> getAllergies() async {
    final rows = await _dao.getAllergies('p1');
    return rows.map((r) => Allergy(
      id: r.id,
      name: r.name,
      severity: r.severity,
      reaction: r.reaction,
    )).toList();
  }

  @override
  Future<void> addAllergy(Allergy allergy) async {
    await _dao.insertAllergy(
      AllergiesCompanion(
        id: Value(allergy.id),
        patientId: const Value('p1'),
        name: Value(allergy.name),
        severity: Value(allergy.severity),
        reaction: Value(allergy.reaction),
        createdAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> removeAllergy(String id) async {
    await _dao.deleteAllergy(id);
  }

  @override
  Future<List<FamilyMember>> getFamilyMembers() async {
    final rows = await _dao.getFamilyMembers('p1');
    return rows.map((r) => FamilyMember(
      id: r.id,
      name: r.name,
      relation: r.relation,
      dateOfBirth: r.dateOfBirth,
    )).toList();
  }

  @override
  Future<void> addFamilyMember(FamilyMember member) async {
    await _dao.insertFamilyMember(
      FamilyMembersCompanion(
        id: Value(member.id),
        patientId: const Value('p1'),
        name: Value(member.name),
        relation: Value(member.relation),
        dateOfBirth: Value(member.dateOfBirth),
        createdAt: Value(DateTime.now()),
      ),
    );
  }
}
