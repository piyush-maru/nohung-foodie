class SearchLocationClass {
  bool status;
  String message;
  List<Datum> data;

  SearchLocationClass({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SearchLocationClass.fromJson(Map<String, dynamic> json) => SearchLocationClass(
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
  List<NearbyKitchen> nearbyKitchen;

  Datum({
    required this.nearbyKitchen,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    nearbyKitchen: List<NearbyKitchen>.from(json["nearby_kitchen"].map((x) => NearbyKitchen.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nearby_kitchen": List<dynamic>.from(nearbyKitchen.map((x) => x.toJson())),
  };
}

class NearbyKitchen {
  String id;
  String kitchenName;
  String deliveryAddress;

  NearbyKitchen({
    required this.id,
    required this.kitchenName,
    required this.deliveryAddress,
  });

  factory NearbyKitchen.fromJson(Map<String, dynamic> json) => NearbyKitchen(
    id: json["id"],
    kitchenName: json["kitchenname"]!,
    deliveryAddress: json["deliveryaddress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kitchenname": kitchenName,
    "deliveryaddress": deliveryAddress,
  };
}

