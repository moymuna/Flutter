class LeaveBalanceResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final int? leaveTypeId;
  final String? leaveTypeName;
  final int? year;
  final int? totalDays;
  final int? usedDays;
  final int? remainingDays;

  LeaveBalanceResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.leaveTypeId,
    this.leaveTypeName,
    this.year,
    this.totalDays,
    this.usedDays,
    this.remainingDays,
  });

  factory LeaveBalanceResponse.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      leaveTypeId: json['leaveTypeId'] as int?,
      leaveTypeName: json['leaveTypeName'] as String?,
      year: json['year'] as int?,
      totalDays: json['totalDays'] as int?,
      usedDays: json['usedDays'] as int?,
      remainingDays: json['remainingDays'] as int?,
    );
  }

  @override
  String toString() => 'LeaveBalance #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveBalanceResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
