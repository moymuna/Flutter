import 'package:my_hrm/features/office/data/models/office.dart';

class EmployeeRequest {
  final String? contractNo;
  final String? joiningDate;
  final String? dateOfBirth;
  final String? status;
  final String? gender;
  final String? bloodGroup;
  final String? employeeCode;
  final String? employmentType;
  final String? image;
  final String? bankName;
  final String? bankBranch;
  final String? bankAccountName;
  final String? bankAccountNumber;
  final String? fullName;
  final String? email;
  final String? password;
  final String? role;
  final int? departmentId;
  final int? designationId;
  final int? officeId;
  final int? managerId;
  final AddressRequest? presentAddress;
  final AddressRequest? permanentAddress;

  EmployeeRequest({
    this.contractNo,
    this.joiningDate,
    this.dateOfBirth,
    this.status,
    this.gender,
    this.bloodGroup,
    this.employeeCode,
    this.employmentType,
    this.image,
    this.bankName,
    this.bankBranch,
    this.bankAccountName,
    this.bankAccountNumber,
    this.fullName,
    this.email,
    this.password,
    this.role,
    this.departmentId,
    this.designationId,
    this.officeId,
    this.managerId,
    this.presentAddress,
    this.permanentAddress,
  });

  Map<String, dynamic> toJson() => {
        if (contractNo != null) 'contractNo': contractNo,
        if (joiningDate != null) 'joiningDate': joiningDate,
        if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
        if (status != null) 'status': status,
        if (gender != null) 'gender': gender,
        if (bloodGroup != null) 'bloodGroup': bloodGroup,
        if (employeeCode != null) 'employeeCode': employeeCode,
        if (employmentType != null) 'employmentType': employmentType,
        if (image != null) 'image': image,
        if (bankName != null) 'bankName': bankName,
        if (bankBranch != null) 'bankBranch': bankBranch,
        if (bankAccountName != null) 'bankAccountName': bankAccountName,
        if (bankAccountNumber != null) 'bankAccountNumber': bankAccountNumber,
        if (fullName != null) 'fullName': fullName,
        if (email != null) 'email': email,
        if (password != null) 'password': password,
        if (role != null) 'role': role,
        if (departmentId != null) 'departmentId': departmentId,
        if (designationId != null) 'designationId': designationId,
        if (officeId != null) 'officeId': officeId,
        if (managerId != null) 'managerId': managerId,
        if (presentAddress != null) 'presentAddress': presentAddress!.toJson(),
        if (permanentAddress != null)
          'permanentAddress': permanentAddress!.toJson(),
      };
}

class AddressRequest {
  final String? addressLine1;
  final String? addressLine2;
  final String? postOffice;
  final String? postalCode;
  final int? policeStationId;

  AddressRequest({
    this.addressLine1,
    this.addressLine2,
    this.postOffice,
    this.postalCode,
    this.policeStationId,
  });

  Map<String, dynamic> toJson() => {
        if (addressLine1 != null) 'addressLine1': addressLine1,
        if (addressLine2 != null) 'addressLine2': addressLine2,
        if (postOffice != null) 'postOffice': postOffice,
        if (postalCode != null) 'postalCode': postalCode,
        if (policeStationId != null) 'policeStationId': policeStationId,
      };
}

class HireRequest {
  final String? joiningDate;
  final String? employmentType;
  final int? departmentId;
  final int? designationId;
  final int? officeId;
  final int? managerId;
  final String? employeeCode;
  final String? contractNo;

  HireRequest({
    this.joiningDate,
    this.employmentType,
    this.departmentId,
    this.designationId,
    this.officeId,
    this.managerId,
    this.employeeCode,
    this.contractNo,
  });

  Map<String, dynamic> toJson() => {
        if (joiningDate != null) 'joiningDate': joiningDate,
        if (employmentType != null) 'employmentType': employmentType,
        if (departmentId != null) 'departmentId': departmentId,
        if (designationId != null) 'designationId': designationId,
        if (officeId != null) 'officeId': officeId,
        if (managerId != null) 'managerId': managerId,
        if (employeeCode != null) 'employeeCode': employeeCode,
        if (contractNo != null) 'contractNo': contractNo,
      };
}

class EmployeeResponse {
  final int id;
  final String? contractNo;
  final String? joiningDate;
  final String? dateOfExit;
  final String? status;
  final String? dateOfBirth;
  final String? gender;
  final String? bloodGroup;
  final String? employeeCode;
  final int? applicantId;
  final String? employmentType;
  final String? image;
  final String? bankName;
  final String? bankBranch;
  final String? bankAccountName;
  final String? bankAccountNumber;
  final int? departmentId;
  final String? departmentName;
  final int? designationId;
  final String? designationTitle;
  final int? officeId;
  final String? officeName;
  final AddressResponse? presentAddress;
  final AddressResponse? permanentAddress;
  final int? userId;
  final String? fullName;
  final String? email;
  final String? role;
  final int? managerId;
  final String? managerName;

  EmployeeResponse({
    required this.id,
    this.contractNo,
    this.joiningDate,
    this.dateOfExit,
    this.status,
    this.dateOfBirth,
    this.gender,
    this.bloodGroup,
    this.employeeCode,
    this.applicantId,
    this.employmentType,
    this.image,
    this.bankName,
    this.bankBranch,
    this.bankAccountName,
    this.bankAccountNumber,
    this.departmentId,
    this.departmentName,
    this.designationId,
    this.designationTitle,
    this.officeId,
    this.officeName,
    this.presentAddress,
    this.permanentAddress,
    this.userId,
    this.fullName,
    this.email,
    this.role,
    this.managerId,
    this.managerName,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      id: json['id'] as int,
      contractNo: json['contractNo'] as String?,
      joiningDate: json['joiningDate'] as String?,
      dateOfExit: json['dateOfExit'] as String?,
      status: json['status'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      gender: json['gender'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      employeeCode: json['employeeCode'] as String?,
      applicantId: json['applicantId'] as int?,
      employmentType: json['employmentType'] as String?,
      image: json['image'] as String?,
      bankName: json['bankName'] as String?,
      bankBranch: json['bankBranch'] as String?,
      bankAccountName: json['bankAccountName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      departmentId: json['departmentId'] as int?,
      departmentName: json['departmentName'] as String?,
      designationId: json['designationId'] as int?,
      designationTitle: json['designationTitle'] as String?,
      officeId: json['officeId'] as int?,
      officeName: json['officeName'] as String?,
      presentAddress: json['presentAddress'] != null
          ? AddressResponse.fromJson(
              json['presentAddress'] as Map<String, dynamic>)
          : null,
      permanentAddress: json['permanentAddress'] != null
          ? AddressResponse.fromJson(
              json['permanentAddress'] as Map<String, dynamic>)
          : null,
      userId: json['userId'] as int?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      managerId: json['managerId'] as int?,
      managerName: json['managerName'] as String?,
    );
  }

  @override
  String toString() => fullName ?? employeeCode ?? 'Employee #$id';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is EmployeeResponse && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
