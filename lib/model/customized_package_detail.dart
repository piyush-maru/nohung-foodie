// To parse this JSON data, do
//
//     final beanCustomizedPackageDetail = beanCustomizedPackageDetailFromJson(jsonString);

import 'dart:convert';

BeanCustomizedPackageDetail beanCustomizedPackageDetailFromJson(String str) =>
    BeanCustomizedPackageDetail.fromJson(json.decode(str));

String beanCustomizedPackageDetailToJson(BeanCustomizedPackageDetail data) =>
    json.encode(data.toJson());

class BeanCustomizedPackageDetail {
  BeanCustomizedPackageDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  CustomizeData data;

  factory BeanCustomizedPackageDetail.fromJson(Map<String, dynamic> json) =>
      BeanCustomizedPackageDetail(
        status: json["status"],
        message: json["message"],
        data: CustomizeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class CustomizeData {
  final String? kitchenId;
  final String? packageId;
  final String? packageName;
  final String? description;
  final String? mealfor;
  final String? mealtype;
  final String? cuisinetype;
  final String? mealPlan;
  final String? includingSaturday;
  final String? includingSunday;
  final int? countDays;
  final String? price;
  final String? provideCustomization;
  final List<PackageDetail>? packageDetail;

  CustomizeData({
    this.kitchenId,
    this.packageId,
    this.packageName,
    this.description,
    this.mealfor,
    this.mealtype,
    this.cuisinetype,
    this.mealPlan,
    this.includingSaturday,
    this.includingSunday,
    this.countDays,
    this.price,
    this.provideCustomization,
    this.packageDetail,
  });

  factory CustomizeData.fromJson(Map<String, dynamic> json) => CustomizeData(
        kitchenId: json["kitchen_id"],
        packageId: json["package_id"],
        packageName: json["package_name"],
        description: json["description"],
        mealfor: json["mealfor"],
        mealtype: json["mealtype"],
        cuisinetype: json["cuisinetype"],
        mealPlan: json["meal_plan"],
        includingSaturday: json["including_saturday"],
        includingSunday: json["including_sunday"],
        countDays: json["count_days"],
        price: json["price"],
        provideCustomization: json["provide_customization"],
        packageDetail: json["package_detail"] == null
            ? []
            : List<PackageDetail>.from(
                json["package_detail"]!.map((x) => PackageDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "package_id": packageId,
        "package_name": packageName,
        "description": description,
        "mealfor": mealfor,
        "mealtype": mealtype,
        "cuisinetype": cuisinetype,
        "meal_plan": mealPlan,
        "including_saturday": includingSaturday,
        "including_sunday": includingSunday,
        "count_days": countDays,
        "price": price,
        "provide_customization": provideCustomization,
        "package_detail": packageDetail == null
            ? []
            : List<dynamic>.from(packageDetail!.map((x) => x.toJson())),
      };
}

class PackageDetail {
  final String? weeklyPackageId;
  final String? mealPrice;
  final String? date;
  final String? days;
  final String? daysName;
  final List<Item>? items;
  final String? customisedTime;

  PackageDetail({
    this.weeklyPackageId,
    this.mealPrice,
    this.date,
    this.days,
    this.daysName,
    this.items,
    this.customisedTime,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        weeklyPackageId: json["weekly_package_id"],
        mealPrice: json["meal_price"],
        date: json["date"],
        days: json["days"],
        daysName: json["days_name"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        customisedTime: json["customised_time"],
      );

  Map<String, dynamic> toJson() => {
        "weekly_package_id": weeklyPackageId,
        "meal_price": mealPrice,
        "date": date,
        "days": days,
        "days_name": daysName,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "customised_time": customisedTime,
      };
}

class Item {
  final String? menuid;
  final String? itemname;
  final dynamic qty;
  final dynamic defaultQty;
  final int? extraQty;
  final String? price;
  final double? varPrice;

  Item({
    this.menuid,
    this.itemname,
    this.qty,
    this.defaultQty,
    this.extraQty,
    this.price,
    this.varPrice,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        menuid: json["menuid"],
        itemname: json["itemname"],
        qty: json["qty"],
        defaultQty: json["default_qty"],
        extraQty: json["extra_qty"],
        price: json["price"],
        varPrice: json["var_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "menuid": menuid,
        "itemname": itemname,
        "qty": qty,
        "default_qty": defaultQty,
        "extra_qty": extraQty,
        "price": price,
        "var_price": varPrice,
      };
}
