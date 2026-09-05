class ApplicantRequest {
  final String? fullName;
  final String? email;
  final String? phone;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? nidNumber;
  final String? address;

  ApplicantRequest({
    this.fullName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.nidNumber,
    this.address,
  });

  Map<String, dynamic> toJson() => {
        if (fullName != null) 'fullName': fullName,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
        if (gender != null) 'gender': gender,
        if (nationality != null) 'nationality': nationality,
        if (nidNumber != null) 'nidNumber': nidNumber,
        if (address != null) 'address': address,
      };
}

class ApplicantResponse {
  final int id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? nidNumber;
  final String? address;
  final int? userId;
  final String? createdAt;

  ApplicantResponse({
    required this.id,
    this.fullName,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.nidNumber,
    this.address,
    this.userId,
    this.createdAt,
  });

  factory ApplicantResponse.fromJson(Map<String, dynamic> json) {
    return ApplicantResponse(
      id: json['id'] as int,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      nidNumber: json['nidNumber'] as String?,
      address: json['address'] as String?,
      userId: json['userId'] as int?,
      createdAt: json['createdAt'] as String?,
    );
  }

  @override
  String toString() => fullName ?? email ?? 'Applicant #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ApplicantResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
