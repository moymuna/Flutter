class UserRequest {
  final String? fullName;
  final String? email;
  final String? password;
  final String? role;
  final bool? enabled;

  UserRequest({
    this.fullName,
    this.email,
    this.password,
    this.role,
    this.enabled,
  });

  Map<String, dynamic> toJson() => {
        if (fullName != null) 'fullName': fullName,
        if (email != null) 'email': email,
        if (password != null) 'password': password,
        if (role != null) 'role': role,
        if (enabled != null) 'enabled': enabled,
      };
}

class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      };
}

class ResetPasswordRequest {
  final String? newPassword;

  ResetPasswordRequest({this.newPassword});

  Map<String, dynamic> toJson() => {
        if (newPassword != null) 'newPassword': newPassword,
      };
}

class UserResponse {
  final int id;
  final String? fullName;
  final String? email;
  final String? role;
  final bool? enabled;
  final String? createdAt;

  UserResponse({
    required this.id,
    this.fullName,
    this.email,
    this.role,
    this.enabled,
    this.createdAt,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] as int,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      enabled: json['enabled'] as bool?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => fullName ?? email ?? 'User #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
