//
//
// class UserAddressList {
//   UserAddressList({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   UserAddressListData? data;
//
//   factory UserAddressList.fromJson(Map<String, dynamic> json) => UserAddressList(
//     status: json["status"],
//     message: json["message"],
//     data: UserAddressListData.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data!.toJson(),
//   };
// }
//
// class UserAddressListData {
//   UserAddressListData({
//     this.home,
//     this.office,
//     this.other,
//   });
//
//   List<UserLocationType?>? home;
//   List<UserLocationType?>? office;
//   List<UserLocationType?>? other;
//
//   factory UserAddressListData.fromJson(Map<String, dynamic> json) => UserAddressListData(
//     home: json["home"] == null ? [] : List<UserLocationType?>.from(json["home"]!.map((x) => UserLocationType.fromJson(x))),
//     office: json["office"] == null ? [] : List<UserLocationType?>.from(json["office"]!.map((x) => UserLocationType.fromJson(x))),
//     other: json["other"] == null ? [] : List<UserLocationType?>.from(json["other"]!.map((x) => UserLocationType.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "home": home == null ? [] : List<dynamic>.from(home!.map((x) => x!.toJson())),
//     "office": office == null ? [] : List<dynamic>.from(office!.map((x) => x!.toJson())),
//     "other": other == null ? [] : List<dynamic>.from(other!.map((x) => x!.toJson())),
//   };
// }
//
// class UserLocationType {
//   UserLocationType({
//     this.id,
//     this.address,
//     this.latitude,
//     this.longitude,
//     this.isDefault,
//     this.street,
//     this.landmark,
//     this.addressType,
//   });
//
//   String? id;
//   String? address;
//   String? latitude;
//   String? longitude;
//   String? isDefault;
//   String? street;
//   String? landmark;
//   String? addressType;
//
//   factory UserLocationType.fromJson(Map<String, dynamic> json) => UserLocationType(
//     id: json["id"],
//     address: json["address"],
//     latitude: json["latitude"],
//     longitude: json["longitude"],
//     isDefault: json["is_default"],
//     street: json["street"],
//     landmark: json["landmark"],
//     addressType: json["address_type"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "address": address,
//     "latitude": latitude,
//     "longitude": longitude,
//     "is_default": isDefault,
//     "street": street,
//     "landmark": landmark,
//     "address_type": addressType,
//   };
// }


class UserAddressList {
  bool status;
  String message;
  UserAddressListData data;

  UserAddressList({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserAddressList.fromJson(Map<String, dynamic> json) => UserAddressList(
    status: json["status"],
    message: json["message"],
    data: UserAddressListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class UserAddressListData {
  List<UserLocationTypes> home;
  List<UserLocationTypes> office;
  List<UserLocationTypes> other;

  UserAddressListData({
    required this.home,
    required this.office,
    required this.other,
  });

  factory UserAddressListData.fromJson(Map<String, dynamic> json) => UserAddressListData(
    home: List<UserLocationTypes>.from(json["home"].map((x) => UserLocationTypes.fromJson(x))),
    office: List<UserLocationTypes>.from(json["office"].map((x) => UserLocationTypes.fromJson(x))),
    other: List<UserLocationTypes>.from(json["other"].map((x) => UserLocationTypes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "home": List<dynamic>.from(home.map((x) => x.toJson())),
    "office": List<dynamic>.from(office.map((x) => x.toJson())),
    "other": List<dynamic>.from(other.map((x) => x.toJson())),
  };
}

class UserLocationTypes {
  String id;
  String address;
  String latitude;
  String longitude;
  String isDefault;
  String street;
  String landmark;
  String addressType;

  UserLocationTypes({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.street,
    required this.landmark,
    required this.addressType,
  });

  factory UserLocationTypes.fromJson(Map<String, dynamic> json) => UserLocationTypes(
    id: json["id"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["is_default"]!,
    street: json["street"],
    landmark: json["landmark"],
    addressType: json["address_type"]!,
  );

  Map<String, dynamic> toJson() => {
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

// enum AddressType {
//   HOME,
//   OFFICE,
//   OTHER
// }
//
// final addressTypeValues = EnumValues({
//   "Home": AddressType.HOME,
//   "Office": AddressType.OFFICE,
//   "Other": AddressType.OTHER
// });
//
// enum IsDefault {
//   N,
//   Y
// }
//
// final isDefaultValues = EnumValues({
//   "n": IsDefault.N,
//   "y": IsDefault.Y
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
