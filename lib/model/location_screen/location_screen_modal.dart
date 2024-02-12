
class UserLocationsClass {
  bool status;
  String message;
  LocationData data;

  UserLocationsClass({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserLocationsClass.fromMap(Map<String, dynamic> json) => UserLocationsClass(
    status: json["status"],
    message: json["message"],
    data: LocationData.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": data.toMap(),
  };
}

class LocationData {
  List<LocationType> home;
  List<LocationType> office;
  List<LocationType> other;

  LocationData({
    required this.home,
    required this.office,
    required this.other,
  });

  factory LocationData.fromMap(Map<String, dynamic> json) => LocationData(
    home: List<LocationType>.from(json["home"].map((x) => LocationType.fromMap(x))),
    office: List<LocationType>.from(json["office"].map((x) => LocationType.fromMap(x))),
    other: List<LocationType>.from(json["other"].map((x) => LocationType.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "home": List<dynamic>.from(home.map((x) => x.toMap())),
    "office": List<dynamic>.from(office.map((x) => x.toMap())),
    "other": List<dynamic>.from(other.map((x) => x.toMap())),
  };
}

class LocationType {
  String id;
  String address;
  String latitude;
  String longitude;
  String isDefault;
  String street;
  String landmark;
  String addressType;

  LocationType({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.street,
    required this.landmark,
    required this.addressType,
  });

  factory LocationType.fromMap(Map<String, dynamic> json) => LocationType(
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

