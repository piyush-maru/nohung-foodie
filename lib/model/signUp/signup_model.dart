class SignupModel {
  bool? status;
  String? message;
  List<_Data>? data;

  SignupModel({this.status, this.message, this.data});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <_Data>[];
      json['data'].forEach((v) {
        data!.add(new _Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _Data {
  String? id;
  String? name;
  String? email;
  String? mobilenumber;
  String? password;

  _Data({this.id, this.name, this.email, this.mobilenumber, this.password});

  _Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobilenumber = json['mobilenumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobilenumber'] = this.mobilenumber;
    data['password'] = this.password;
    return data;
  }
}
