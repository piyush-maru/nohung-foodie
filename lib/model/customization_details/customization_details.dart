

import 'dart:convert';

CustomizationDetails customizationDetailsFromJson(String str) => CustomizationDetails.fromJson(json.decode(str));

String customizationDetailsToJson(CustomizationDetails data) => json.encode(data.toJson());

class CustomizationDetails {
  CustomizationDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<CustomizationData> data;

  factory CustomizationDetails.fromJson(Map<String, dynamic> json) => CustomizationDetails(
    status: json["status"],
    message: json["message"],
    data: List<CustomizationData>.from(json["data"].map((x) => CustomizationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CustomizationData {
  CustomizationData({
    required this.category,
    required this.menuitems,
  });

  String category;
  List<MenuitemsOfData> menuitems;

  factory CustomizationData.fromJson(Map<String, dynamic> json) => CustomizationData(
    category: json["category"],
    menuitems: List<MenuitemsOfData>.from(json["menuitems"].map((x) => MenuitemsOfData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "menuitems": List<MenuitemsOfData>.from(menuitems.map((x) => x.toJson())),
  };
}

class MenuitemsOfData {
  MenuitemsOfData({
   required  this.menuId,
   required  this.itemName,
   required  this.itemPrice,
   required  this.qty,
   required  this.provideCustomization,
   required  this.varPrice,
  });

  String menuId;
  String itemName;
  String itemPrice;
  var qty;
  var provideCustomization;
  String varPrice;

  factory MenuitemsOfData.fromJson(Map<String, dynamic> json) => MenuitemsOfData(
    menuId: json["menu_id"],
    itemName: json["item_name"],
    itemPrice: json["item_price"],
    qty: json["qty"],
    provideCustomization:json["provide_customization"],
    varPrice: json["var_price"],
  );

  Map<String, dynamic> toJson() => {
    "menu_id": menuId,
    "item_name": itemName,
    "item_price": itemPrice,
    "qty": qty,
    "provide_customization":provideCustomization,
    "var_price": varPrice,
  };
}

