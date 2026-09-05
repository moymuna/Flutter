import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/designation/data/models/designation.dart';

class DesignationRepository {
  DesignationRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<DesignationResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.designations);
    return (res.data as List)
        .map((e) => DesignationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DesignationResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.designationById(id));
    return DesignationResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<DesignationResponse>> getByDepartment(int departmentId) async {
    final res =
        await _dio.get(ApiConstants.designationsByDepartment(departmentId));
    return (res.data as List)
        .map((e) => DesignationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DesignationResponse> create(DesignationRequest dto) async {
    final res =
        await _dio.post(ApiConstants.designations, data: dto.toJson());
    return DesignationResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<DesignationResponse> update(int id, DesignationRequest dto) async {
    final res = await _dio.put(ApiConstants.designationById(id),
        data: dto.toJson());
    return DesignationResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.designationById(id));
  }

  Future<List<DesignationResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.designationSearch(keyword));
    return (res.data as List)
        .map((e) => DesignationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.designationCount);
    return res.data as int;
  }
}
