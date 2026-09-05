import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/department/data/models/department.dart';

class DepartmentRepository {
  DepartmentRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<DepartmentResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.departments);
    return (res.data as List)
        .map((e) => DepartmentResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DepartmentResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.departmentById(id));
    return DepartmentResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<DepartmentResponse> create(DepartmentRequest dto) async {
    final res = await _dio.post(ApiConstants.departments, data: dto.toJson());
    return DepartmentResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<DepartmentResponse> update(int id, DepartmentRequest dto) async {
    final res = await _dio.put(ApiConstants.departmentById(id),
        data: dto.toJson());
    return DepartmentResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.departmentById(id));
  }

  Future<List<DepartmentResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.departmentSearch(keyword));
    return (res.data as List)
        .map((e) => DepartmentResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.departmentCount);
    return res.data as int;
  }
}
