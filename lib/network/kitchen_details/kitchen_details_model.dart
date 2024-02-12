import 'dart:convert';

import '../../model/kitchen_details_model.dart';

KitchenDetailsApi kitchenDetailsApiFromJson(String str) =>
    KitchenDetailsApi.fromJson(json.decode(str));

String kitchenDetailsApiToJson(KitchenDetailsApi data) =>
    json.encode(data.toJson());

class KitchenDetailsApi {
  KitchenDetailsApi({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<KitchenDetailsData> data;

  factory KitchenDetailsApi.fromJson(Map<String, dynamic> json) =>
      KitchenDetailsApi(
        status: json["status"],
        message: json["message"],
        data: List<KitchenDetailsData>.from(
            json["data"].map((x) => KitchenDetailsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KitchenDetailsData {
  KitchenDetailsData({
    required this.kitchenId,
    required this.kitchen_details_id,
    required this.kitchenName,
    required this.profileImage,
    required this.foodType,
    required this.address,
    required this.timing,
    required this.openStatus,
    required this.availableStatus,
    required this.about,
    required this.totalReview,
    this.cuisineForSubscription,
    this.cuisineForPreorder,
    required this.avgReview,
    required this.isFavourite,
    this.offers,
    this.orderNowDetail,
    this.subscriptionDetail,
  });

  String kitchenId;
  String kitchen_details_id;
  String kitchenName;
  String profileImage;
  String foodType;
  String address;
  String timing;
  String openStatus;
  String availableStatus;
  String about;
  String totalReview;
  final List<CuisineForSubscription>? cuisineForSubscription;
  final List<CuisineForPreorder>? cuisineForPreorder;
  int avgReview;
  String isFavourite;
  List<Offer>? offers;
  List<OrderNowDetail>? orderNowDetail;
  SubscriptionPackageDetail? subscriptionDetail;

  factory KitchenDetailsData.fromJson(Map<String, dynamic> json) =>
      KitchenDetailsData(
        kitchenId: json["kitchen_id"],
        kitchen_details_id: json["kitchen_details_id"],
        kitchenName: json["kitchenname"],
        profileImage: json["profile_image"],
        foodType: json["foodtype"],
        address: json["address"],
        timing: json["timing"],
        openStatus: json["open_status"],
        availableStatus: json["available_status"],
        about: json["about"],
        totalReview: json["total_review"],
        avgReview: json["avg_review"],
        isFavourite: json["is_favourite"],
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
        cuisineForSubscription: json["cuisine_for_subscription"] == null
            ? []
            : List<CuisineForSubscription>.from(
                json["cuisine_for_subscription"]!
                    .map((x) => CuisineForSubscription.fromJson(x))),
        cuisineForPreorder: json["cuisine_for_preorder"] == null
            ? []
            : List<CuisineForPreorder>.from(json["cuisine_for_preorder"]!
                .map((x) => CuisineForPreorder.fromJson(x))),
        orderNowDetail: List<OrderNowDetail>.from(
            json["order_now_detail"].map((x) => OrderNowDetail.fromJson(x))),
        subscriptionDetail:
            SubscriptionPackageDetail.fromJson(json["subscription_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "kitchen_details_id": kitchen_details_id,
        "kitchenname": kitchenName,
        "profile_image": profileImage,
        "foodtype": foodType,
        "address": address,
        "timing": timing,
        "open_status": openStatus,
        "available_status": availableStatus,
        "about": about,
        "total_review": totalReview,
        "avg_review": avgReview,
        "is_favourite": isFavourite,
        "offers": List<dynamic>.from(offers!.map((x) => x.toJson())),
        "order_now_detail": List<dynamic>.from(orderNowDetail!.map((x) => x)),
        "subscription_detail": subscriptionDetail!.toJson(),
      };
}

class OrderNowDetail {
  OrderNowDetail({
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.countItems,
    required this.menuItems,
  });

  String categoryId;
  String categoryName;
  String description;
  String countItems;
  List<MenuItem> menuItems;

  factory OrderNowDetail.fromJson(Map<String, dynamic> json) => OrderNowDetail(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        description: json["description"],
        countItems: json["count_items"],
        menuItems: List<MenuItem>.from(
            json["menu_items"].map((x) => MenuItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "description": description,
        "count_items": countItems,
        "menu_items": List<dynamic>.from(menuItems.map((x) => x.toJson())),
      };
}

class MenuItem {
  MenuItem({
    required this.menuId,
    required this.itemName,
    required this.itemPrice,
    required this.cuisineType,
    required this.image,
    required this.description,
    required this.inStock,
    required this.quantity,
    required this.itemType,
  });
  int quantity;
  String menuId;
  String itemName;
  String itemPrice;
  String cuisineType;
  String image;
  String description;
  String inStock;
  String itemType;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        menuId: json["menu_id"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        cuisineType: json["cuisine_type"],
        image: json["image"],
        description: json["description"],
        inStock: json["instock"],
         itemType: json["item_type"],
        quantity: 0,
      );

  Map<String, dynamic> toJson() => {
        "menu_id": menuId,
        "item_name": itemName,
        "item_price": itemPrice,
        "cuisine_type": cuisineType,
        "image": image,
        "description": description,
        "instock": inStock,
        "item_type": itemType,
      };
}

class SubscriptionPackageDetail {
  SubscriptionPackageDetail({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  List<MealPlan>? breakfast;
  List<MealPlan>? lunch;
  List<MealPlan>? dinner;

  factory SubscriptionPackageDetail.fromJson(Map<String, dynamic> json) =>
      SubscriptionPackageDetail(
        breakfast: List<MealPlan>.from(
            json["breakfast"].map((x) => MealPlan.fromJson(x))),
        lunch:
            List<MealPlan>.from(json["lunch"].map((x) => MealPlan.fromJson(x))),
        dinner: List<MealPlan>.from(
            json["dinner"].map((x) => MealPlan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "breakfast": List<dynamic>.from(breakfast!.map((x) => x)),
        "lunch": List<dynamic>.from(lunch!.map((x) => x.toJson())),
        "dinner": List<dynamic>.from(dinner!.map((x) => x.toJson())),
      };
}

class MealPlan {
  MealPlan({
    required this.bestSeller,
    required this.packageId,
    required this.packageName,
    required this.weekly,
    required this.mealtype,
    required this.monthly,
    required this.cuisineType,
    required this.cuisines,
    required this.price,
    required this.oneDayPrice,
    required this.weeklyPriceOn,
    required this.monthlyPriceOn,
    required this.weeklyNewPrice,
    required this.weeklyOldPrice,
    required this.monthlyNewPrice,
    required this.monthlyOldPrice,
    required this.including,
    required this.includingSaturday,
    required this.includingSunday,
    required this.provideCustomization,
    required this.description,
  });
  int bestSeller;
  String description;
  String packageId;
  String packageName;
  String weekly;
  String mealtype;
  String monthly;
  String cuisineType;
  String? cuisines;
  String price;
  String oneDayPrice;
  String weeklyPriceOn;
  String monthlyPriceOn;
  String weeklyNewPrice;
  String weeklyOldPrice;
  String monthlyNewPrice;
  String monthlyOldPrice;
  String including;
  String includingSaturday;
  String includingSunday;
  String provideCustomization;

  factory MealPlan.fromJson(Map<String, dynamic> json) => MealPlan(
        bestSeller: json['best_seller'],
        description: json['description'],
        packageId: json["package_id"],
        packageName: json["package_name"],
        weekly: json["weekly"],
        mealtype: json["mealtype"],
        monthly: json["monthly"],
        cuisineType: json["cuisinetype"],
        cuisines: json["cuisines"],
        price: json["price"],
        weeklyPriceOn: json["weekly_price_on"],
        oneDayPrice: json["one_day_price"],
        monthlyPriceOn: json["monthly_price_on"],
        weeklyNewPrice: json["weekly_new_price"],
        weeklyOldPrice: json["weekly_old_price"],
        monthlyNewPrice: json["monthly_new_price"],
        monthlyOldPrice: json["monthly_old_price"],
        including: json["including"],
        includingSaturday: json["including_saturday"],
        includingSunday: json["including_sunday"],
        provideCustomization: json["provide_customization"],
      );

  Map<String, dynamic> toJson() => {
        "best_seller": bestSeller,
        "description": description,
        "package_id": packageId,
        "package_name": packageName,
        "weekly": weekly,
        "mealtype": mealtype,
        "monthly": monthly,
        "cuisinetype": cuisineType,
        "cuisines": cuisines,
        "price": price,
        "weekly_price_on": weeklyPriceOn,
        "one_day_price": oneDayPrice,
        "monthly_price_on": monthlyPriceOn,
        "weekly_new_price": weeklyNewPrice,
        "weekly_old_price": weeklyOldPrice,
        "monthly_new_price": monthlyNewPrice,
        "monthly_old_price": monthlyOldPrice,
        "including": including,
        "including_saturday": includingSaturday,
        "including_sunday": includingSunday,
        "provide_customization": provideCustomization,
      };
}

class CuisineForPreorder {
  final int? key;
  final String? name;

  CuisineForPreorder({
    this.key,
    this.name,
  });

  factory CuisineForPreorder.fromJson(Map<String, dynamic> json) =>
      CuisineForPreorder(
        key: json["key"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
      };
}

class CuisineForSubscription {
  final String? key;
  final String? name;

  CuisineForSubscription({
    this.key,
    this.name,
  });

  factory CuisineForSubscription.fromJson(Map<String, dynamic> json) =>
      CuisineForSubscription(
        key: json["key"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
      };
}
