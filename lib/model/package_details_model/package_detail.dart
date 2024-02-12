import 'dart:convert';

BeanPackageDetail beanPackageDetailFromJson(String str) =>
    BeanPackageDetail.fromJson(json.decode(str));

String beanPackageDetailToJson(BeanPackageDetail data) =>
    json.encode(data.toJson());

class BeanPackageDetail {
  BeanPackageDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final String? message;
  final BeanPackageDetailData? data;

  factory BeanPackageDetail.fromJson(Map<String, dynamic> json) =>
      BeanPackageDetail(
        status: json["status"],
        message: json["message"],
        data: BeanPackageDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class BeanPackageDetailData {
  BeanPackageDetailData({
    required this.kitchenId,
    required this.packageId,
    required this.packageName,
    required this.mealFor,
    required this.mealType,
    required this.cuisineType,
    required this.price,
    required this.packageDetail,
  });

  final String kitchenId;
  final String packageId;
  final String packageName;
  final String mealFor;
  final String mealType;
  final String cuisineType;
  final String price;
  final List<PackageDetail> packageDetail;

  factory BeanPackageDetailData.fromJson(Map<String, dynamic> json) =>
      BeanPackageDetailData(
        kitchenId: json["kitchen_id"],
        packageId: json["package_id"],
        packageName: json["package_name"],
        mealFor: json["mealfor"],
        mealType: json["mealtype"],
        cuisineType: json["cuisinetype"],
        price: json["price"],
        packageDetail: List<PackageDetail>.from(
            json["package_detail"].map((x) => PackageDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "package_id": packageId,
        "package_name": packageName,
        "mealfor": mealFor,
        "mealtype": mealType,
        "cuisinetype": cuisineType,
        "price": price,
        "package_detail":
            List<dynamic>.from(packageDetail.map((x) => x.toJson())),
      };
}

class PackageDetail {
  PackageDetail({
    required this.weeklyPackageId,
    required this.days,
    required this.daysName,
    required this.itemName,
    required this.menuItem,
  });

  final String? weeklyPackageId;
  final String? days;
  final String? daysName;
  final String? itemName;
  final List<Menu> menuItem;

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        weeklyPackageId: json["weekly_package_id"],
        days: json["days"],
        daysName: json["days_name"],
        itemName: json["item_name"],
        menuItem: List<Menu>.from(
            json["menu_item"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "weekly_package_id": weeklyPackageId,
        "days": days,
        "days_name": daysName,
        "item_name": itemName,
        "menu_item": List<dynamic>.from(menuItem.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    required this.category,
    required this.menuitems,
  });

  final String category;
  final List<Menuitem> menuitems;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        category: json["category"],
        menuitems: List<Menuitem>.from(
            json["menuitems"].map((x) => Menuitem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "menuitems": List<dynamic>.from(menuitems.map((x) => x.toJson())),
      };
}

class Menuitem {
  Menuitem({
    required this.itemId,
    required this.itemName,
    required this.itemQty,
    required this.itemPrice,
  });
  final String itemId;
  bool? isChecked = false;
  final String itemName;
  int itemQty;
  int qtytoincrease = 0;
  int extraQty=0;

  final String itemPrice;

  factory Menuitem.fromJson(Map<String, dynamic> json) => Menuitem(
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemQty: int.parse(json["item_qty"]),
        itemPrice: json["item_price"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_name": itemName,
        "item_qty": itemQty,
        "item_price": itemPrice,
      };
}

