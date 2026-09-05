import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/employee/data/models/employee.dart';

class EmployeeRepository {
  EmployeeRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<EmployeeResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.employees);
    return (res.data as List)
        .map((e) => EmployeeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<EmployeeResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.employeeById(id));
    return EmployeeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<EmployeeResponse> getByUserId(int userId) async {
    final res = await _dio.get(ApiConstants.employeeByUserId(userId));
    return EmployeeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<EmployeeResponse> create(EmployeeRequest dto) async {
    final res = await _dio.post(ApiConstants.employees, data: dto.toJson());
    return EmployeeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<EmployeeResponse> update(int id, EmployeeRequest dto) async {
    final res =
        await _dio.put(ApiConstants.employeeById(id), data: dto.toJson());
    return EmployeeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.employeeById(id));
  }

  Future<List<EmployeeResponse>> getByDepartment(int departmentId) async {
    final res =
        await _dio.get(ApiConstants.employeesByDepartment(departmentId));
    return (res.data as List)
        .map((e) => EmployeeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<EmployeeResponse>> getByDesignation(int designationId) async {
    final res =
        await _dio.get(ApiConstants.employeesByDesignation(designationId));
    return (res.data as List)
        .map((e) => EmployeeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<EmployeeResponse>> getByOffice(int officeId) async {
    final res = await _dio.get(ApiConstants.employeesByOffice(officeId));
    return (res.data as List)
        .map((e) => EmployeeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<EmployeeResponse>> getByManager(int managerId) async {
    final res = await _dio.get(ApiConstants.employeesByManager(managerId));
    return (res.data as List)
        .map((e) => EmployeeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<EmployeeResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.employeeSearch(keyword));
    return (res.data as List)
        .map((e) => EmployeeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.employeeCount);
    return res.data as int;
  }

  Future<int> countActive() async {
    final res = await _dio.get(ApiConstants.employeeCountActive);
    return res.data as int;
  }

  Future<String> uploadImage(String filePath) async {
    final fileName = filePath.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    final res = await _dio.post(ApiConstants.upload, data: formData);
    return (res.data as Map<String, dynamic>)['filePath'] as String;
  }
}
