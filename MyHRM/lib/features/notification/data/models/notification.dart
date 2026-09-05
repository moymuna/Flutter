class NotificationResponse {
  final int id;
  final String? title;
  final String? message;
  final bool? isRead;
  final String? type;
  final String? createdAt;

  NotificationResponse({
    required this.id,
    this.title,
    this.message,
    this.isRead,
    this.type,
    this.createdAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'] as int,
      title: json['title'] as String?,
      message: json['message'] as String?,
      isRead: json['isRead'] as bool?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => title ?? 'Notification #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
