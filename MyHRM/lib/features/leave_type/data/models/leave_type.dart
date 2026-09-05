class LeaveTypeRequest {
  final String name;
  final int? daysPerYear;
  final bool? isActive;

  LeaveTypeRequest({
    required this.name,
    this.daysPerYear,
    this.isActive,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        if (daysPerYear != null) 'daysPerYear': daysPerYear,
        if (isActive != null) 'isActive': isActive,
      };
}

class LeaveTypeResponse {
  final int id;
  final String name;
  final int? daysPerYear;
  final bool? isActive;

  LeaveTypeResponse({
    required this.id,
    required this.name,
    this.daysPerYear,
    this.isActive,
  });

  factory LeaveTypeResponse.fromJson(Map<String, dynamic> json) {
    return LeaveTypeResponse(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      daysPerYear: json['daysPerYear'] as int?,
      isActive: json['isActive'] as bool?,
    );
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LeaveTypeResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
