import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/leave_balance/data/models/leave_balance.dart';

class LeaveBalanceRepository {
  LeaveBalanceRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<LeaveBalanceResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.leaveBalanceAll);
    return (res.data as List)
        .map((e) => LeaveBalanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<LeaveBalanceResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.leaveBalanceById(id));
    return LeaveBalanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<LeaveBalanceResponse>> getByEmployee(int employeeId) async {
    final res =
        await _dio.get(ApiConstants.leaveBalanceByEmployee(employeeId));
    return (res.data as List)
        .map((e) => LeaveBalanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<LeaveBalanceResponse>> getByYear(int year) async {
    final res = await _dio.get(ApiConstants.leaveBalanceByYear(year));
    return (res.data as List)
        .map((e) => LeaveBalanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
