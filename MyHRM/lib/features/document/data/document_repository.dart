import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/document/data/models/document.dart';

class DocumentRepository {
  DocumentRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<DocumentResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.documents);
    return (res.data as List)
        .map((e) => DocumentResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DocumentResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.documentById(id));
    return DocumentResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<DocumentResponse>> getByEmployee(int employeeId) async {
    final res = await _dio.get(ApiConstants.documentsByEmployee(employeeId));
    return (res.data as List)
        .map((e) => DocumentResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.documentById(id));
  }
}
