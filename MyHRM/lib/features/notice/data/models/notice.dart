class NoticeRequest {
  final String? title;
  final String? content;
  final String? noticeType;

  NoticeRequest({
    this.title,
    this.content,
    this.noticeType,
  });

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        if (content != null) 'content': content,
        if (noticeType != null) 'noticeType': noticeType,
      };
}

class NoticeResponse {
  final int id;
  final String? title;
  final String? content;
  final String? noticeType;
  final String? createdAt;

  NoticeResponse({
    required this.id,
    this.title,
    this.content,
    this.noticeType,
    this.createdAt,
  });

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    return NoticeResponse(
      id: json['id'] as int,
      title: json['title'] as String?,
      content: json['content'] as String?,
      noticeType: json['noticeType'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => title ?? 'Notice #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NoticeResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
