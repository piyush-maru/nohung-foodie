

class DefaultAddress {
  bool status;
  String message;
  List<Datum> data;

  DefaultAddress({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DefaultAddress.fromJson(Map<String, dynamic> json) => DefaultAddress(
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
  String id;
  String address;
  String latitude;
  String longitude;
  String isDefault;
  String street;
  String landmark;
  String addressType;

  Datum({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.street,
    required this.landmark,
    required this.addressType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isDefault: json["is_default"],
    street: json["street"],
    landmark: json["landmark"],
    addressType: json["address_type"],
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
