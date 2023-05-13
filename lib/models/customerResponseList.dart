class CustomerResponseList {
  String? noofpeople;
  String? checkOutDate;
  String? phone;
  String? foodType;
  String? name;
  String? emailId;
  String? checkInDate;

  CustomerResponseList(
      { this.checkOutDate,
        this.noofpeople,
        this.phone,
        this.foodType,
        this.name,
        this.emailId,
        this.checkInDate});

  CustomerResponseList.fromJson(Map<dynamic, dynamic> json) {
    noofpeople = json['noofpeople'];
    checkOutDate = json['checkOutDate'];
    phone = json['phone'];
    foodType = json['foodType'];
    name = json['name'];
    emailId = json['emailId'];
    checkInDate = json['checkInDate'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['noofpeople'] = this.noofpeople;
    data['checkOutDate'] = this.checkOutDate;
    data['phone'] = this.phone;
    data['foodType'] = this.foodType;
    data['name'] = this.name;
    data['emailId'] = this.emailId;
    data['checkInDate'] = this.checkInDate;
    return data;
  }
}
