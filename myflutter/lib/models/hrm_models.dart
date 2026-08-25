class AttendanceResponse {
  final int? id;
  final DateTime? date;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final double? workedHours;
  final String? status;
  final int? employeeId;
  final String? employeeName;

  AttendanceResponse({
    this.id,
    this.date,
    this.checkInTime,
    this.checkOutTime,
    this.workedHours,
    this.status,
    this.employeeId,
    this.employeeName,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      id: json['id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      checkInTime: json['checkInTime'] != null ? DateTime.parse(json['checkInTime']) : null,
      checkOutTime: json['checkOutTime'] != null ? DateTime.parse(json['checkOutTime']) : null,
      workedHours: json['workedHours']?.toDouble(),
      status: json['status'],
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
    );
  }
}

class AttendanceSummary {
  final int presentDays;
  final int absentDays;
  final int halfDays;
  final int onLeaveDays;
  final double totalWorkedHours;

  AttendanceSummary({
    required this.presentDays,
    required this.absentDays,
    required this.halfDays,
    required this.onLeaveDays,
    required this.totalWorkedHours,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) {
    return AttendanceSummary(
      presentDays: json['presentDays'] ?? 0,
      absentDays: json['absentDays'] ?? 0,
      halfDays: json['halfDays'] ?? 0,
      onLeaveDays: json['onLeaveDays'] ?? 0,
      totalWorkedHours: json['totalWorkedHours']?.toDouble() ?? 0.0,
    );
  }
}

class LeaveResponse {
  final int? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? totalDays;
  final String? reason;
  final String? status;
  final String? rejectionReason;
  final String? employeeName;
  final String? leaveTypeName;

  LeaveResponse({
    this.id,
    this.startDate,
    this.endDate,
    this.totalDays,
    this.reason,
    this.status,
    this.rejectionReason,
    this.employeeName,
    this.leaveTypeName,
  });

  factory LeaveResponse.fromJson(Map<String, dynamic> json) {
    return LeaveResponse(
      id: json['id'],
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      totalDays: json['totalDays']?.toDouble(),
      reason: json['reason'],
      status: json['status'],
      rejectionReason: json['rejectionReason'],
      employeeName: json['employeeName'],
      leaveTypeName: json['leaveTypeName'],
    );
  }
}
