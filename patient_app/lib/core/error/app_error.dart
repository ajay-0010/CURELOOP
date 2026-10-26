import 'package:dio/dio.dart';

class AppError {
  final String message;
  final String? technicalDetails;

  AppError(this.message, {this.technicalDetails});

  factory AppError.fromException(dynamic error) {
    if (error is DioException) {
      return AppError._fromDioException(error);
    }
    return AppError('Something went wrong. Please try again.', technicalDetails: error.toString());
  }

  factory AppError._fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError('The request took too long. Please try again.');
      case DioExceptionType.connectionError:
        return AppError('You\'re offline. Check your internet connection and try again.');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return AppError(error.response?.data?['detail'] ?? 'Invalid request. Please check your inputs.');
          case 401:
            return AppError('Your session has expired. Please sign in again.');
          case 403:
            return AppError('You don\'t have permission to access this information.');
          case 404:
            return AppError('We couldn\'t find that item.');
          case 409:
            return AppError('This information has changed. Please refresh and try again.');
          case 429:
            return AppError('Too many requests. Please slow down and try again later.');
          case 500:
          case 502:
          case 503:
          case 504:
            return AppError('Something went wrong on our server. Please try again later.');
          default:
            return AppError('An unexpected server error occurred.');
        }
      case DioExceptionType.cancel:
        return AppError('The request was cancelled.');
      default:
        return AppError('Something went wrong. Please try again.');
    }
  }

  @override
  String toString() => message;
}
