import 'package:dio/dio.dart';

String apiErrorMessage(Object error) {
  if (error is DioException) {
    final status = error.response?.statusCode;
    final data = error.response?.data;

    if (data is String && data.isNotEmpty) return data;
    if (data is Map && data['message'] is String) {
      return data['message'] as String;
    }

    switch (status) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Invalid email or password.';
      case 403:
        return 'Your account is not verified or has been disabled.';
      case 404:
        return 'Not found.';
      case 409:
        return 'Conflict. The resource already exists.';
      case 422:
        return 'Validation error. Please check your input.';
      case 500:
        return 'Server error. Please try again later.';
      case null:
        return 'Could not reach the server. Check your connection.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
  return 'Something went wrong. Please try again.';
}
