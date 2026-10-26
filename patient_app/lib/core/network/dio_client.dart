import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/secure_storage.dart';
import '../../core/config/environment.dart';
import '../config/dev_config.dart';
import 'dart:async';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(DioClientRef ref) {
  final dio = Dio();
  
  dio.options.baseUrl = Environment.apiUrl;
  dio.options.connectTimeout = const Duration(seconds: 10);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  
  // Refresh token synchronization variables
  bool isRefreshing = false;
  Completer<String?>? refreshCompleter;
  
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await ref.read(secureStorageProvider).read(key: StorageKeys.accessToken);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        } else if (kDevSkipAuth) {
          if (options.method == 'GET') {
             if (options.path.endsWith('/prescriptions') || 
                 options.path.contains('/medicines/') || 
                 options.path.endsWith('/appointments')) {
                 return handler.resolve(Response(requestOptions: options, statusCode: 200, data: []));
             }
             return handler.resolve(Response(requestOptions: options, statusCode: 200, data: {}));
          }
          return handler.resolve(Response(requestOptions: options, statusCode: 200, data: {}));
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Token expired or invalid, try to refresh
          final refreshToken = await ref.read(secureStorageProvider).read(key: StorageKeys.refreshToken);
          
          if (refreshToken == null) {
            await ref.read(authTokenStorageProvider.notifier).clearTokens();
            return handler.next(e);
          }

          if (!isRefreshing) {
            isRefreshing = true;
            refreshCompleter = Completer<String?>();
            
            try {
              // Call refresh endpoint directly using a separate dio instance 
              // to avoid circular interceptor loops.
              final refreshDio = Dio(BaseOptions(baseUrl: Environment.apiUrl));
              final response = await refreshDio.post(
                '/auth/refresh',
                data: {'refresh_token': refreshToken},
              );
              
              final newAccessToken = response.data['access_token'];
              final newRefreshToken = response.data['refresh_token'];
              
              await ref.read(authTokenStorageProvider.notifier).saveTokens(
                accessToken: newAccessToken,
                refreshToken: newRefreshToken,
              );
              
              refreshCompleter!.complete(newAccessToken);
            } catch (refreshError) {
              refreshCompleter!.complete(null);
              await ref.read(authTokenStorageProvider.notifier).clearTokens();
              return handler.next(e);
            } finally {
              isRefreshing = false;
            }
          }

          final newAccessToken = await refreshCompleter!.future;
          
          if (newAccessToken != null) {
            // Retry the original request exactly once
            final options = e.requestOptions;
            options.headers['Authorization'] = 'Bearer $newAccessToken';
            try {
              final retryResponse = await dio.fetch(options);
              return handler.resolve(retryResponse);
            } on DioException catch (retryError) {
              return handler.next(retryError);
            }
          } else {
            return handler.next(e);
          }
        }
        return handler.next(e);
      },
    ),
  );
  
  return dio;
}
