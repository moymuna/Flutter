import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/interview/data/models/interview.dart';

class InterviewRepository {
  InterviewRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<InterviewResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.interviews);
    return (res.data as List)
        .map((e) => InterviewResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<InterviewResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.interviewById(id));
    return InterviewResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<InterviewResponse> schedule(InterviewRequest dto) async {
    final res =
        await _dio.post(ApiConstants.interviewSchedule, data: dto.toJson());
    return InterviewResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<InterviewResponse> update(int id, InterviewRequest dto) async {
    final res =
        await _dio.put(ApiConstants.interviewById(id), data: dto.toJson());
    return InterviewResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.interviewById(id));
  }

  Future<List<InterviewResponse>> getByApplication(int applicationId) async {
    final res =
        await _dio.get(ApiConstants.interviewsByApplication(applicationId));
    return (res.data as List)
        .map((e) => InterviewResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<InterviewResponse>> getByInterviewer(int interviewerId) async {
    final res =
        await _dio.get(ApiConstants.interviewsByInterviewer(interviewerId));
    return (res.data as List)
        .map((e) => InterviewResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<InterviewResponse>> getMy() async {
    final res = await _dio.get(ApiConstants.interviewsMy);
    return (res.data as List)
        .map((e) => InterviewResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
