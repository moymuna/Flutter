import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/storage/storage_service.dart';
import 'package:my_hrm/core/constants/api_constants.dart';

class LoginRequestDto {
  LoginRequestDto({required this.email, required this.password});
  final String email;
  final String password;

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class ForgotPasswordRequestDto {
  ForgotPasswordRequestDto({required this.email});
  final String email;

  Map<String, dynamic> toJson() => {'email': email};
}

class ResetPasswordRequestDto {
  ResetPasswordRequestDto({required this.token, required this.newPassword});
  final String token;
  final String newPassword;

  Map<String, dynamic> toJson() =>
      {'token': token, 'newPassword': newPassword};
}

class AuthRepository {
  AuthRepository(this._apiClient, this._storageService);

  final ApiClient _apiClient;
  final StorageService _storageService;

  Dio get _dio => _apiClient.dio;

  Future<Map<String, dynamic>> login(LoginRequestDto dto) async {
    final res = await _dio.post(ApiConstants.login, data: dto.toJson());
    final data = res.data as Map<String, dynamic>;
    await _storageService.saveSession(data);
    return data;
  }

  Future<void> logout() => _storageService.clearSession();

  Future<String> forgotPassword(ForgotPasswordRequestDto dto) async {
    final res = await _dio.post(
      ApiConstants.forgotPassword,
      data: dto.toJson(),
      options: Options(responseType: ResponseType.plain),
    );
    return res.data.toString();
  }

  Future<String> resetPassword(ResetPasswordRequestDto dto) async {
    final res = await _dio.post(
      ApiConstants.resetPassword,
      data: dto.toJson(),
      options: Options(responseType: ResponseType.plain),
    );
    return res.data.toString();
  }

  Future<String> verifyEmail(String token) async {
    final res = await _dio.get(
      ApiConstants.verifyEmail,
      queryParameters: {'token': token},
      options: Options(responseType: ResponseType.plain),
    );
    return res.data.toString();
  }

  Future<String> register(Map<String, dynamic> data) async {
    final res = await _dio.post(
      ApiConstants.register,
      data: data,
      options: Options(responseType: ResponseType.plain),
    );
    return res.data.toString();
  }

  Future<String> registerApplicant(Map<String, dynamic> data) async {
    final res = await _dio.post(
      ApiConstants.registerApplicant,
      data: data,
    );
    return res.data.toString();
  }
}
