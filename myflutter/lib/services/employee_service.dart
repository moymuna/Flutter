import 'dart:convert';
import 'dart:io';
import '../models/employee_models.dart';
import 'api_service.dart';

class EmployeeService {
  final ApiService _apiService = ApiService();

  Future<bool> saveEmployee(Map<String, dynamic> employeeData, File? imageFile) async {
    try {
      final fields = {
        'employee': jsonEncode(employeeData),
      };
      final response = await _apiService.postMultipart('/employees', fields, imageFile);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<List<EmployeeResponse>> getAllEmployees() async {
    try {
      final response = await _apiService.get('/employees');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => EmployeeResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<EmployeeResponse?> getEmployeeByUserId(int userId) async {
    try {
      final response = await _apiService.get('/employees/user/$userId');
      if (response.statusCode == 200) {
        return EmployeeResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<int> getEmployeeCount() async {
    try {
      final response = await _apiService.get('/employees/count');
      if (response.statusCode == 200) {
        return int.parse(response.body);
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  Future<Map<String, int>> getHeadcountByDepartment() async {
    try {
      final response = await _apiService.get('/employees/stats/by-department');
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data.map((key, value) => MapEntry(key, value as int));
      }
      return {};
    } catch (e) {
      return {};
    }
  }
}
