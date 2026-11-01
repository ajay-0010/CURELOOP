import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/config/dev_config.dart';

part 'auth_repository.g.dart';

abstract class IAuthRepository {
  Future<void> requestOtp(String phoneNumber);
  Future<void> verifyOtp(String phoneNumber, String otp);
}

class AuthRepository implements IAuthRepository {
  final Dio _dio;
  final AuthTokenStorage _storage;

  AuthRepository(this._dio, this._storage);

  @override
  Future<void> requestOtp(String phoneNumber) async {
    await _dio.post('/auth/request-otp', data: {
      'phone_number': phoneNumber,
    });
  }

  @override
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    final response = await _dio.post('/auth/verify-otp', data: {
      'phone_number': phoneNumber,
      'otp': otp,
    });
    
    final data = response.data;
    await _storage.saveTokens(
      accessToken: data['access_token'],
      refreshToken: data['refresh_token'] ?? '',
    );
  }
}

class DemoAuthRepository implements IAuthRepository {
  final AuthTokenStorage _storage;

  DemoAuthRepository(this._storage);

  @override
  Future<void> requestOtp(String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulated success
  }

  @override
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (otp == '1234') {
      await _storage.saveTokens(
        accessToken: 'demo_access_token',
        refreshToken: 'demo_refresh_token',
      );
    } else {
      throw Exception('Invalid OTP. Use 1234 for demo.');
    }
  }
}

@riverpod
IAuthRepository authRepository(AuthRepositoryRef ref) {
  final storage = ref.watch(authTokenStorageProvider.notifier);
  if (kFrontendDemoMode) {
    return DemoAuthRepository(storage);
  }
  
  final dio = ref.watch(dioClientProvider);
  return AuthRepository(dio, storage);
}
