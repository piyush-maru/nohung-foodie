// To parse this JSON data, do
//
//     final deleteCartItem = deleteCartItemFromJson(jsonString);

import 'dart:convert';

DeleteCartItem deleteCartItemFromJson(String str) => DeleteCartItem.fromJson(json.decode(str));

String deleteCartItemToJson(DeleteCartItem data) => json.encode(data.toJson());

class DeleteCartItem {
  DeleteCartItem({
   required this.status,
   required this.message,
   required this.data,
  });

  bool status;
  String message;
  List<dynamic> data;

  factory DeleteCartItem.fromJson(Map<String, dynamic> json) => DeleteCartItem(
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
