class TrainingRequest {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? location;
  final int? maxParticipants;
  final String? status;

  TrainingRequest({
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.maxParticipants,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
        if (location != null) 'location': location,
        if (maxParticipants != null) 'maxParticipants': maxParticipants,
        if (status != null) 'status': status,
      };
}

class TrainingResponse {
  final int id;
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? location;
  final int? maxParticipants;
  final int? currentParticipants;
  final String? status;
  final String? createdAt;

  TrainingResponse({
    required this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
    this.maxParticipants,
    this.currentParticipants,
    this.status,
    this.createdAt,
  });

  factory TrainingResponse.fromJson(Map<String, dynamic> json) {
    return TrainingResponse(
      id: json['id'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      location: json['location'] as String?,
      maxParticipants: json['maxParticipants'] as int?,
      currentParticipants: json['currentParticipants'] as int?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => title ?? 'Training #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TrainingResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
