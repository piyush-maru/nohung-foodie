// class GetProfile {
//   GetProfile({
//    required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   bool status;
//   String message;
//   List<Data> data;
//
//   factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
//     status: json["status"],
//     message: json["message"],
//     data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Data {
//   Data({
//     required this.username,
//     required this.email,
//     required this.mobileNumber,
//     required this.profilePic,
//     required this.myWallet,
//   });
//
//   String username;
//   String email;
//   String mobileNumber;
//   String profilePic;
//   String myWallet;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     username: json["username"],
//     email: json["email"],
//     mobileNumber: json["mobilenumber"],
//     profilePic: json["profile_pic"],
//     myWallet: json["my_wallet"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "username": username,
//     "email": email,
//     "mobilenumber": mobileNumber,
//     "profile_pic": profilePic,
//     "my_wallet": myWallet,
//   };
// }



class GetProfile {
  bool status;
  String message;
  List<Datum> data;

  GetProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String userId;
  String username;
  String email;
  String mobileNumber;
  String address;
  String profilePic;
  String myWallet;
  String referralCode;
  String referralDescription;

  Datum({
    required this.userId,
    required this.username,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.profilePic,
    required this.myWallet,
    required this.referralCode,
    required this.referralDescription,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["user_id"],
    username: json["username"],
    email: json["email"],
    mobileNumber: json["mobilenumber"],
    address: json["address"],
    profilePic: json["profile_pic"],
    myWallet: json["my_wallet"],
    referralCode: json["referal_code"],
    referralDescription: json["referal_description"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "username": username,
    "email": email,
    "mobilenumber": mobileNumber,
    "address": address,
    "profile_pic": profilePic,
    "my_wallet": myWallet,
    "referal_code": referralCode,
    "referal_description": referralDescription,
  };
}
