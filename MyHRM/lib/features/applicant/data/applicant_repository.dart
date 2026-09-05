import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/applicant/data/models/applicant.dart';

class ApplicantRepository {
  ApplicantRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<ApplicantResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.applicants);
    return (res.data as List)
        .map((e) => ApplicantResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ApplicantResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.applicantById(id));
    return ApplicantResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ApplicantResponse> getByEmail(String email) async {
    final res = await _dio.get(ApiConstants.applicantByEmail(email));
    return ApplicantResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ApplicantResponse> create(ApplicantRequest dto) async {
    final res = await _dio.post(ApiConstants.applicants, data: dto.toJson());
    return ApplicantResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ApplicantResponse> update(int id, ApplicantRequest dto) async {
    final res =
        await _dio.put(ApiConstants.applicantById(id), data: dto.toJson());
    return ApplicantResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.applicantById(id));
  }

  Future<List<ApplicantResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.applicantSearch(keyword));
    return (res.data as List)
        .map((e) => ApplicantResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.applicantCount);
    return res.data as int;
  }
}
