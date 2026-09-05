import 'package:dio/dio.dart';
import 'package:my_hrm/entity/request/Forgot_Password_Request.dart';
import 'package:my_hrm/entity/request/LoginRequest.dart';
import 'package:my_hrm/entity/request/ResetPasswordRequest.dart';
import 'package:my_hrm/entity/response/LoginResponse.dart';
import 'package:my_hrm/service/StorageService.dart';
import 'package:my_hrm/util/ApiClient.dart';
import 'package:my_hrm/util/ApiConstants.dart';

class AuthRepository{

  AuthRepository(this._apiClient, this._storageService);

  final ApiClient _apiClient;
  final StorageService _storageService;

  Dio get _dio => _apiClient.dio;

  Future<LoginResponse> login(LoginRequest dto) async {
    final res = await _dio.post(ApiConstants.login, data: dto.toJson());
    final loginRes = LoginResponse.fromJson(res.data as Map<String, dynamic>);
    await _storageService.saveSession(loginRes);
    return loginRes;
  }

  Future<void> logout() => _storageService.clearSession();


  Future<String> forgotPassword(ForgotPasswordRequest dto) async {
    final res = await _dio.post(
      ApiConstants.forgotPassword,
      data: dto.toJson(),
      options: Options(responseType: ResponseType.plain),
    );
    return res.data.toString();
  }

  Future<String> resetPassword(ResetPasswordRequest dto) async {
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


}