import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/audit_log/data/models/audit_log.dart';

class AuditLogRepository {
  AuditLogRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<AuditLogResponse>> getLatest() async {
    final res = await _dio.get(ApiConstants.auditLogLatest);
    return (res.data as List)
        .map((e) => AuditLogResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AuditLogResponse>> getByPage(int page, int size) async {
    final res = await _dio.get(ApiConstants.auditLogPage(page, size));
    return (res.data as List)
        .map((e) => AuditLogResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AuditLogResponse>> getByEntity(String type, int id) async {
    final res = await _dio.get(ApiConstants.auditLogByEntity(type, id));
    return (res.data as List)
        .map((e) => AuditLogResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
