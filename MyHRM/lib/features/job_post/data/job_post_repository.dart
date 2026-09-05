import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/job_post/data/models/job_post.dart';

class JobPostRepository {
  JobPostRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<JobPostResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.jobPosts);
    return (res.data as List)
        .map((e) => JobPostResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<JobPostResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.jobPostById(id));
    return JobPostResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<JobPostResponse> create(JobPostRequest dto) async {
    final res = await _dio.post(ApiConstants.jobPosts, data: dto.toJson());
    return JobPostResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<JobPostResponse> update(int id, JobPostRequest dto) async {
    final res =
        await _dio.put(ApiConstants.jobPostById(id), data: dto.toJson());
    return JobPostResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.jobPostById(id));
  }

  Future<List<JobPostResponse>> getByStatus(String status) async {
    final res = await _dio.get(ApiConstants.jobPostsByStatus(status));
    return (res.data as List)
        .map((e) => JobPostResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<JobPostResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.jobPostSearch(keyword));
    return (res.data as List)
        .map((e) => JobPostResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.jobPostCount);
    return res.data as int;
  }
}
