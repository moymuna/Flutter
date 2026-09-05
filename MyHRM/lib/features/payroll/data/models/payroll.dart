class PayrollResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final int? year;
  final int? month;
  final double? basicSalary;
  final double? allowances;
  final double? deductions;
  final double? netPay;
  final String? status;
  final String? paidDate;

  PayrollResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.year,
    this.month,
    this.basicSalary,
    this.allowances,
    this.deductions,
    this.netPay,
    this.status,
    this.paidDate,
  });

  factory PayrollResponse.fromJson(Map<String, dynamic> json) {
    return PayrollResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      year: json['year'] as int?,
      month: json['month'] as int?,
      basicSalary: (json['basicSalary'] as num?)?.toDouble(),
      allowances: (json['allowances'] as num?)?.toDouble(),
      deductions: (json['deductions'] as num?)?.toDouble(),
      netPay: (json['netPay'] as num?)?.toDouble(),
      status: json['status'] as String?,
      paidDate: json['paidDate'] as String?,
    );
  }

  @override
  String toString() => 'Payroll #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PayrollResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
