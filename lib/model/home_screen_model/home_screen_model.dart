

class HomeKitchen {
  bool status;
  String message;
  List<HomeKitchenData> data;

  HomeKitchen({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeKitchen.fromJson(Map<String, dynamic> json) => HomeKitchen(
    status: json["status"],
    message: json["message"],
    data: List<HomeKitchenData>.from(json["data"].map((x) => HomeKitchenData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class HomeKitchenData {
  String kitchenId;
  String kitchenName;
  String address;
  String mealType;
  String cuisineType;
  String discount;
  String image;
  String averageRating;
  String totalReview;
  String time;
  String isFavourite;
  String startingPrice;
  String kitchenType;
  String foodType;

  HomeKitchenData({
    required this.kitchenId,
    required this.kitchenName,
    required this.address,
    required this.mealType,
    required this.cuisineType,
    required this.discount,
    required this.image,
    required this.averageRating,
    required this.totalReview,
    required this.time,
    required this.isFavourite,
    required this.startingPrice,
    required this.kitchenType,
    required this.foodType,
  });

  factory HomeKitchenData.fromJson(Map<String, dynamic> json) => HomeKitchenData(
    kitchenId: json["kitchen_id"],
    kitchenName: json["kitchenname"],
    address: json["address"],
    mealType: json["mealtype"],
    cuisineType: json["cuisinetype"],
    discount: json["discount"],
    image: json["image"],
    averageRating: json["average_rating"],
    totalReview: json["total_review"],
    time: json["time"],
    isFavourite: json["is_favourite"],
    startingPrice: json["starting_price"],
    kitchenType: json["kitchentype"]!,
    foodType: json["food_type"]!,
  );

  Map<String, dynamic> toJson() => {
    "kitchen_id": kitchenId,
    "kitchenname": kitchenName,
    "address": address,
    "mealtype": mealType,
    "cuisinetype": cuisineType,
    "discount": discount,
    "image": image,
    "average_rating": averageRating,
    "total_review": totalReview,
    "time": time,
    "is_favourite": isFavourite,
    "starting_price": startingPrice,
    "kitchentype": kitchenType,
    "food_type": foodType,
  };
}

