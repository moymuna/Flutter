import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/project/data/models/project.dart';

class ProjectRepository {
  ProjectRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<ProjectResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.projects);
    return (res.data as List)
        .map((e) => ProjectResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ProjectResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.projectById(id));
    return ProjectResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ProjectResponse> create(ProjectRequest dto) async {
    final res = await _dio.post(ApiConstants.projects, data: dto.toJson());
    return ProjectResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ProjectResponse> update(int id, ProjectRequest dto) async {
    final res =
        await _dio.put(ApiConstants.projectById(id), data: dto.toJson());
    return ProjectResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.projectById(id));
  }
}
