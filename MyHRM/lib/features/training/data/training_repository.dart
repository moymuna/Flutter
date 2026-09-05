import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/training/data/models/training.dart';

class TrainingRepository {
  TrainingRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<TrainingResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.trainings);
    return (res.data as List)
        .map((e) => TrainingResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<TrainingResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.trainingById(id));
    return TrainingResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<TrainingResponse> create(TrainingRequest dto) async {
    final res = await _dio.post(ApiConstants.trainings, data: dto.toJson());
    return TrainingResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<TrainingResponse> update(int id, TrainingRequest dto) async {
    final res =
        await _dio.put(ApiConstants.trainingById(id), data: dto.toJson());
    return TrainingResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.trainingById(id));
  }

  Future<void> approve(int id) async {
    await _dio.put(ApiConstants.trainingApprove(id));
  }

  Future<void> reject(int id) async {
    await _dio.put(ApiConstants.trainingReject(id));
  }

  Future<void> apply(int id, int employeeId) async {
    await _dio.post(ApiConstants.trainingApply(id, employeeId));
  }
}
