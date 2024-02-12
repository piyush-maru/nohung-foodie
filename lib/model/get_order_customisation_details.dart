// class GetOrderCustomizeDetails {
//   GetOrderCustomizeDetails({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   Data? data;
//
//   GetOrderCustomizeDetails.fromJson(Map<String, dynamic> json) {
//     status = json["status"];
//     message = json["message"];
//     data = Data.fromJson(json["data"]);
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data1 = <String, dynamic>{};
//     data1["status"] = status;
//     data1["message"] = message;
//     data1["data"] = data!.toJson();
//     return data1;
//   }
// }
//
// class Data {
//   Data({//this.orderMenuDetails,
//    this.weekPackageDetails});
//
//   //List<OrderMenuDetails>? orderMenuDetails;
//   List<WeekPackageDetails>? weekPackageDetails;
//
//   Data.fromJson(Map<String, dynamic> json) {
//     // if (json['orderMenuDetails'] != null) {
//     //   orderMenuDetails = [];
//     //   json['orderMenuDetails'].forEach((v) {
//     //     orderMenuDetails?.add(OrderMenuDetails.fromJson(v));
//     //   });
//     // }
//     if (json['weekPackageDetails'] != null) {
//       weekPackageDetails = [];
//       json['weekPackageDetails'].forEach((v) {
//         weekPackageDetails?.add(WeekPackageDetails.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // if (this.orderMenuDetails != null) {
//     //   data['orderMenuDetails'] =
//     //       this.orderMenuDetails!.map((v) => v.toJson()).toList();
//     // }
//     if (this.weekPackageDetails != null) {
//       data['weekPackageDetails'] =
//           this.weekPackageDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class OrderMenuDetails {
//   OrderMenuDetails(
//       {this.cuisineType,
//       this.mealFor,
//       this.itemName,
//       this.itemPrice,
//       this.description,
//       this.inStock,
//       this.categoryId,
//       this.itemType,
//       this.id,
//       this.orderItemId,
//       this.menuId,
//       this.qty,
//       this.price,
//       this.defaultQty,
//       this.extraQty});
//
//   String? cuisineType;
//   String? mealFor;
//   String? itemName;
//   String? itemPrice;
//   String? description;
//   String? inStock;
//   String? categoryId;
//   String? itemType;
//   String? id;
//   String? orderItemId;
//   String? menuId;
//   String? qty;
//   String? price;
//   String? defaultQty;
//   String? extraQty;
//
//   OrderMenuDetails.fromJson(Map<String, dynamic> json) {
//     cuisineType = json['cuisine_type'];
//     mealFor = json['meal_for'];
//     itemName = json['item_name'];
//     itemPrice = json['item_price'];
//     description = json['description'];
//     inStock = json['instock'];
//     categoryId = json['category_id'];
//     itemType = json['item_type'];
//     id = json['id'];
//     orderItemId = json['orderitems_id'];
//     menuId = json['menuid'];
//     qty = json['qty'];
//     price = json['price'];
//     defaultQty = json['default_qty'];
//     extraQty = json['extra_qty'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['cuisine_type'] = cuisineType;
//     data['meal_for'] = mealFor;
//     data['item_name'] = itemName;
//     data['item_price'] = itemPrice;
//     data['description'] = description;
//     data['instock'] = inStock;
//     data['category_id'] = categoryId;
//     data['item_type'] = itemType;
//     data['id'] = id;
//     data['orderitems_id'] = orderItemId;
//     data['menuid'] = menuId;
//     data['qty'] = qty;
//     data['price'] = price;
//     data['default_qty'] = defaultQty;
//     data['extra_qty'] = extraQty;
//     return data;
//   }
// }
//
// class WeekPackageDetails {
//   WeekPackageDetails(
//       {this.id,
//       this.packageId,
//       this.days,
//       this.menu,
//       this.defaultDishItem,
//       this.price,
//       this.image,
//       this.menuItem,
//       this.weeklyPriceVariation,
//       this.monthlyPriceVariation,
//       // this.menuItemDetail,
//       this.menuData});
//
//   String? id;
//   String? packageId;
//   String? days;
//   String? menu;
//   String? defaultDishItem;
//   String? price;
//   String? image;
//   String? menuItem;
//   String? weeklyPriceVariation;
//   String? monthlyPriceVariation;
//  // List<MenuItemDetail>? menuItemDetail;
//   List<MenuData>? menuData;
//
//   WeekPackageDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     packageId = json['packageid'];
//     days = json['days'];
//     menu = json['menu'];
//     defaultDishItem = json['defailtdishitem'];
//     price = json['price'];
//     image = json['image'];
//     menuItem = json['menuitem'];
//     weeklyPriceVariation = json['weekly_price_variation'];
//     monthlyPriceVariation = json['monthly_price_variation'];
//     //menuItemDetail: json['menuitemdetail']
//     // if (json['menuitemdetail'] != null) {
//     //   menuItemDetail = [];
//     //   json['menuitemdetail'].forEach((v) {
//     //     menuItemDetail?.add(MenuItemDetail.fromJson(v));
//     //   });
//     // }
//     if (json['menudata'] != null) {
//       menuData = [];
//       json['menudata'].forEach((v) {
//         menuData?.add(MenuData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['packageid'] = packageId;
//     data['days'] = days;
//     data['menu'] = menu;
//     data['defailtdishitem'] = defaultDishItem;
//     data['price'] = price;
//     data['image'] = image;
//     data['menuitem'] = menuItem;
//     data['weekly_price_variation'] = weeklyPriceVariation;
//     data['monthly_price_variation'] = monthlyPriceVariation;
//     //data['menuitemdetail'] = menuItemDetail;
//     // if (this.menuItemDetail != null) {
//     //   data['menuItemDetail'] =
//     //       this.menuItemDetail!.map((v) => v.toJson()).toList();
//     // }
//     if (this.menuData != null) {
//       data['menudata'] = this.menuData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class MenuItemDetail {
//   MenuItemDetail(
//       {this.id,
//       this.weeklyPackageId,
//       this.itemName,
//       this.menuId,
//       this.qty,
//       this.price,
//       this.defaultQty,
//       this.MVarPrice,
//       this.WVarPrice});
// // {
// //                         "id": "673",
// //                         "weeklypackageid": "272",
// //                         "menuid": "21",
// //                         "itemname": "Paneer Pasanda",
// //                         "qty": "1",
// //                         "price": "369.00",
// //                         "item": "Paneer Pasanda",
// //                         "item_name": "Paneer Pasanda",
// //                         "w_var_price": "369.00",
// //                         "m_var_price": "369.00",
// //                         "default_qty": "1"
// //                     },
//   String? id;
//   String? weeklyPackageId;
//   String? itemName;
//   String? menuId;
//   String? qty;
//   String? price;
//   String? defaultQty;
//   String? WVarPrice;
//   String? MVarPrice;
//
//   MenuItemDetail.fromJson(Map<String, dynamic> json) {
//     itemName = json['itemname'];
//     weeklyPackageId = json['weeklypackageid'];
//     WVarPrice = json['w_var_price'];
//     MVarPrice = json['m_var_price'];
//     id = json['id'];
//     menuId = json['menuid'];
//     qty = json['qty'];
//     price = json['price'];
//     defaultQty = json['default_qty'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['itemname'] = itemName;
//     data['weeklypackageid'] = weeklyPackageId;
//     data['w_var_price'] = WVarPrice;
//     data['m_var_price'] = MVarPrice;
//     data['id'] = id;
//     data['menuid'] = menuId;
//     data['qty'] = qty;
//     data['price'] = price;
//     data['default_qty'] = defaultQty;
//     return data;
//   }
// }
//
// class MenuData {
//   MenuData({
//     this.category,
//     this.menuitems,
//   });
//
//   String? category;
//   List<Menuitem>? menuitems;
//
//   MenuData.fromJson(Map<String, dynamic> json) {
//     category = json["category"];
//     if (json['menuitems'] != null) {
//       menuitems = [];
//       json['menuitems'].forEach((v) {
//         menuitems?.add(Menuitem.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data["category"] = category;
//     if (this.menuitems != null) {
//       data['menuitems'] = this.menuitems!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Menuitem {
//   Menuitem({
//     this.itemId,
//     this.itemName,
//     this.itemQty,
//     this.itemPrice,
//     this.MVariationPrice,
//     this.WVariationPrice,
//     this.defaultQty,
//     this.extraQty,
//     this.orderItemId,
//   });
//   String? itemId;
//   bool? isChecked = false;
//   String? itemName;
//   String? itemQty;
//   String? WVariationPrice;
//   String? MVariationPrice;
//   String? defaultQty;
//   String? extraQty;
//   int? qtytoincrease = 0;
//   String? orderItemId = '0';
//
//   String? itemPrice;
//
//   Menuitem.fromJson(Map<String, dynamic> json) {
//     itemId = json["id"];
//     itemName = json["item_name"];
//     itemQty = json["qty"];
//     itemPrice = json["item_price"];
//     WVariationPrice = json["w_variation_price"];
//     MVariationPrice = json["m_variation_price"];
//     defaultQty = json['default_qty'];
//     extraQty = json['extra_qty'];
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": itemId,
//         "item_name": itemName,
//         "qty": itemQty,
//         "item_price": itemPrice,
//         "w_variation_price": WVariationPrice,
//         "m_variation_price": MVariationPrice,
//         "default_qty": defaultQty,
//         "extra_qty": extraQty
//       };
// }
//
// ---------------------------------------------
// class GetOrderCustomizeDetails {
//   GetOrderCustomizeDetails({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool? status;
//   String? message;
//   Data? data;
//
//   factory GetOrderCustomizeDetails.fromJson(Map<String, dynamic> json) => GetOrderCustomizeDetails(
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data!.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.weekPackageDetails,
//   });
//
//   List<WeekPackageDetail?>? weekPackageDetails;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     weekPackageDetails: json["weekPackageDetails"] == null ? [] : List<WeekPackageDetail?>.from(json["weekPackageDetails"]!.map((x) => WeekPackageDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "weekPackageDetails": weekPackageDetails == null ? [] : List<dynamic>.from(weekPackageDetails!.map((x) => x!.toJson())),
//   };
// }
//
// class WeekPackageDetail {
//   WeekPackageDetail({
//     this.id,
//     this.packageId,
//     this.days,
//     this.menu,
//     this.defaultDishItem,
//     this.price,
//     this.image,
//     this.menuItem,
//     this.weeklyPriceVariation,
//     this.monthlyPriceVariation,
//     this.menuData,
//   });
//
//   String? id;
//   String? packageId;
//   String? days;
//   String? menu;
//   String? defaultDishItem;
//   String? price;
//   String? image;
//   dynamic menuItem;
//   String? weeklyPriceVariation;
//   String? monthlyPriceVariation;
//   List<MenuDataDetails?>? menuData;
//
//   factory WeekPackageDetail.fromJson(Map<String, dynamic> json) => WeekPackageDetail(
//     id: json["id"],
//     packageId: json["packageid"],
//     days: json["days"],
//     menu: json["menu"],
//     defaultDishItem: json["defailtdishitem"],
//     price: json["price"],
//     image: json["image"],
//     menuItem: json["menuitem"],
//     weeklyPriceVariation: json["weekly_price_variation"],
//     monthlyPriceVariation: json["monthly_price_variation"],
//     menuData: json["menudata"] == null ? [] : List<MenuDataDetails?>.from(json["menudata"]!.map((x) => MenuDataDetails.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "packageid": packageId,
//     "days": days,
//     "menu": menu,
//     "defailtdishitem": defaultDishItem,
//     "price": price,
//     "image": image,
//     "menuitem": menuItem,
//     "weekly_price_variation": weeklyPriceVariation,
//     "monthly_price_variation": monthlyPriceVariation,
//     "menudata": menuData == null ? [] : List<dynamic>.from(menuData!.map((x) => x!.toJson())),
//   };
// }
//
// class MenuDataDetails {
//   MenuDataDetails({
//     this.category,
//     this.menuItems,
//   });
//
//   String? category;
//   List<CustomizationMenuItem?>? menuItems;
//
//   factory MenuDataDetails.fromJson(Map<String, dynamic> json) => MenuDataDetails(
//     category: json["category"],
//     menuItems: json["menuitems"] == null ? [] : List<CustomizationMenuItem?>.from(json["menuitems"]!.map((x) => CustomizationMenuItem.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category": category,
//     "menuitems": menuItems == null ? [] : List<dynamic>.from(menuItems!.map((x) => x!.toJson())),
//   };
// }
//
// class CustomizationMenuItem {
//   CustomizationMenuItem({
//     this.id,
//     this.itemName,
//     this.itemPrice,
//     this.qty,
//     this.wVariationPrice,
//     this.mVariationPrice,
//     this.defaultQty,
//     this.extraQty,
//     this.isChecked,
//   });
//
//   String? id;
//   String? itemName;
//   bool? isChecked = false;
//   String? itemPrice;
//   String? qty;
//   String? wVariationPrice;
//   String? mVariationPrice;
//   String? defaultQty;
//   String? extraQty;
//
//   factory CustomizationMenuItem.fromJson(Map<String, dynamic> json) => CustomizationMenuItem(
//     id: json["id"],
//     itemName: json["item_name"],
//     itemPrice: json["item_price"],
//     qty: json["qty"],
//     wVariationPrice: json["w_variation_price"],
//     mVariationPrice: json["m_variation_price"],
//     defaultQty: json["default_qty"],
//     extraQty: json["extra_qty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "item_name": itemName,
//     "item_price": itemPrice,
//     "qty": qty,
//     "w_variation_price": wVariationPrice,
//     "m_variation_price": mVariationPrice,
//     "default_qty": defaultQty,
//     "extra_qty": extraQty,
//   };
// }


