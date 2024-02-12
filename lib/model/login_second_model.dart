

class BeanLoginSecond {
  bool? status;
  String? message;
  Data? data;

  BeanLoginSecond({this.status, this.message, this.data});

  BeanLoginSecond.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? mobileNumber;
  String? isExistingUser;

  Data({this.userId, this.mobileNumber, this.isExistingUser});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mobileNumber = json['mobilenumber'];
    isExistingUser = json['isExistingUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['mobilenumber'] = mobileNumber;
    data['isExistingUser'] = isExistingUser;
    return data;
  }
}