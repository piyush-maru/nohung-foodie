import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class GetUserAddress {
  bool status;
  String message;
  UserAddress data;

  GetUserAddress({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetUserAddress.fromMap(Map<String, dynamic> json) => GetUserAddress(
    status: json["status"],
    message: json["message"],
    data: UserAddress.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data.toMap(),
  };
}

class UserAddress {
  List<Home> home;
  List<Home> office;
  List<Home> other;

  UserAddress({
    required this.home,
    required this.office,
    required this.other,
  });

  factory UserAddress.fromMap(Map<String, dynamic> json) => UserAddress(
    home: List<Home>.from(json["home"].map((x) => Home.fromMap(x))),
    office: List<Home>.from(json["office"].map((x) => Home.fromMap(x))),
    other: List<Home>.from(json["other"].map((x) => Home.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "home": List<dynamic>.from(home.map((x) => x.toMap())),
    "office": List<dynamic>.from(office.map((x) => x.toMap())),
    "other": List<dynamic>.from(other.map((x) => x.toMap())),
  };
}

class Home {
  String id;
  String address;
  String latitude;
  String longitude;
  String isDefault;
  String street;
  String landmark;
  String addressType;

  Home({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.street,
    required this.landmark,
    required this.addressType,
  });

  factory Home.fromMap(Map<String, dynamic> json) => Home(
    id: json["id"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["is_default"]!,
    street: json["street"],
    landmark: json["landmark"],
    addressType: json["address_type"]!,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "is_default": isDefault,
    "street": street,
    "landmark": landmark,
    "address_type": addressType,
  };
}

