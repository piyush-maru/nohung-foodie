// import 'package:hive/hive.dart';
//
// class UserClass {
//   UserClass({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   List<UserData?>? data;
//
//   factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] == null ? [] : List<UserData?>.from(json["data"]!.map((x) => UserData.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
//   };
// }
//
// @HiveType(typeId: 1)
// class UserData extends HiveObject {
//   UserData({
//     this.userId,
//     this.username,
//     this.email,
//     this.mobileNumber,
//     this.address,
//     this.profilePic,
//     this.myWallet,
//   });
//
//   @HiveField(0)
//
//   String? userId;
//
//   @HiveField(1)
//   String? username;
//
//   @HiveField(2)
//   String? email;
//
//   @HiveField(3)
//   String? mobileNumber;
//
//   @HiveField(4)
//   String? address;
//
//   @HiveField(5)
//   String? profilePic;
//
//   @HiveField(6)
//   String? myWallet;
//
//   factory UserData.fromJson(Map<String, dynamic> json) => UserData(
//     userId: json["user_id"],
//     username: json["username"],
//     email: json["email"],
//     mobileNumber: json["mobilenumber"],
//     address: json["address"],
//     profilePic: json["profile_pic"],
//     myWallet: json["my_wallet"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "user_id": userId,
//     "username": username,
//     "email": email,
//     "mobilenumber": mobileNumber,
//     "address": address,
//     "profile_pic": profilePic,
//     "my_wallet": myWallet,
//   };
// }
