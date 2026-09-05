class LeaveRequest {
  final int? employeeId;
  final int? leaveTypeId;
  final String? startDate;
  final String? endDate;
  final String? reason;
  final int? totalDays;

  LeaveRequest({
    this.employeeId,
    this.leaveTypeId,
    this.startDate,
    this.endDate,
    this.reason,
    this.totalDays,
  });

  Map<String, dynamic> toJson() => {
        if (employeeId != null) 'employeeId': employeeId,
        if (leaveTypeId != null) 'leaveTypeId': leaveTypeId,
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
        if (reason != null) 'reason': reason,
        if (totalDays != null) 'totalDays': totalDays,
      };
}

class LeaveResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final int? leaveTypeId;
  final String? leaveTypeName;
  final String? startDate;
  final String? endDate;
  final int? totalDays;
  final String? reason;
  final String? status;
  final String? approvedBy;
  final String? createdAt;

  LeaveResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.leaveTypeId,
    this.leaveTypeName,
    this.startDate,
    this.endDate,
    this.totalDays,
    this.reason,
    this.status,
    this.approvedBy,
    this.createdAt,
  });

  factory LeaveResponse.fromJson(Map<String, dynamic> json) {
    return LeaveResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      leaveTypeId: json['leaveTypeId'] as int?,
      leaveTypeName: json['leaveTypeName'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      totalDays: json['totalDays'] as int?,
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      approvedBy: json['approvedBy'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => 'Leave #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LeaveResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
