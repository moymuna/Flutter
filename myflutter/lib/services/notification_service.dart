import 'dart:convert';
import '../models/communication_models.dart';
import 'api_service.dart';

class NotificationService {
  final ApiService _apiService = ApiService();

  Future<List<NotificationResponse>> getMyNotifications() async {
    try {
      final response = await _apiService.get('/notifications/mine');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => NotificationResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _apiService.get('/notifications/mine/unread-count');
      if (response.statusCode == 200) {
        return int.parse(response.body);
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      await _apiService.put('/notifications/$id/read', {});
    } catch (e) {
      // Ignore
    }
  }
}
