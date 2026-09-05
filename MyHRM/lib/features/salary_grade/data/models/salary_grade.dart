class SalaryGradeResponse {
  final int id;
  final int? gradeNumber;
  final String? gradeName;
  final double? minSalary;
  final double? maxSalary;
  final bool? isActive;

  SalaryGradeResponse({
    required this.id,
    this.gradeNumber,
    this.gradeName,
    this.minSalary,
    this.maxSalary,
    this.isActive,
  });

  factory SalaryGradeResponse.fromJson(Map<String, dynamic> json) {
    return SalaryGradeResponse(
      id: json['id'] as int,
      gradeNumber: json['gradeNumber'] as int?,
      gradeName: json['gradeName'] as String?,
      minSalary: (json['minSalary'] as num?)?.toDouble(),
      maxSalary: (json['maxSalary'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
    );
  }

  @override
  String toString() => gradeName ?? 'Grade #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SalaryGradeResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
