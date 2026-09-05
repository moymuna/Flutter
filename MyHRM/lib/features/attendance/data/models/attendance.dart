class AttendanceRequest {
  final int? employeeId;
  final String? date;
  final String? clockIn;
  final String? clockOut;
  final String? status;
  final String? notes;

  AttendanceRequest({
    this.employeeId,
    this.date,
    this.clockIn,
    this.clockOut,
    this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        if (employeeId != null) 'employeeId': employeeId,
        if (date != null) 'date': date,
        if (clockIn != null) 'clockIn': clockIn,
        if (clockOut != null) 'clockOut': clockOut,
        if (status != null) 'status': status,
        if (notes != null) 'notes': notes,
      };
}

class AttendanceResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final String? employeeCode;
  final String? date;
  final String? clockIn;
  final String? clockOut;
  final String? status;
  final double? hoursWorked;
  final String? notes;

  AttendanceResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.employeeCode,
    this.date,
    this.clockIn,
    this.clockOut,
    this.status,
    this.hoursWorked,
    this.notes,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      employeeCode: json['employeeCode'] as String?,
      date: json['date'] as String?,
      clockIn: json['clockIn'] as String?,
      clockOut: json['clockOut'] as String?,
      status: json['status'] as String?,
      hoursWorked: (json['hoursWorked'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );
  }

  @override
  String toString() => 'Attendance #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AttendanceResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
