class LoginResponse {
  String? token;
  String? tokenType;
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? role;


  LoginResponse(
      {this.token,
        this.tokenType,
        this.userId,
        this.name,
        this.email,
        this.phone,
        this.role,
       });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['tokenType'];
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['tokenType'] = this.tokenType;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;

    return data;
  }
}