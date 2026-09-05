class DepartmentRequest {
  final String departmentName;
  final String code;
  final int? departmentHeadId;
  final int? officeId;

  DepartmentRequest({
    required this.departmentName,
    required this.code,
    this.departmentHeadId,
    this.officeId,
  });

  Map<String, dynamic> toJson() => {
        'departmentName': departmentName,
        'code': code,
        if (departmentHeadId != null) 'departmentHeadId': departmentHeadId,
        if (officeId != null) 'officeId': officeId,
      };
}

class DepartmentResponse {
  final int id;
  final String departmentName;
  final String code;
  final int? departmentHeadId;
  final String? departmentHeadName;
  final int? officeId;
  final String? officeName;

  DepartmentResponse({
    required this.id,
    required this.departmentName,
    required this.code,
    this.departmentHeadId,
    this.departmentHeadName,
    this.officeId,
    this.officeName,
  });

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      id: json['id'] as int,
      departmentName: json['departmentName'] as String? ?? '',
      code: json['code'] as String? ?? '',
      departmentHeadId: json['departmentHeadId'] as int?,
      departmentHeadName: json['departmentHeadName'] as String?,
      officeId: json['officeId'] as int?,
      officeName: json['officeName'] as String?,
    );
  }

  @override
  String toString() => departmentName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DepartmentResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
