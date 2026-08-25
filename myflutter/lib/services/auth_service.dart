import 'dart:convert';
import '../models/auth_models.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<AuthResponse?> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final authResponse = AuthResponse.fromJson(data);
        
        final prefs = await SharedPreferences.getInstance();
        if (authResponse.token != null) {
          await prefs.setString('token', authResponse.token!);
        }
        if (authResponse.refreshToken != null) {
          await prefs.setString('refreshToken', authResponse.refreshToken!);
        }
        
        return authResponse;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> signup(Map<String, dynamic> userData) async {
    try {
      final response = await _apiService.post('/auth/signup', userData);
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refreshToken');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }
}
