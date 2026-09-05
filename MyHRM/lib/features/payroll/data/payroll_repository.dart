import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/payroll/data/models/payroll.dart';

class PayrollRepository {
  PayrollRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<PayrollResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.payrolls);
    return (res.data as List)
        .map((e) => PayrollResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PayrollResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.payrollById(id));
    return PayrollResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<PayrollResponse>> getByEmployee(int employeeId) async {
    final res = await _dio.get(ApiConstants.payrollByEmployee(employeeId));
    return (res.data as List)
        .map((e) => PayrollResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PayrollResponse>> getSheet(int year, int month) async {
    final res = await _dio.get(ApiConstants.payrollSheet(year, month));
    return (res.data as List)
        .map((e) => PayrollResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> pay(int id) async {
    await _dio.put(ApiConstants.payrollPay(id));
  }

  Future<void> generate(int employeeId, int year, int month) async {
    await _dio.post(ApiConstants.payrollGenerate(employeeId, year, month));
  }

  Future<void> generateAll(int year, int month) async {
    await _dio.post(ApiConstants.payrollGenerateAll(year, month));
  }

  Future<List<PayrollResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.payrollSearch(keyword));
    return (res.data as List)
        .map((e) => PayrollResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.payrollCount);
    return res.data as int;
  }
}
