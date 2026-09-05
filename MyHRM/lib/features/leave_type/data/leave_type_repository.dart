import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/leave_type/data/models/leave_type.dart';

class LeaveTypeRepository {
  LeaveTypeRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<LeaveTypeResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.leaveTypesAll);
    return (res.data as List)
        .map((e) => LeaveTypeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<LeaveTypeResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.leaveTypeById(id));
    return LeaveTypeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<LeaveTypeResponse> create(LeaveTypeRequest dto) async {
    final res = await _dio.post(ApiConstants.leaveTypes, data: dto.toJson());
    return LeaveTypeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<LeaveTypeResponse> update(int id, LeaveTypeRequest dto) async {
    final res = await _dio.put(
      ApiConstants.leaveTypeUpdate(id),
      data: dto.toJson(),
    );
    return LeaveTypeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.leaveTypeDelete(id));
  }
}
