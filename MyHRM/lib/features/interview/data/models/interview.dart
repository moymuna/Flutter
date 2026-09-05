class InterviewRequest {
  final int? applicationId;
  final String? interviewDate;
  final String? interviewTime;
  final String? interviewType;
  final String? location;
  final String? notes;
  final List<int>? boardMemberIds;

  InterviewRequest({
    this.applicationId,
    this.interviewDate,
    this.interviewTime,
    this.interviewType,
    this.location,
    this.notes,
    this.boardMemberIds,
  });

  Map<String, dynamic> toJson() => {
        if (applicationId != null) 'applicationId': applicationId,
        if (interviewDate != null) 'interviewDate': interviewDate,
        if (interviewTime != null) 'interviewTime': interviewTime,
        if (interviewType != null) 'interviewType': interviewType,
        if (location != null) 'location': location,
        if (notes != null) 'notes': notes,
        if (boardMemberIds != null) 'boardMemberIds': boardMemberIds,
      };
}

class InterviewResponse {
  final int id;
  final int? applicationId;
  final String? applicantName;
  final String? jobPostTitle;
  final String? interviewDate;
  final String? interviewTime;
  final String? interviewType;
  final String? location;
  final String? notes;
  final String? status;
  final String? result;
  final List<int>? boardMemberIds;
  final String? createdAt;

  InterviewResponse({
    required this.id,
    this.applicationId,
    this.applicantName,
    this.jobPostTitle,
    this.interviewDate,
    this.interviewTime,
    this.interviewType,
    this.location,
    this.notes,
    this.status,
    this.result,
    this.boardMemberIds,
    this.createdAt,
  });

  factory InterviewResponse.fromJson(Map<String, dynamic> json) {
    return InterviewResponse(
      id: json['id'] as int,
      applicationId: json['applicationId'] as int?,
      applicantName: json['applicantName'] as String?,
      jobPostTitle: json['jobPostTitle'] as String?,
      interviewDate: json['interviewDate'] as String?,
      interviewTime: json['interviewTime'] as String?,
      interviewType: json['interviewType'] as String?,
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as String?,
      result: json['result'] as String?,
      boardMemberIds: (json['boardMemberIds'] as List?)
          ?.map((e) => e as int)
          .toList(),
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => 'Interview #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is InterviewResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
