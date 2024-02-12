// To parse this JSON data, do
//
//     final applyCouponCode = applyCouponCodeFromJson(jsonString);

import 'dart:convert';

ApplyCouponCode applyCouponCodeFromJson(String str) => ApplyCouponCode.fromJson(json.decode(str));

String applyCouponCodeToJson(ApplyCouponCode data) => json.encode(data.toJson());

class ApplyCouponCode {
  ApplyCouponCode({
   required  this.status,
   required  this.message,
   required  this.data,
  });

  bool status;
  String message;
  List<dynamic> data;

  factory ApplyCouponCode.fromJson(Map<String, dynamic> json) => ApplyCouponCode(
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
