import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/performance_review/data/models/performance_review.dart';

class PerformanceReviewRepository {
  PerformanceReviewRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<PerformanceReviewResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.performanceReviews);
    return (res.data as List)
        .map((e) => PerformanceReviewResponse.fromJson(
            e as Map<String, dynamic>))
        .toList();
  }

  Future<PerformanceReviewResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.performanceReviewById(id));
    return PerformanceReviewResponse.fromJson(
        res.data as Map<String, dynamic>);
  }

  Future<PerformanceReviewResponse> create(PerformanceReviewRequest dto) async {
    final res =
        await _dio.post(ApiConstants.performanceReviews, data: dto.toJson());
    return PerformanceReviewResponse.fromJson(
        res.data as Map<String, dynamic>);
  }

  Future<PerformanceReviewResponse> update(
      int id, PerformanceReviewRequest dto) async {
    final res = await _dio.put(
      ApiConstants.performanceReviewById(id),
      data: dto.toJson(),
    );
    return PerformanceReviewResponse.fromJson(
        res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.performanceReviewById(id));
  }
}
