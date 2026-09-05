class DistrictResponse {
  final int id;
  final String districtsName;
  final String nameBN;
  final String districtCode;
  final int? divisionId;
  final String? divisionName;

  DistrictResponse({
    required this.id,
    required this.districtsName,
    required this.nameBN,
    required this.districtCode,
    this.divisionId,
    this.divisionName,
  });

  factory DistrictResponse.fromJson(Map<String, dynamic> json) {
    return DistrictResponse(
      id: json['id'] as int,
      districtsName: json['districtsName'] as String? ?? '',
      nameBN: json['nameBN'] as String? ?? '',
      districtCode: json['districtCode'] as String? ?? '',
      divisionId: json['divisionId'] as int?,
      divisionName: json['divisionName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'districtsName': districtsName,
        'nameBN': nameBN,
        'districtCode': districtCode,
        'divisionId': divisionId,
      };

  @override
  String toString() => districtsName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DistrictResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DistrictRequest {
  final String districtsName;
  final String nameBN;
  final String districtCode;
  final int divisionId;

  DistrictRequest({
    required this.districtsName,
    required this.nameBN,
    required this.districtCode,
    required this.divisionId,
  });

  Map<String, dynamic> toJson() => {
        'districtsName': districtsName,
        'nameBN': nameBN,
        'districtCode': districtCode,
        'divisionId': divisionId,
      };
}
