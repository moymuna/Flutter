class CountryResponse {
  final int id;
  final String countryName;
  final String code;
  final String phoneCode;

  CountryResponse({
    required this.id,
    required this.countryName,
    required this.code,
    required this.phoneCode,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      id: json['id'] as int,
      countryName: json['countryName'] as String? ?? '',
      code: json['code'] as String? ?? '',
      phoneCode: json['phoneCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'countryName': countryName,
        'code': code,
        'phoneCode': phoneCode,
      };

  @override
  String toString() => countryName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CountryResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class CountryRequest {
  final String countryName;
  final String code;
  final String phoneCode;

  CountryRequest({
    required this.countryName,
    required this.code,
    required this.phoneCode,
  });

  Map<String, dynamic> toJson() => {
        'countryName': countryName,
        'code': code,
        'phoneCode': phoneCode,
      };
}
