class HolidayRequest {
  final String name;
  final String date;
  final String? description;

  HolidayRequest({
    required this.name,
    required this.date,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'date': date,
        if (description != null) 'description': description,
      };
}

class HolidayResponse {
  final int id;
  final String name;
  final String date;
  final String? description;

  HolidayResponse({
    required this.id,
    required this.name,
    required this.date,
    this.description,
  });

  factory HolidayResponse.fromJson(Map<String, dynamic> json) {
    return HolidayResponse(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      date: json['date'] as String? ?? '',
      description: json['description'] as String?,
    );
  }

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is HolidayResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
