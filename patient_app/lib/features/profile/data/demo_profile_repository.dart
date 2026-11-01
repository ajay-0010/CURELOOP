import 'models/profile_models.dart';
import 'profile_repository.dart';

class DemoProfileRepository implements ProfileRepository {
  PatientProfile _profile = PatientProfile(
    id: 'p1',
    name: 'Jane Doe',
    phone: '+1 555 123 4567',
    email: 'jane.doe@example.com',
    dateOfBirth: '1985-04-12',
    bloodGroup: 'O+',
    emergencyContactName: 'John Doe',
    emergencyContactPhone: '+1 555 987 6543',
  );

  final List<Allergy> _allergies = [
    Allergy(id: 'a1', name: 'Penicillin', severity: 'High', reaction: 'Anaphylaxis'),
    Allergy(id: 'a2', name: 'Peanuts', severity: 'Medium', reaction: 'Hives'),
  ];

  final List<FamilyMember> _family = [
    FamilyMember(id: 'f1', name: 'John Doe', relation: 'Spouse', dateOfBirth: '1983-06-15'),
    FamilyMember(id: 'f2', name: 'Jimmy Doe', relation: 'Son', dateOfBirth: '2010-09-01'),
  ];

  @override
  Future<PatientProfile> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _profile;
  }

  @override
  Future<void> updateProfile(PatientProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _profile = profile;
  }

  @override
  Future<List<Allergy>> getAllergies() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_allergies);
  }

  @override
  Future<void> addAllergy(Allergy allergy) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _allergies.add(allergy);
  }

  @override
  Future<void> removeAllergy(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _allergies.removeWhere((a) => a.id == id);
  }

  @override
  Future<List<FamilyMember>> getFamilyMembers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_family);
  }

  @override
  Future<void> addFamilyMember(FamilyMember member) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _family.add(member);
  }
}
