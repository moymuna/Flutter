import 'dart:convert';
import '../models/communication_models.dart';
import 'api_service.dart';

class NoticeService {
  final ApiService _apiService = ApiService();

  Future<List<NoticeResponse>> getAllNotices() async {
    try {
      final response = await _apiService.get('/notice');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => NoticeResponse.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveNotice(Map<String, dynamic> noticeData) async {
    try {
      final response = await _apiService.post('/notice', noticeData);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNotice(int id) async {
    try {
      final response = await _apiService.delete('/notice/$id');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
