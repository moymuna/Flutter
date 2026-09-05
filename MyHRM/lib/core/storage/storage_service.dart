import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys {
  StorageKeys._();
  static const String token = 'cm_token';
  static const String user = 'cm_user';
  static const String employee = 'cm_employee';
  static const String admin = 'cm_admin';
  static const String hr = 'cm_hr';
  static const String applicant = 'cm_applicant';
  static const String manager = 'cm_manager';
}

class StorageService {
  StorageService(this._storage);
  final FlutterSecureStorage _storage;

  Future<void> saveSession(Map<String, dynamic> data) async {
    await _storage.write(
        key: StorageKeys.token, value: data['token'] as String?);
    await _storage.write(
        key: StorageKeys.user, value: jsonEncode(data));
  }

  Future<String?> getToken() => _storage.read(key: StorageKeys.token);

  Future<Map<String, dynamic>?> getUser() async {
    final raw = await _storage.read(key: StorageKeys.user);
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<String?> getRole() async => (await getUser())?['role'] as String?;

  Future<int?> getUserId() async => (await getUser())?['userId'] as int?;

  Future<bool> isLoggedIn() async => (await getToken()) != null;

  Future<void> clearSession() async {
    await _storage.delete(key: StorageKeys.token);
    await _storage.delete(key: StorageKeys.user);
    await _storage.delete(key: StorageKeys.employee);
    await _storage.delete(key: StorageKeys.admin);
    await _storage.delete(key: StorageKeys.hr);
    await _storage.delete(key: StorageKeys.manager);
    await _storage.delete(key: StorageKeys.applicant);
  }

  Future<void> saveData(String key, Map<String, dynamic> data) =>
      _storage.write(key: key, value: jsonEncode(data));

  Future<Map<String, dynamic>?> getData(String key) async {
    final raw = await _storage.read(key: key);
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  Future<void> removeData(String key) => _storage.delete(key: key);
}
