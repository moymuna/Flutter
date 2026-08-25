import 'dart:convert';
import '../models/metadata_models.dart';
import 'api_service.dart';

class MetadataService {
  final ApiService _apiService = ApiService();

  Future<List<DepartmentResponse>> getDepartments() async {
    try {
      final response = await _apiService.get('/department');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => DepartmentResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<DesignationResponse>> getDesignations() async {
    try {
      final response = await _apiService.get('/designation');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => DesignationResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<OfficeResponse>> getOffices() async {
    try {
      final response = await _apiService.get('/office');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => OfficeResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<LeaveTypeResponse>> getLeaveTypes() async {
    try {
      final response = await _apiService.get('/leave-types/all');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => LeaveTypeResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
