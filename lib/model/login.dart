class LoginModel {
  bool? status;
  String? message;
  _Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new _Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class _Data {
  String? userID;
  String? id;
  String? usertype;
  String? type;
  String? kitchenname;
  String? email;
  String? mobilenumber;
  String? kitchenid;
  String? referalCode;

  _Data({
    this.userID,
    this.id,
    this.usertype,
    this.type,
    this.kitchenname,
    this.referalCode,
    this.email,
    this.mobilenumber,
    this.kitchenid,
  });

  _Data.fromJson(Map<String, dynamic> json) {
    userID = json['user_id'];
    id = json['id'];
    usertype = json['usertype'];
    type = json['type'];
    kitchenname = json['kitchenname'];
    referalCode = json['referal_code'];
    email = json['email'];
    mobilenumber = json['mobilenumber'];
    kitchenid = json['kitchenid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userID;
    data['id'] = this.id;
    data['usertype'] = this.usertype;
    data['type'] = this.type;
    data['kitchenname'] = this.kitchenname;
    data['email'] = this.email;
    data['referal_code'] = this.referalCode;
    data['mobilenumber'] = this.mobilenumber;
    data['kitchenid'] = this.kitchenid;

    return data;
  }
}

class UserPersonalInfo {
  String? id;

  String? username;
  String? mobilenumber;
  String? email;
  String? referalCode;
  UserPersonalInfo({
    required this.id,
    required this.username,
    required this.mobilenumber,
    required this.email,
    required this.referalCode,
  });
  UserPersonalInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mobilenumber = json['mobilenumber'];
    email = json['email'];
    referalCode = json['referal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['mobilenumber'] = mobilenumber;
    data['email'] = email;
    data['referal_code'] = referalCode;
    return data;
  }
}
