import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/advance/data/models/advance.dart';

class AdvanceRepository {
  AdvanceRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<AdvanceResponse>> getAll() async {
    final res = await _dio.get(ApiConstants.advancesAll);
    return (res.data as List)
        .map((e) => AdvanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<AdvanceResponse> getById(int id) async {
    final res = await _dio.get(ApiConstants.advanceById(id));
    return AdvanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<AdvanceResponse> create(AdvanceRequest dto) async {
    final res = await _dio.post(ApiConstants.advancesSave, data: dto.toJson());
    return AdvanceResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<void> approve(int id) async {
    await _dio.put(ApiConstants.advanceApprove(id));
  }

  Future<void> reject(int id) async {
    await _dio.put(ApiConstants.advanceReject(id));
  }

  Future<void> pay(int id) async {
    await _dio.put(ApiConstants.advancePay(id));
  }

  Future<void> recover(int id, double amount) async {
    await _dio.put(ApiConstants.advanceRecover(id, amount));
  }

  Future<List<AdvanceResponse>> getByEmployee(int employeeId) async {
    final res = await _dio.get(ApiConstants.advancesByEmployee(employeeId));
    return (res.data as List)
        .map((e) => AdvanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvanceResponse>> getByStatus(String status) async {
    final res = await _dio.get(ApiConstants.advancesByStatus(status));
    return (res.data as List)
        .map((e) => AdvanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<AdvanceResponse>> search(String keyword) async {
    final res = await _dio.get(ApiConstants.advanceSearch(keyword));
    return (res.data as List)
        .map((e) => AdvanceResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> count() async {
    final res = await _dio.get(ApiConstants.advanceCount);
    return res.data as int;
  }

  Future<int> countPending() async {
    final res = await _dio.get(ApiConstants.advanceCountPending);
    return res.data as int;
  }
}
