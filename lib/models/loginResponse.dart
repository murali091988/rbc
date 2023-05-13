class loginResponse {
  int? mobileNumber;
  String? role;
  int? userType;
  String? name;

  loginResponse({this.mobileNumber, this.role, this.userType, this.name});

  loginResponse.fromJson(Map<dynamic, dynamic> json) {
    mobileNumber = json['MobileNumber'];
    role = json['role'];
    userType = json['userType'];
    name = json['Name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['MobileNumber'] = this.mobileNumber;
    data['role'] = this.role;
    data['userType'] = this.userType;
    data['Name'] = this.name;
    return data;
  }
}