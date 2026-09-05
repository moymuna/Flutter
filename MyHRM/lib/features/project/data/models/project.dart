class ProjectRequest {
  final String? name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? status;

  ProjectRequest({
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
        if (status != null) 'status': status,
      };
}

class ProjectResponse {
  final int id;
  final String? name;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? status;
  final String? createdAt;

  ProjectResponse({
    required this.id,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
  });

  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
      id: json['id'] as int,
      name: json['name'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => name ?? 'Project #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ProjectResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
