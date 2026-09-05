import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/payslip/data/models/payslip.dart';

class PayslipRepository {
  PayslipRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<PayslipResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.payslips);
    return (res.data as List)
        .map((e) => PayslipResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PayslipResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.payslipById(id));
    return PayslipResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<PayslipResponse>> getByEmployee(int employeeId) async {
    final res = await _dio.get(ApiConstants.payslipByEmployee(employeeId));
    return (res.data as List)
        .map((e) => PayslipResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
