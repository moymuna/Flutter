class AdvanceRequest {
  final int? employeeId;
  final double? amount;
  final String? reason;
  final String? repaymentMethod;

  AdvanceRequest({
    this.employeeId,
    this.amount,
    this.reason,
    this.repaymentMethod,
  });

  Map<String, dynamic> toJson() => {
        if (employeeId != null) 'employeeId': employeeId,
        if (amount != null) 'amount': amount,
        if (reason != null) 'reason': reason,
        if (repaymentMethod != null) 'repaymentMethod': repaymentMethod,
      };
}

class AdvanceResponse {
  final int id;
  final int? employeeId;
  final String? employeeName;
  final double? amount;
  final double? recoveredAmount;
  final double? remainingAmount;
  final String? reason;
  final String? status;
  final String? repaymentMethod;
  final String? createdAt;

  AdvanceResponse({
    required this.id,
    this.employeeId,
    this.employeeName,
    this.amount,
    this.recoveredAmount,
    this.remainingAmount,
    this.reason,
    this.status,
    this.repaymentMethod,
    this.createdAt,
  });

  factory AdvanceResponse.fromJson(Map<String, dynamic> json) {
    return AdvanceResponse(
      id: json['id'] as int,
      employeeId: json['employeeId'] as int?,
      employeeName: json['employeeName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      recoveredAmount: (json['recoveredAmount'] as num?)?.toDouble(),
      remainingAmount: (json['remainingAmount'] as num?)?.toDouble(),
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      repaymentMethod: json['repaymentMethod'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => 'Advance #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AdvanceResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
