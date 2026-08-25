class SalaryResponse {
  final int? id;
  final double? basicSalary;
  final double? houseRent;
  final double? medicalAllowance;
  final double? conveyanceAllowance;
  final double? otherAllowances;
  final double? grossSalary;
  final String? effectiveDate;
  final bool? active;

  SalaryResponse({
    this.id,
    this.basicSalary,
    this.houseRent,
    this.medicalAllowance,
    this.conveyanceAllowance,
    this.otherAllowances,
    this.grossSalary,
    this.effectiveDate,
    this.active,
  });

  factory SalaryResponse.fromJson(Map<String, dynamic> json) {
    return SalaryResponse(
      id: json['id'],
      basicSalary: json['basicSalary']?.toDouble(),
      houseRent: json['houseRent']?.toDouble(),
      medicalAllowance: json['medicalAllowance']?.toDouble(),
      conveyanceAllowance: json['conveyanceAllowance']?.toDouble(),
      otherAllowances: json['otherAllowances']?.toDouble(),
      grossSalary: json['grossSalary']?.toDouble(),
      effectiveDate: json['effectiveDate'],
      active: json['active'],
    );
  }
}

class PayrollResponse {
  final int? id;
  final int? month;
  final int? year;
  final double? grossSalary;
  final double? totalDeductions;
  final double? netSalary;
  final String? paymentDate;
  final String? status;
  final String? employeeName;

  PayrollResponse({
    this.id,
    this.month,
    this.year,
    this.grossSalary,
    this.totalDeductions,
    this.netSalary,
    this.paymentDate,
    this.status,
    this.employeeName,
  });

  factory PayrollResponse.fromJson(Map<String, dynamic> json) {
    return PayrollResponse(
      id: json['id'],
      month: json['month'],
      year: json['year'],
      grossSalary: json['grossSalary']?.toDouble(),
      totalDeductions: json['totalDeductions']?.toDouble(),
      netSalary: json['netSalary']?.toDouble(),
      paymentDate: json['paymentDate'],
      status: json['status'],
      employeeName: json['employeeName'],
    );
  }
}

class PayslipResponse {
  final int? id;
  final String? payslipNumber;
  final String? generatedDate;
  final int? payrollId;

  PayslipResponse({
    this.id,
    this.payslipNumber,
    this.generatedDate,
    this.payrollId,
  });

  factory PayslipResponse.fromJson(Map<String, dynamic> json) {
    return PayslipResponse(
      id: json['id'],
      payslipNumber: json['payslipNumber'],
      generatedDate: json['generatedDate'],
      payrollId: json['payrollId'],
    );
  }
}
