import 'enums.dart';

class AddressResponse {
  final int? id;
  final String? addressLine1;
  final String? addressLine2;
  final String? postOffice;
  final String? postalCode;
  final String? countryName;
  final String? divisionName;
  final String? districtName;
  final String? policeStationName;

  AddressResponse({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.postOffice,
    this.postalCode,
    this.countryName,
    this.divisionName,
    this.districtName,
    this.policeStationName,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) {
    return AddressResponse(
      id: json['id'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      postOffice: json['postOffice'],
      postalCode: json['postalCode'],
      countryName: json['countryName'],
      divisionName: json['divisionName'],
      districtName: json['districtName'],
      policeStationName: json['policeStationName'],
    );
  }
}

class EmployeeResponse {
  final int? id;
  final String? contractNo;
  final DateTime? joiningDate;
  final EmployeeStatus? status;
  final Gender? gender;
  final String? employeeCode;
  final EmploymentType? employmentType;
  final String? image;
  final String? departmentName;
  final String? designationTitle;
  final String? officeName;
  final String? fullName;
  final String? email;
  final AddressResponse? presentAddress;
  final AddressResponse? permanentAddress;
  final String? managerName;

  EmployeeResponse({
    this.id,
    this.contractNo,
    this.joiningDate,
    this.status,
    this.gender,
    this.employeeCode,
    this.employmentType,
    this.image,
    this.departmentName,
    this.designationTitle,
    this.officeName,
    this.fullName,
    this.email,
    this.presentAddress,
    this.permanentAddress,
    this.managerName,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      id: json['id'],
      contractNo: json['contractNo'],
      joiningDate: json['joiningDate'] != null ? DateTime.parse(json['joiningDate']) : null,
      status: json['status'] != null 
          ? EmployeeStatus.values.firstWhere((e) => e.name.toUpperCase() == json['status'].toString().toUpperCase(), orElse: () => EmployeeStatus.active) 
          : null,
      gender: json['gender'] != null 
          ? Gender.values.firstWhere((e) => e.name.toUpperCase() == json['gender'].toString().toUpperCase(), orElse: () => Gender.male) 
          : null,
      employeeCode: json['employeeCode'],
      employmentType: json['employmentType'] != null 
          ? EmploymentType.values.firstWhere((e) => e.name.toUpperCase() == json['employmentType'].toString().toUpperCase(), orElse: () => EmploymentType.fullTime) 
          : null,
      image: json['image'],
      departmentName: json['departmentName'],
      designationTitle: json['designationTitle'],
      officeName: json['officeName'],
      fullName: json['fullName'],
      email: json['email'],
      presentAddress: json['presentAddress'] != null ? AddressResponse.fromJson(json['presentAddress']) : null,
      permanentAddress: json['permanentAddress'] != null ? AddressResponse.fromJson(json['permanentAddress']) : null,
      managerName: json['managerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'contractNo': contractNo,
      'joiningDate': joiningDate?.toIso8601String(),
      'status': status?.name.toUpperCase(),
      'gender': gender?.name.toUpperCase(),
      'employeeCode': employeeCode,
      'employmentType': employmentType?.name.toUpperCase(),
      'fullName': fullName,
      'email': email,
      'managerId': null,
    };
  }
}
