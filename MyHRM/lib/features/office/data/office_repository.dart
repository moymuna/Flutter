import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/office/data/models/office.dart';

class OfficeRepository {
  OfficeRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<OfficeResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.offices);
    return (res.data as List)
        .map((e) => OfficeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<OfficeResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.officeById(id));
    return OfficeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<OfficeResponse> create(OfficeRequest dto) async {
    final res = await _dio.post(ApiConstants.offices, data: dto.toJson());
    return OfficeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<OfficeResponse> update(int id, OfficeRequest dto) async {
    final res =
        await _dio.put(ApiConstants.officeById(id), data: dto.toJson());
    return OfficeResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.officeById(id));
  }

  Future<List<OfficeResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.officeSearch(keyword));
    return (res.data as List)
        .map((e) => OfficeResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.officeCount);
    return res.data as int;
  }
}
