import 'dart:convert';
import '../models/hrm_models.dart';
import 'api_service.dart';

class AttendanceService {
  final ApiService _apiService = ApiService();

  Future<AttendanceResponse?> clockIn(int employeeId) async {
    try {
      final response = await _apiService.post('/attendance/clock-in/$employeeId', {});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AttendanceResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<AttendanceResponse?> clockOut(int employeeId) async {
    try {
      final response = await _apiService.put('/attendance/clock-out/$employeeId', {});
      if (response.statusCode == 200 || response.statusCode == 201) {
        return AttendanceResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<AttendanceResponse?> getTodayAttendance(int employeeId) async {
    try {
      final response = await _apiService.get('/attendance/today/$employeeId');
      if (response.statusCode == 200) {
        return AttendanceResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<AttendanceResponse>> getAttendanceHistory(int employeeId, int year, int month) async {
    try {
      final response = await _apiService.get('/attendance/employee/$employeeId?year=$year&month=$month');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => AttendanceResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<AttendanceSummary?> getMonthlySummary(int employeeId, int year, int month) async {
    try {
      final response = await _apiService.get('/attendance/employee/$employeeId/summary?year=$year&month=$month');
      if (response.statusCode == 200) {
        return AttendanceSummary.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
