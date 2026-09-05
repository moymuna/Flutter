class OfficeRequest {
  final String officeName;
  final String officeCode;
  final String? phone;
  final String? email;
  final String? addressLine1;
  final String? addressLine2;
  final String? postOffice;
  final String? postalCode;
  final int? policeStationId;

  OfficeRequest({
    required this.officeName,
    required this.officeCode,
    this.phone,
    this.email,
    this.addressLine1,
    this.addressLine2,
    this.postOffice,
    this.postalCode,
    this.policeStationId,
  });

  Map<String, dynamic> toJson() => {
        'officeName': officeName,
        'officeCode': officeCode,
        if (phone != null) 'phone': phone,
        if (email != null) 'email': email,
        'address': {
          if (addressLine1 != null) 'addressLine1': addressLine1,
          if (addressLine2 != null) 'addressLine2': addressLine2,
          if (postOffice != null) 'postOffice': postOffice,
          if (postalCode != null) 'postalCode': postalCode,
          if (policeStationId != null) 'policeStationId': policeStationId,
        },
      };
}

class OfficeResponse {
  final int id;
  final String officeName;
  final String officeCode;
  final String? phone;
  final String? email;
  final AddressResponse? address;

  OfficeResponse({
    required this.id,
    required this.officeName,
    required this.officeCode,
    this.phone,
    this.email,
    this.address,
  });

  factory OfficeResponse.fromJson(Map<String, dynamic> json) {
    return OfficeResponse(
      id: json['id'] as int,
      officeName: json['officeName'] as String? ?? '',
      officeCode: json['officeCode'] as String? ?? '',
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] != null
          ? AddressResponse.fromJson(json['address'] as Map<String, dynamic>)
          : null,
    );
  }

  @override
  String toString() => officeName;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is OfficeResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class AddressResponse {
  final int? id;
  final String? addressLine1;
  final String? addressLine2;
  final String? postOffice;
  final String? postalCode;
  final int? policeStationId;
  final String? policeStationName;
  final int? districtId;
  final String? districtName;
  final int? divisionId;
  final String? divisionName;
  final int? countryId;
  final String? countryName;

  AddressResponse({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.postOffice,
    this.postalCode,
    this.policeStationId,
    this.policeStationName,
    this.districtId,
    this.districtName,
    this.divisionId,
    this.divisionName,
    this.countryId,
    this.countryName,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      id: json['id'] as int?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      postOffice: json['postOffice'] as String?,
      postalCode: json['postalCode'] as String?,
      policeStationId: json['policeStationId'] as int?,
      policeStationName: json['policeStationName'] as String?,
      districtId: json['districtId'] as int?,
      districtName: json['districtName'] as String?,
      divisionId: json['divisionId'] as int?,
      divisionName: json['divisionName'] as String?,
      countryId: json['countryId'] as int?,
      countryName: json['countryName'] as String?,
    );
  }

  String get fullAddress {
    final parts = <String>[
      if (addressLine1 != null && addressLine1!.isNotEmpty) addressLine1!,
      if (addressLine2 != null && addressLine2!.isNotEmpty) addressLine2!,
      if (postOffice != null && postOffice!.isNotEmpty) postOffice!,
      if (policeStationName != null && policeStationName!.isNotEmpty)
        policeStationName!,
      if (districtName != null && districtName!.isNotEmpty) districtName!,
      if (divisionName != null && divisionName!.isNotEmpty) divisionName!,
      if (countryName != null && countryName!.isNotEmpty) countryName!,
    ];
    return parts.join(', ');
  }
}
