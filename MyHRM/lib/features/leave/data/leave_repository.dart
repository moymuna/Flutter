import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/leave/data/models/leave.dart';

class LeaveRepository {
  LeaveRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<LeaveResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.leavesAll);
    return (res.data as List)
        .map((e) => LeaveResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<LeaveResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.leaveById(id));
    return LeaveResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<LeaveResponse> create(LeaveRequest dto) async {
    final res = await _dio.post(ApiConstants.leavesSave, data: dto.toJson());
    return LeaveResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<LeaveResponse> update(int id, LeaveRequest dto) async {
    final res =
        await _dio.put(ApiConstants.leaveUpdate(id), data: dto.toJson());
    return LeaveResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.leaveDelete(id));
  }

  Future<void> approve(int id) async {
    await _dio.put(ApiConstants.leaveApprove(id));
  }

  Future<void> reject(int id) async {
    await _dio.put(ApiConstants.leaveReject(id));
  }

  Future<void> cancel(int id) async {
    await _dio.put(ApiConstants.leaveCancel(id));
  }

  Future<List<LeaveResponse>> getByEmployee(int employeeId) async {
    final res = await _dio.get(ApiConstants.leavesByEmployee(employeeId));
    return (res.data as List)
        .map((e) => LeaveResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<LeaveResponse>> getByStatus(String status) async {
    final res = await _dio.get(ApiConstants.leavesByStatus(status));
    return (res.data as List)
        .map((e) => LeaveResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<LeaveResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.leaveSearch(keyword));
    return (res.data as List)
        .map((e) => LeaveResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.leaveCount);
    return res.data as int;
  }
}
