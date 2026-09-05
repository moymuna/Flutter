class PerformanceReviewRequest {
  final int? employeeId;
  final String? reviewPeriod;
  final int? rating;
  final String? comments;
  final String? goals;
  final String? status;

  PerformanceReviewRequest({
    this.employeeId,
    this.reviewPeriod,
    this.rating,
    this.comments,
    this.goals,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        if (employeeId != null) 'employeeId': employeeId,
        if (reviewPeriod != null) 'reviewPeriod': reviewPeriod,
        if (rating != null) 'rating': rating,
        if (comments != null) 'comments': comments,
        if (goals != null) 'goals': goals,
        if (status != null) 'status': status,
      };
}

class PerformanceReviewResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final String? reviewPeriod;
  final int? rating;
  final String? comments;
  final String? goals;
  final String? status;
  final String? createdAt;

  PerformanceReviewResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.reviewPeriod,
    this.rating,
    this.comments,
    this.goals,
    this.status,
    this.createdAt,
  });

  factory PerformanceReviewResponse.fromJson(Map<String, dynamic> json) {
    return PerformanceReviewResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      reviewPeriod: json['reviewPeriod'] as String?,
      rating: json['rating'] as int?,
      comments: json['comments'] as String?,
      goals: json['goals'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => 'Review #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerformanceReviewResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
