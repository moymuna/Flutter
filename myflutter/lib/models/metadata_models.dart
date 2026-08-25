class DepartmentResponse {
  final int? id;
  final String? departmentName;
  final String? code;
  final String? officeName;

  DepartmentResponse({this.id, this.departmentName, this.code, this.officeName});

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      id: json['id'],
      departmentName: json['departmentName'],
      code: json['code'],
      officeName: json['officeName'],
    );
  }
}

class DesignationResponse {
  final int? id;
  final String? title;
  final String? departmentName;

  DesignationResponse({this.id, this.title, this.departmentName});

  factory DesignationResponse.fromJson(Map<String, dynamic> json) {
    return DesignationResponse(
      id: json['id'],
      title: json['title'],
      departmentName: json['departmentName'],
    );
  }
}

class OfficeResponse {
  final int? id;
  final String? officeName;
  final String? officeCode;

  OfficeResponse({this.id, this.officeName, this.officeCode});

  factory OfficeResponse.fromJson(Map<String, dynamic> json) {
    return OfficeResponse(
      id: json['id'],
      officeName: json['officeName'],
      officeCode: json['officeCode'],
    );
  }
}

class LeaveTypeResponse {
  final int? id;
  final String? name;
  final int? maxDaysPerYear;
  final bool? paid;

  LeaveTypeResponse({this.id, this.name, this.maxDaysPerYear, this.paid});

  factory LeaveTypeResponse.fromJson(Map<String, dynamic> json) {
    return LeaveTypeResponse(
      id: json['id'],
      name: json['name'],
      maxDaysPerYear: json['maxDaysPerYear'],
      paid: json['paid'],
    );
  }
}
