import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/notice/data/models/notice.dart';

class NoticeRepository {
  NoticeRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<NoticeResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.notices);
    return (res.data as List)
        .map((e) => NoticeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<NoticeResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.noticeById(id));
    return NoticeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<NoticeResponse> create(NoticeRequest dto) async {
    final res = await _dio.post(ApiConstants.notices, data: dto.toJson());
    return NoticeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<NoticeResponse> update(int id, NoticeRequest dto) async {
    final res =
        await _dio.put(ApiConstants.noticeById(id), data: dto.toJson());
    return NoticeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.noticeById(id));
  }
}
