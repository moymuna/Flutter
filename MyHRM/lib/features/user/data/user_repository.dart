import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/user/data/models/user.dart';

class UserRepository {
  UserRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<UserResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.user);
    return (res.data as List)
        .map((e) => UserResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<UserResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.userById(id));
    return UserResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserResponse> getByEmail(String email) async {
    final res = await _dio.get(ApiConstants.userByEmail(email));
    return UserResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<UserResponse> create(UserRequest dto) async {
    final res = await _dio.post(ApiConstants.register, data: dto.toJson());
    return UserResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> updateRole(int id, String role) async {
    await _dio.put(ApiConstants.userRole(id), data: {'role': role});
  }

  Future<void> activate(int id) async {
    await _dio.put(ApiConstants.userActivate(id));
  }

  Future<void> deactivate(int id) async {
    await _dio.put(ApiConstants.userDeactivate(id));
  }

  Future<void> resetPassword(int id, ResetPasswordRequest dto) async {
    await _dio.put(ApiConstants.userResetPassword(id), data: dto.toJson());
  }

  Future<void> changePassword(int id, ChangePasswordRequest dto) async {
    await _dio.put(ApiConstants.userChangePassword(id), data: dto.toJson());
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.userById(id));
  }
}
