import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/application/data/models/application.dart';

class ApplicationRepository {
  ApplicationRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<ApplicationResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.applications);
    return (res.data as List)
        .map((e) => ApplicationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ApplicationResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.applicationById(id));
    return ApplicationResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ApplicationResponse> apply(ApplicationRequest dto) async {
    final res =
        await _dio.post(ApiConstants.applicationApply, data: dto.toJson());
    return ApplicationResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ApplicationResponse> updateStatus(int id, String status) async {
    final res = await _dio.put(
      ApiConstants.applicationStatus(id),
      data: {'status': status},
    );
    return ApplicationResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> withdraw(int id) async {
    await _dio.put(ApiConstants.applicationWithdraw(id));
  }

  Future<List<ApplicationResponse>> getByApplicant(int applicantId) async {
    final res =
        await _dio.get(ApiConstants.applicationsByApplicant(applicantId));
    return (res.data as List)
        .map((e) => ApplicationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ApplicationResponse>> getByJobPost(int jobPostId) async {
    final res = await _dio.get(ApiConstants.applicationsByJobPost(jobPostId));
    return (res.data as List)
        .map((e) => ApplicationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ApplicationResponse>> getByStatus(String status) async {
    final res = await _dio.get(ApiConstants.applicationsByStatus(status));
    return (res.data as List)
        .map((e) => ApplicationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ApplicationResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.applicationSearch(keyword));
    return (res.data as List)
        .map((e) => ApplicationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.applicationCount);
    return res.data as int;
  }
}
