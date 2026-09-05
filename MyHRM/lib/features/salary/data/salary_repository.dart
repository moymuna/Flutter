import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/salary/data/models/salary.dart';

class SalaryRepository {
  SalaryRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<SalaryResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.salaries);
    return (res.data as List)
        .map((e) => SalaryResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<SalaryResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.salaryById(id));
    return SalaryResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<SalaryResponse> getByEmployee(int employeeId) async {
    final res = await _dio.get(ApiConstants.salaryByEmployee(employeeId));
    return SalaryResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<SalaryResponse>> getHistoryByEmployee(int employeeId) async {
    final res =
        await _dio.get(ApiConstants.salaryHistoryByEmployee(employeeId));
    return (res.data as List)
        .map((e) => SalaryResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
