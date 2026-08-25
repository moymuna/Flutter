import 'package:flutter/material.dart';
import '../models/auth_models.dart';
import '../models/employee_models.dart';
import '../services/auth_service.dart';
import '../services/employee_service.dart';
import '../services/notification_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final EmployeeService _employeeService = EmployeeService();
  final NotificationService _notificationService = NotificationService();
  AuthResponse? _user;
  EmployeeResponse? _employee;
  int _unreadNotifications = 0;
  bool _isLoading = false;

  AuthResponse? get user => _user;
  EmployeeResponse? get employee => _employee;
  int get unreadNotifications => _unreadNotifications;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  Future<void> fetchUnreadCount() async {
    if (isAuthenticated) {
      _unreadNotifications = await _notificationService.getUnreadCount();
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _authService.login(email, password);
    
    if (result != null) {
      _user = result;
      // Fetch employee details using userId
      if (result.id != null) {
        _employee = await _employeeService.getEmployeeByUserId(result.id!);
      }
      await fetchUnreadCount();
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (loggedIn) {
      // In a real app, you might want to fetch the user profile here
      // For now, we'll just assume we're logged in if a token exists
      // You could also decode the JWT to get basic info
    }
  }
}
