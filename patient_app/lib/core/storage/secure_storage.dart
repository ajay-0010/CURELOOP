import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

@riverpod
FlutterSecureStorage secureStorage(SecureStorageRef ref) {
  return const FlutterSecureStorage();
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
}

@riverpod
class AuthTokenStorage extends _$AuthTokenStorage {
  @override
  Future<String?> build() async {
    final storage = ref.watch(secureStorageProvider);
    return await storage.read(key: StorageKeys.accessToken);
  }

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    final storage = ref.read(secureStorageProvider);
    await storage.write(key: StorageKeys.accessToken, value: accessToken);
    await storage.write(key: StorageKeys.refreshToken, value: refreshToken);
    state = AsyncData(accessToken);
  }

  Future<void> clearTokens() async {
    final storage = ref.read(secureStorageProvider);
    await storage.delete(key: StorageKeys.accessToken);
    await storage.delete(key: StorageKeys.refreshToken);
    state = const AsyncData(null);
  }
}
