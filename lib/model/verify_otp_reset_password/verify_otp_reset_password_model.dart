class VerifyOTPResetPasswordModel {
  bool? status;
  String? message;
  _Data? data;

  VerifyOTPResetPasswordModel({this.status, this.message, this.data});

  VerifyOTPResetPasswordModel.fromJson(Map<String, dynamic> json) {
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
  String? code;

  _Data({
    this.userID,
    this.code,
  });

  _Data.fromJson(Map<String, dynamic> json) {
    userID = json['user_id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userID;
    data['code'] = this.code;

    return data;
  }
}
