import 'dart:convert';
import '../models/payroll_models.dart';
import 'api_service.dart';

class PayrollService {
  final ApiService _apiService = ApiService();

  Future<SalaryResponse?> getMySalaryStructure(int employeeId) async {
    try {
      final response = await _apiService.get('/salary/employee/$employeeId');
      if (response.statusCode == 200) {
        return SalaryResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<PayrollResponse>> getMyPayrollHistory(int employeeId) async {
    try {
      final response = await _apiService.get('/payroll/employee/$employeeId');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => PayrollResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<PayrollResponse>> getAllPayrolls() async {
    try {
      final response = await _apiService.get('/payroll');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => PayrollResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> generatePayroll(int year, int month) async {
    try {
      final response = await _apiService.post('/payroll/generate-all/$year/$month', {});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> payPayroll(int payrollId) async {
    try {
      final response = await _apiService.put('/payroll/$payrollId/pay', {});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
