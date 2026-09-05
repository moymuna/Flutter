class DesignationRequest {
  final String title;
  final String? level;
  final int? departmentId;

  DesignationRequest({
    required this.title,
    this.level,
    this.departmentId,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        if (level != null) 'level': level,
        if (departmentId != null) 'departmentId': departmentId,
      };
}

class DesignationResponse {
  final int id;
  final String title;
  final String? level;
  final int? departmentId;
  final String? departmentName;

  DesignationResponse({
    required this.id,
    required this.title,
    this.level,
    this.departmentId,
    this.departmentName,
  });

  factory DesignationResponse.fromJson(Map<String, dynamic> json) {
    return DesignationResponse(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      level: json['level'] as String?,
      departmentId: json['departmentId'] as int?,
      departmentName: json['departmentName'] as String?,
    );
  }

  @override
  String toString() => title;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DesignationResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
