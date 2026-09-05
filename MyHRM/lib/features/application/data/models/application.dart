class ApplicationRequest {
  final int? applicantId;
  final int? jobPostId;
  final String? coverLetter;
  final String? expectedSalary;
  final String? availableFrom;

  ApplicationRequest({
    this.applicantId,
    this.jobPostId,
    this.coverLetter,
    this.expectedSalary,
    this.availableFrom,
  });

  Map<String, dynamic> toJson() => {
        if (applicantId != null) 'applicantId': applicantId,
        if (jobPostId != null) 'jobPostId': jobPostId,
        if (coverLetter != null) 'coverLetter': coverLetter,
        if (expectedSalary != null) 'expectedSalary': expectedSalary,
        if (availableFrom != null) 'availableFrom': availableFrom,
      };
}

class ApplicationResponse {
  final int id;
  final int? applicantId;
  final String? applicantName;
  final String? applicantEmail;
  final int? jobPostId;
  final String? jobPostTitle;
  final String? status;
  final String? coverLetter;
  final double? expectedSalary;
  final String? availableFrom;
  final String? appliedAt;
  final String? updatedAt;

  ApplicationResponse({
    required this.id,
    this.applicantId,
    this.applicantName,
    this.applicantEmail,
    this.jobPostId,
    this.jobPostTitle,
    this.status,
    this.coverLetter,
    this.expectedSalary,
    this.availableFrom,
    this.appliedAt,
    this.updatedAt,
  });

  factory ApplicationResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationResponse(
      id: json['id'] as int,
      applicantId: json['applicantId'] as int?,
      applicantName: json['applicantName'] as String?,
      applicantEmail: json['applicantEmail'] as String?,
      jobPostId: json['jobPostId'] as int?,
      jobPostTitle: json['jobPostTitle'] as String?,
      status: json['status'] as String?,
      coverLetter: json['coverLetter'] as String?,
      expectedSalary: (json['expectedSalary'] as num?)?.toDouble(),
      availableFrom: json['availableFrom'] as String?,
      appliedAt: json['appliedAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  @override
  String toString() => 'Application #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
