import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/salary_grade/data/models/salary_grade.dart';

class SalaryGradeRepository {
  SalaryGradeRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<SalaryGradeResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.salaryGrades);
    return (res.data as List)
        .map((e) => SalaryGradeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<SalaryGradeResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.salaryGradeById(id));
    return SalaryGradeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<SalaryGradeResponse>> getActive() async {
    final res = await _dio.get(ApiConstants.salaryGradesActive);
    return (res.data as List)
        .map((e) => SalaryGradeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
