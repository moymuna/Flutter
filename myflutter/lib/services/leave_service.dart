import 'dart:convert';
import '../models/hrm_models.dart';
import 'api_service.dart';

class LeaveService {
  final ApiService _apiService = ApiService();

  Future<bool> applyLeave(Map<String, dynamic> leaveData) async {
    try {
      final response = await _apiService.post('/leaves/save', leaveData);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<List<LeaveResponse>> getMyLeaves(int employeeId) async {
    try {
      final response = await _apiService.get('/leaves/employee/$employeeId');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => LeaveResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<LeaveResponse>> getAllLeavesForApproval() async {
    try {
      final response = await _apiService.get('/leaves/all');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => LeaveResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> approveLeave(int leaveId) async {
    try {
      final response = await _apiService.put('/leaves/approve/$leaveId', {});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> rejectLeave(int leaveId, String reason) async {
    try {
      final response = await _apiService.put('/leaves/reject/$leaveId?rejectionReason=$reason', {});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
