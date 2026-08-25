class NoticeResponse {
  final int? id;
  final String? title;
  final String? description;
  final DateTime? publishDate;
  final String? officeName;

  NoticeResponse({this.id, this.title, this.description, this.publishDate, this.officeName});

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    return NoticeResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      publishDate: json['publishDate'] != null ? DateTime.parse(json['publishDate']) : null,
      officeName: json['officeName'],
    );
  }
}

class NotificationResponse {
  final int? id;
  final String? message;
  final String? relatedEntityType;
  final int? relatedEntityId;
  final bool isRead;
  final DateTime? createdAt;

  NotificationResponse({
    this.id,
    this.message,
    this.relatedEntityType,
    this.relatedEntityId,
    required this.isRead,
    this.createdAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: json['id'],
      message: json['message'],
      relatedEntityType: json['relatedEntityType'],
      relatedEntityId: json['relatedEntityId'],
      isRead: json['read'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
