import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/attendance/data/models/attendance.dart';

class AttendanceRepository {
  AttendanceRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<AttendanceResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.attendanceAll);
    return (res.data as List)
        .map((e) => AttendanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AttendanceResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.attendanceById(id));
    return AttendanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<AttendanceResponse> create(AttendanceRequest dto) async {
    final res = await _dio.post(ApiConstants.attendanceSave, data: dto.toJson());
    return AttendanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<AttendanceResponse> update(int id, AttendanceRequest dto) async {
    final res = await _dio.put(
      ApiConstants.attendanceUpdate(id),
      data: dto.toJson(),
    );
    return AttendanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.attendanceDelete(id));
  }

  Future<AttendanceResponse> clockIn(int employeeId) async {
    final res = await _dio.post(ApiConstants.attendanceClockIn(employeeId));
    return AttendanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<AttendanceResponse> clockOut(int employeeId) async {
    final res = await _dio.post(ApiConstants.attendanceClockOut(employeeId));
    return AttendanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<AttendanceResponse> getToday(int employeeId) async {
    final res = await _dio.get(ApiConstants.attendanceToday(employeeId));
    return AttendanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<AttendanceResponse>> getByEmployee(
      int employeeId, int year, int month) async {
    final res = await _dio.get(
      ApiConstants.attendanceByEmployee(employeeId, year, month),
    );
    return (res.data as List)
        .map((e) => AttendanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AttendanceResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.attendanceSearch(keyword));
    return (res.data as List)
        .map((e) => AttendanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.attendanceCount);
    return res.data as int;
  }
}
