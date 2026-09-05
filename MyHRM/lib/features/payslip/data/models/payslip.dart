class PayslipResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final int? payrollId;
  final int? year;
  final int? month;
  final double? basicSalary;
  final double? allowances;
  final double? deductions;
  final double? netPay;
  final String? generatedAt;

  PayslipResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.payrollId,
    this.year,
    this.month,
    this.basicSalary,
    this.allowances,
    this.deductions,
    this.netPay,
    this.generatedAt,
  });

  factory PayslipResponse.fromJson(Map<String, dynamic> json) {
    return PayslipResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      payrollId: json['payrollId'] as int?,
      year: json['year'] as int?,
      month: json['month'] as int?,
      basicSalary: (json['basicSalary'] as num?)?.toDouble(),
      allowances: (json['allowances'] as num?)?.toDouble(),
      deductions: (json['deductions'] as num?)?.toDouble(),
      netPay: (json['netPay'] as num?)?.toDouble(),
      generatedAt: json['generatedAt'] as String?,
    );
  }

  @override
  String toString() => 'Payslip #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PayslipResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
