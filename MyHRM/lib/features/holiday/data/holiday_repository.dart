import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/holiday/data/models/holiday.dart';

class HolidayRepository {
  HolidayRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<HolidayResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.holidaysAll);
    return (res.data as List)
        .map((e) => HolidayResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<HolidayResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.holidayById(id));
    return HolidayResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<HolidayResponse> create(HolidayRequest dto) async {
    final res = await _dio.post(ApiConstants.holidays, data: dto.toJson());
    return HolidayResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<HolidayResponse> update(int id, HolidayRequest dto) async {
    final res = await _dio.put(
      ApiConstants.holidayUpdate(id),
      data: dto.toJson(),
    );
    return HolidayResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> delete(int id) async {
    await _dio.delete(ApiConstants.holidayDelete(id));
  }

  Future<List<HolidayResponse>> getUpcoming(int limit) async {
    final res = await _dio.get(ApiConstants.holidayUpcoming(limit));
    return (res.data as List)
        .map((e) => HolidayResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
