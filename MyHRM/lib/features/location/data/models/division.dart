class DivisionResponse {
  final int id;
  final String name;
  final String nameBN;
  final int? countryId;
  final String? countryName;

  DivisionResponse({
    required this.id,
    required this.name,
    required this.nameBN,
    this.countryId,
    this.countryName,
  });

  factory DivisionResponse.fromJson(Map<String, dynamic> json) {
    return DivisionResponse(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      nameBN: json['nameBN'] as String? ?? '',
      countryId: json['countryId'] as int?,
      countryName: json['countryName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameBN': nameBN,
        'countryId': countryId,
      };

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DivisionResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DivisionRequest {
  final String name;
  final String nameBN;
  final int countryId;

  DivisionRequest({
    required this.name,
    required this.nameBN,
    required this.countryId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'nameBN': nameBN,
        'countryId': countryId,
      };
}
