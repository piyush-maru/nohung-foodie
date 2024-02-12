

class GetFavKitchen {
  bool status;
  String message;
  List<FavKitchenData> data;

  GetFavKitchen({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetFavKitchen.fromJson(Map<String, dynamic> json) => GetFavKitchen(
    status: json["status"],
    message: json["message"],
    data: List<FavKitchenData>.from(json["data"].map((x) => FavKitchenData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FavKitchenData {
  String? id;
  String? kitchenName;
  String? foodType;
  String? address;
  dynamic profilePic;
  String? ratingSystem;
  String startingPrice;
  String timing;

  FavKitchenData({
    this.id,
    this.kitchenName,
    this.foodType,
    this.address,
    this.profilePic,
    this.ratingSystem,
    required this.startingPrice,
    required this.timing,
  });

  factory FavKitchenData.fromJson(Map<String, dynamic> json) => FavKitchenData(
    id: json["id"],
    kitchenName: json["kitchenname"],
    foodType: json["foodtype"],
    address: json["address"],
    profilePic: json["profile_pic"],
    ratingSystem: json["rating_system"],
    startingPrice: json["starting_price"],
    timing: json["timing"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kitchenname": kitchenName,
    "foodtype": foodType,
    "address": address,
    "profile_pic": profilePic,
    "rating_system": ratingSystem,
    "starting_price": startingPrice,
    "timing": timing,
  };
}
