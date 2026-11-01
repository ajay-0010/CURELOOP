import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/dev_config.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/repositories/sqlite_profile_repository.dart';
import 'models/profile_models.dart';

abstract class ProfileRepository {
  Future<PatientProfile> getProfile();
  Future<void> updateProfile(PatientProfile profile);
  
  Future<List<Allergy>> getAllergies();
  Future<void> addAllergy(Allergy allergy);
  Future<void> removeAllergy(String id);
  
  Future<List<FamilyMember>> getFamilyMembers();
  Future<void> addFamilyMember(FamilyMember member);
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  if (kFrontendDemoMode) {
    final db = ref.watch(appDatabaseProvider);
    return SqliteProfileRepository(db);
  }
  throw UnimplementedError('HTTP ProfileRepository not implemented yet.');
});
