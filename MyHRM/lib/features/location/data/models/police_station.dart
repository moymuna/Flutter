class PoliceStationResponse {
  final int id;
  final String name;
  final String nameBn;
  final String postalCode;
  final int? districtId;
  final String? districtName;

  PoliceStationResponse({
    required this.id,
    required this.name,
    required this.nameBn,
    required this.postalCode,
    this.districtId,
    this.districtName,
  });

  factory PoliceStationResponse.fromJson(Map<String, dynamic> json) {
    return PoliceStationResponse(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      nameBn: json['nameBn'] as String? ?? '',
      postalCode: json['postalCode'] as String? ?? '',
      districtId: json['districtId'] as int?,
      districtName: json['districtName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'nameBn': nameBn,
        'postalCode': postalCode,
        'districtId': districtId,
      };

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoliceStationResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class PoliceStationRequest {
  final String name;
  final String nameBn;
  final String postalCode;
  final int districtId;

  PoliceStationRequest({
    required this.name,
    required this.nameBn,
    required this.postalCode,
    required this.districtId,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'nameBn': nameBn,
        'postalCode': postalCode,
        'districtId': districtId,
      };
}
