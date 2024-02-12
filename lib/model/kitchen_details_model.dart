// To parse this JSON data, do
//
//     final kitchenDetails = kitchenDetailsFromJson(jsonString);

import 'dart:convert';

KitchenDetails kitchenDetailsFromJson(String str) => KitchenDetails.fromJson(json.decode(str));

String kitchenDetailsToJson(KitchenDetails data) => json.encode(data.toJson());

class KitchenDetails {
  KitchenDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<KitchenDetailsData> data;

  factory KitchenDetails.fromJson(Map<String, dynamic> json) => KitchenDetails(
    status: json["status"],
    message: json["message"],
    data: List<KitchenDetailsData>.from(json["data"].map((x) => KitchenDetailsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class KitchenDetailsData {
  KitchenDetailsData({
    required this.image,
    required this.kitchenId,
    required this.kitchenname,
    required this.foodtype,
    required this.address,
    required this.timing,
    required this.openStatus,
    required this.totalReview,
    required this.avgReview,
    required this.isFavourite,
    required this.offers,
    required this.orderNowDetail,
    required this.subscriptionDetail,
  });

  String kitchenId;
  String kitchenname;
  String foodtype;
  String address;
  String timing;
  String openStatus;
  String totalReview;
  int avgReview;
  String isFavourite;
  List<Offer> offers;
  List<dynamic> orderNowDetail;
  SubscriptionDetail subscriptionDetail;
  String image;
  factory KitchenDetailsData.fromJson(Map<String, dynamic> json) => KitchenDetailsData(
    image :json['profile_image'],
    kitchenId: json["kitchen_id"],
    kitchenname: json["kitchenname"],
    foodtype: json["foodtype"],
    address: json["address"],
    timing: json["timing"],
    openStatus: json["open_status"],
    totalReview: json["total_review"],
    avgReview: json["avg_review"],
    isFavourite: json["is_favourite"],
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    orderNowDetail: List<dynamic>.from(json["order_now_detail"].map((x) => x)),
    subscriptionDetail: SubscriptionDetail.fromJson(json["subscription_detail"]),
  );

  Map<String, dynamic> toJson() => {
    "kitchen_id": kitchenId,
    "kitchenname": kitchenname,
    "foodtype": foodtype,
    "address": address,
    "timing": timing,
    "open_status": openStatus,
    "total_review": totalReview,
    "avg_review": avgReview,
    "is_favourite": isFavourite,
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
    "order_now_detail": List<dynamic>.from(orderNowDetail.map((x) => x)),
    "subscription_detail": subscriptionDetail.toJson(),
  };
}

class Offer {
  Offer({
    required this.offercode,
    required this.discounttype,
    required this.discount,
    required this.uptoAmount,
  });

  String offercode;
  String discounttype;
  int discount;
  String uptoAmount;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    offercode: json["offercode"],
    discounttype: json["discounttype"],
    discount: json["discount"],
    uptoAmount: json["upto_amount"],
  );

  Map<String, dynamic> toJson() => {
    "offercode": offercode,
    "discounttype": discounttype,
    "discount": discount,
    "upto_amount": uptoAmount,
  };
}

class SubscriptionDetail {
  SubscriptionDetail({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  List<dynamic> breakfast;
  List<Dinner> lunch;
  List<Dinner> dinner;

  factory SubscriptionDetail.fromJson(Map<String, dynamic> json) => SubscriptionDetail(
    breakfast: List<dynamic>.from(json["breakfast"].map((x) => x)),
    lunch: List<Dinner>.from(json["lunch"].map((x) => Dinner.fromJson(x))),
    dinner: List<Dinner>.from(json["dinner"].map((x) => Dinner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "breakfast": List<dynamic>.from(breakfast.map((x) => x)),
    "lunch": List<dynamic>.from(lunch.map((x) => x.toJson())),
    "dinner": List<dynamic>.from(dinner.map((x) => x.toJson())),
  };
}

class Dinner {
  Dinner({
    required this.packageId,
    required this.packageName,
    required this.weekly,
    required this.monthly,
    required this.cuisinetype,
    required this.cuisines,
    required this.price,
    required this.including,
    required this.includingSaturday,
    required this.includingSunday,
    required this.provideCustomization,
  });

  String packageId;
  String packageName;
  String weekly;
  String monthly;
  String cuisinetype;
  String cuisines;
  String price;
  String including;
  String includingSaturday;
  String includingSunday;
  String provideCustomization;

  factory Dinner.fromJson(Map<String, dynamic> json) => Dinner(
    packageId: json["package_id"],
    packageName: json["package_name"],
    weekly: json["weekly"],
    monthly: json["monthly"],
    cuisinetype: json["cuisinetype"],
    cuisines: json["cuisines"],
    price: json["price"],
    including: json["including"],
    includingSaturday: json["including_saturday"],
    includingSunday: json["including_sunday"],
    provideCustomization: json["provide_customization"],
  );

  Map<String, dynamic> toJson() => {
    "package_id": packageId,
    "package_name": packageName,
    "weekly": weekly,
    "monthly": monthly,
    "cuisinetype": cuisinetype,
    "cuisines": cuisines,
    "price": price,
    "including": including,
    "including_saturday": includingSaturday,
    "including_sunday": includingSunday,
    "provide_customization": provideCustomization,
  };
}