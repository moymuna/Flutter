import 'package:dio/dio.dart';
import 'package:my_hrm/core/network/api_client.dart';
import 'package:my_hrm/core/constants/api_constants.dart';
import 'package:my_hrm/features/notification/data/models/notification.dart';

class NotificationRepository {
  NotificationRepository(this._apiClient);
  final ApiClient _apiClient;
  Dio get _dio => _apiClient.dio;

  Future<List<NotificationResponse>> getMine() async {
    final res = await _dio.get(ApiConstants.notificationsMine);
    return (res.data as List)
        .map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<int> getUnreadCount() async {
    final res = await _dio.get(ApiConstants.notificationsUnreadCount);
    return res.data as int;
  }

  Future<void> markAsRead(int id) async {
    await _dio.put(ApiConstants.notificationRead(id));
  }
}
