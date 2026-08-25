import 'enums.dart';

class AuthResponse {
  final String? token;
  final String? refreshToken;
  final int? id;
  final String? fullName;
  final String? email;
  final Role? role;

  AuthResponse({
    this.token,
    this.refreshToken,
    this.id,
    this.fullName,
    this.email,
    this.role,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      refreshToken: json['refreshToken'],
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'] != null 
          ? Role.values.firstWhere((e) => e.name.toUpperCase() == json['role'].toString().toUpperCase(), orElse: () => Role.employee) 
          : null,
    );
  }
}

class UserResponse {
  final int? id;
  final String? fullName;
  final String? email;
  final Role? role;
  final bool? enabled;
  final bool? accountLocked;
  final String? photoPath;
  final String? signaturePath;

  UserResponse({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.enabled,
    this.accountLocked,
    this.photoPath,
    this.signaturePath,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'] != null 
          ? Role.values.firstWhere((e) => e.name.toUpperCase() == json['role'].toString().toUpperCase(), orElse: () => Role.employee) 
          : null,
      enabled: json['enabled'],
      accountLocked: json['accountLocked'],
      photoPath: json['photoPath'],
      signaturePath: json['signaturePath'],
    );
  }
}
