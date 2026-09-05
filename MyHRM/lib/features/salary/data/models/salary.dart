class SalaryResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final double? basicSalary;
  final double? houseRent;
  final double? medicalAllowance;
  final double? transportAllowance;
  final double? otherAllowance;
  final double? bonus;
  final double? totalSalary;
  final int? salaryGradeId;
  final String? salaryGradeName;
  final String? effectiveDate;

  SalaryResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.basicSalary,
    this.houseRent,
    this.medicalAllowance,
    this.transportAllowance,
    this.otherAllowance,
    this.bonus,
    this.totalSalary,
    this.salaryGradeId,
    this.salaryGradeName,
    this.effectiveDate,
  });

  factory SalaryResponse.fromJson(Map<String, dynamic> json) {
    return SalaryResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      basicSalary: (json['basicSalary'] as num?)?.toDouble(),
      houseRent: (json['houseRent'] as num?)?.toDouble(),
      medicalAllowance: (json['medicalAllowance'] as num?)?.toDouble(),
      transportAllowance: (json['transportAllowance'] as num?)?.toDouble(),
      otherAllowance: (json['otherAllowance'] as num?)?.toDouble(),
      bonus: (json['bonus'] as num?)?.toDouble(),
      totalSalary: (json['totalSalary'] as num?)?.toDouble(),
      salaryGradeId: json['salaryGradeId'] as int?,
      salaryGradeName: json['salaryGradeName'] as String?,
      effectiveDate: json['effectiveDate'] as String?,
    );
  }

  @override
  String toString() => 'Salary #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SalaryResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
