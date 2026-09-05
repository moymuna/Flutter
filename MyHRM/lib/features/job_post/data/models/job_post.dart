class JobPostRequest {
  final String? title;
  final String? description;
  final String? requirements;
  final String? responsibilities;
  final String? salaryMin;
  final String? salaryMax;
  final String? location;
  final String? employmentType;
  final String? experienceLevel;
  final String? status;
  final int? departmentId;
  final String? deadline;

  JobPostRequest({
    this.title,
    this.description,
    this.requirements,
    this.responsibilities,
    this.salaryMin,
    this.salaryMax,
    this.location,
    this.employmentType,
    this.experienceLevel,
    this.status,
    this.departmentId,
    this.deadline,
  });

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (requirements != null) 'requirements': requirements,
        if (responsibilities != null) 'responsibilities': responsibilities,
        if (salaryMin != null) 'salaryMin': salaryMin,
        if (salaryMax != null) 'salaryMax': salaryMax,
        if (location != null) 'location': location,
        if (employmentType != null) 'employmentType': employmentType,
        if (experienceLevel != null) 'experienceLevel': experienceLevel,
        if (status != null) 'status': status,
        if (departmentId != null) 'departmentId': departmentId,
        if (deadline != null) 'deadline': deadline,
      };
}

class JobPostResponse {
  final int id;
  final String? title;
  final String? description;
  final String? requirements;
  final String? responsibilities;
  final double? salaryMin;
  final double? salaryMax;
  final String? location;
  final String? employmentType;
  final String? experienceLevel;
  final String? status;
  final int? departmentId;
  final String? departmentName;
  final String? deadline;
  final int? applicationCount;
  final String? createdAt;

  JobPostResponse({
    required this.id,
    this.title,
    this.description,
    this.requirements,
    this.responsibilities,
    this.salaryMin,
    this.salaryMax,
    this.location,
    this.employmentType,
    this.experienceLevel,
    this.status,
    this.departmentId,
    this.departmentName,
    this.deadline,
    this.applicationCount,
    this.createdAt,
  });

  factory JobPostResponse.fromJson(Map<String, dynamic> json) {
    return JobPostResponse(
      id: json['id'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      requirements: json['requirements'] as String?,
      responsibilities: json['responsibilities'] as String?,
      salaryMin: (json['salaryMin'] as num?)?.toDouble(),
      salaryMax: (json['salaryMax'] as num?)?.toDouble(),
      location: json['location'] as String?,
      employmentType: json['employmentType'] as String?,
      experienceLevel: json['experienceLevel'] as String?,
      status: json['status'] as String?,
      departmentId: json['departmentId'] as int?,
      departmentName: json['departmentName'] as String?,
      deadline: json['deadline'] as String?,
      applicationCount: json['applicationCount'] as int?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => title ?? 'Job #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is JobPostResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