class GetOrderCustomizeDetails {
  GetOrderCustomizeDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  CustomizeDataFor data;

  factory GetOrderCustomizeDetails.fromJson(Map<String, dynamic> json) => GetOrderCustomizeDetails(
    status: json["status"],
    message: json["message"],
    data: CustomizeDataFor.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class CustomizeDataFor {
  CustomizeDataFor({
    required this.orderItemDetail,
    required this.weekPackageDetails,
  });

  List<OrderItemDetail> orderItemDetail;
  List<WeekPackageDetail> weekPackageDetails;

  factory CustomizeDataFor.fromJson(Map<String, dynamic> json) => CustomizeDataFor(
    orderItemDetail: List<OrderItemDetail>.from(json["orderItemDetail"].map((x) => OrderItemDetail.fromJson(x))),
    weekPackageDetails: List<WeekPackageDetail>.from(json["weekPackageDetails"].map((x) => WeekPackageDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderItemDetail": List<dynamic>.from(orderItemDetail.map((x) => x.toJson())),
    "weekPackageDetails": List<dynamic>.from(weekPackageDetails.map((x) => x.toJson())),
  };
}

class OrderItemDetail {
  OrderItemDetail({
    required this.id,
    required this.itemName,
    required this.itemPrice,
    required this.qty,
  });

  String id;
  String itemName;
  String itemPrice;
  String qty;

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) => OrderItemDetail(
    id: json["id"],
    itemName: json["item_name"],
    itemPrice: json["item_price"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_name": itemName,
    "item_price": itemPrice,
    "qty": qty,
  };
}

class WeekPackageDetail {
  WeekPackageDetail({
    required this.id,
    required this.packageId,
    required this.days,
    required this.menu,
    required this.defaultDishItem,
    required this.price,
    required this.image,
    required this.menuItem,
    required this.weeklyPriceVariation,
    required this.monthlyPriceVariation,
    required this.menuData,
  });

  String id;
  String packageId;
  String days;
  String menu;
  String defaultDishItem;
  String price;
  String image;
  dynamic menuItem;
  String weeklyPriceVariation;
  String monthlyPriceVariation;
  List<MenuDatum> menuData;

  factory WeekPackageDetail.fromJson(Map<String, dynamic> json) => WeekPackageDetail(
    id: json["id"],
    packageId: json["packageid"],
    days: json["days"],
    menu: json["menu"],
    defaultDishItem: json["defailtdishitem"],
    price: json["price"],
    image: json["image"],
    menuItem: json["menuitem"],
    weeklyPriceVariation: json["weekly_price_variation"],
    monthlyPriceVariation: json["monthly_price_variation"],
    menuData: List<MenuDatum>.from(json["menudata"].map((x) => MenuDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "packageid": packageId,
    "days": days,
    "menu": menu,
    "defailtdishitem": defaultDishItem,
    "price": price,
    "image": image,
    "menuitem": menuItem,
    "weekly_price_variation": weeklyPriceVariation,
    "monthly_price_variation": monthlyPriceVariation,
    "menudata": List<dynamic>.from(menuData.map((x) => x.toJson())),
  };
}

class MenuDatum {
  MenuDatum({
    required this.category,
    required this.menuItems,
  });

  String category;
  List<CustomizeMenuItem> menuItems;

  factory MenuDatum.fromJson(Map<String, dynamic> json) => MenuDatum(
    category: json["category"],
    menuItems: List<CustomizeMenuItem>.from(json["menuitems"].map((x) => CustomizeMenuItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "menuitems": List<dynamic>.from(menuItems.map((x) => x.toJson())),
  };
}

class CustomizeMenuItem {
  CustomizeMenuItem({
    required this.id,
    required this.itemName,
    this.isChecked,
    required this.itemPrice,
    required this.qty,
    required this.wVariationPrice,
    required this.mVariationPrice,
    required this.defaultQty,
    required this.extraQty,
  });

  String id;
  String itemName;
  String itemPrice;
  bool? isChecked = false;
  String qty;
  String wVariationPrice;
  String mVariationPrice;
  String defaultQty;
  String extraQty;

  factory CustomizeMenuItem.fromJson(Map<String, dynamic> json) => CustomizeMenuItem(
    id: json["id"],
    itemName: json["item_name"],
    itemPrice: json["item_price"],
    qty: json["qty"],
    wVariationPrice: json["w_variation_price"],
    mVariationPrice: json["m_variation_price"],
    defaultQty: json["default_qty"],
    extraQty: json["extra_qty"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_name": itemName,
    "item_price": itemPrice,
    "qty": qty,
    "w_variation_price": wVariationPrice,
    "m_variation_price": mVariationPrice,
    "default_qty": defaultQty,
    "extra_qty": extraQty,
  };
}
