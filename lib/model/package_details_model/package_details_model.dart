//
//
//
// class CustomizationPackageDetailsModel {
//   CustomizationPackageDetailsModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//  PackageDetailsModel
//
//   {
//
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//
//   PackageDetailsModel({this.status, this.message, this.data});
//
//
//   factory CustomizationPackageDetailsModel.fromJson(Map<String, dynamic> json) => CustomizationPackageDetailsModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<PackageDetailsData>.from(json["data"].map((x) => PackageDetailsData.fromJson(x))),
//   );
//
//   PackageDetailsModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? kitchenId;
//   String? packageId;
//   String? packageName;
//   String? mealfor;
//   String? mealtype;
//   String? cuisinetype;
//   String? price;
//   String? subscriptionOrderPriorTiming;
//   String? description;
//   String? provideCustomization;
//   String? weekly;
//   String? monthly;
//   String? includingSaturday;
//   String? includingSunday;
//   List<DeliveryTime>? deliveryTime;
//   List<PackageDetail>? packageDetail;
//
//   Data(
//       {this.kitchenId,
//         this.packageId,
//         this.packageName,
//         this.mealfor,
//         this.mealtype,
//         this.cuisinetype,
//         this.price,
//         this.subscriptionOrderPriorTiming,
//         this.description,
//         this.provideCustomization,
//         this.weekly,
//         this.monthly,
//         this.includingSaturday,
//         this.includingSunday,
//         this.deliveryTime,
//         this.packageDetail});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     kitchenId = json['kitchen_id'];
//     packageId = json['package_id'];
//     packageName = json['package_name'];
//     mealfor = json['mealfor'];
//     mealtype = json['mealtype'];
//     cuisinetype = json['cuisinetype'];
//     price = json['price'];
//     subscriptionOrderPriorTiming = json['subscription_order_prior_timing'];
//     description = json['description'];
//     provideCustomization = json['provide_customization'];
//     weekly = json['weekly'];
//     monthly = json['monthly'];
//     includingSaturday = json['including_saturday'];
//     includingSunday = json['including_sunday'];
//     if (json['delivery_time'] != null) {
//       deliveryTime = <DeliveryTime>[];
//       json['delivery_time'].forEach((v) {
//         deliveryTime!.add(new DeliveryTime.fromJson(v));
//       });
//     }
//     if (json['package_detail'] != null) {
//       packageDetail = <PackageDetail>[];
//       json['package_detail'].forEach((v) {
//         packageDetail!.add(new PackageDetail.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['kitchen_id'] = this.kitchenId;
//     data['package_id'] = this.packageId;
//     data['package_name'] = this.packageName;
//     data['mealfor'] = this.mealfor;
//     data['mealtype'] = this.mealtype;
//     data['cuisinetype'] = this.cuisinetype;
//     data['price'] = this.price;
//     data['subscription_order_prior_timing'] = this.subscriptionOrderPriorTiming;
//     data['description'] = this.description;
//     data['provide_customization'] = this.provideCustomization;
//     data['weekly'] = this.weekly;
//     data['monthly'] = this.monthly;
//     data['including_saturday'] = this.includingSaturday;
//     data['including_sunday'] = this.includingSunday;
//     if (this.deliveryTime != null) {
//       data['delivery_time'] =
//           this.deliveryTime!.map((v) => v.toJson()).toList();
//     }
//     if (this.packageDetail != null) {
//       data['package_detail'] =
//           this.packageDetail!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class DeliveryTime {
//   String? fromTime;
//   String? toTime;
//   String? time;
//
//   DeliveryTime({this.fromTime, this.toTime, this.time});
//
//   DeliveryTime.fromJson(Map<String, dynamic> json) {
//     fromTime = json['from_time'];
//     toTime = json['to_time'];
//     time = json['time'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['from_time'] = this.fromTime;
//     data['to_time'] = this.toTime;
//     data['time'] = this.time;
//     return data;
//   }
// }
//
// class PackageDetail {
//   String? weeklyPackageId;
//   String? days;
//   String? daysName;
//   String? itemName;
//   List<MenuItem>? menuItem;
//
//   PackageDetail(
//       {this.weeklyPackageId,
//         this.days,
//         this.daysName,
//         this.itemName,
//         this.menuItem});
//
//   PackageDetail.fromJson(Map<String, dynamic> json) {
//     weeklyPackageId = json['weekly_package_id'];
//     days = json['days'];
//     daysName = json['days_name'];
//     itemName = json['item_name'];
//     if (json['menu_item'] != null) {
//       menuItem = <MenuItem>[];
//       json['menu_item'].forEach((v) {
//         menuItem!.add(new MenuItem.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['weekly_package_id'] = this.weeklyPackageId;
//     data['days'] = this.days;
//     data['days_name'] = this.daysName;
//     data['item_name'] = this.itemName;
//     if (this.menuItem != null) {
//       data['menu_item'] = this.menuItem!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class MenuItem {
//   String? category;
//   List<Menuitems>? menuitems;
//
//   MenuItem({this.category, this.menuitems});
//
//   MenuItem.fromJson(Map<String, dynamic> json) {
//     category = json['category'];
//     if (json['menuitems'] != null) {
//       menuitems = <Menuitems>[];
//       json['menuitems'].forEach((v) {
//         menuitems!.add(new Menuitems.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['category'] = this.category;
//     if (this.menuitems != null) {
//       data['menuitems'] = this.menuitems!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Menuitems {
//   String? itemId;
//   String? itemName;
//   String? itemQty;
//   String? itemPrice;
//
//   Menuitems({this.itemId, this.itemName, this.itemQty, this.itemPrice});
//
//   Menuitems.fromJson(Map<String, dynamic> json) {
//     itemId = json['item_id'];
//     itemName = json['item_name'];
//     itemQty = json['item_qty'];
//     itemPrice = json['item_price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['item_id'] = this.itemId;
//     data['item_name'] = this.itemName;
//     data['item_qty'] = this.itemQty;
//     data['item_price'] = this.itemPrice;
//     return data;
//   }
// }
//

class CustomizationPackageDetailsModel {
  bool status;
  String message;
  List<PackageDetailsData> data;

  CustomizationPackageDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CustomizationPackageDetailsModel.fromJson(
      Map<String, dynamic> json) =>
      CustomizationPackageDetailsModel(
        status: json["status"],
        message: json["message"],
        data: List<PackageDetailsData>.from(
            json["data"].map((x) => PackageDetailsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PackageDetailsData {
  String kitchenId;
  String packageId;
  String packageName;
  String mealFor;
  String mealType;
  String cuisineType;
  String price;
  String subscriptionOrderPriorTiming;
  String description;
  String provideCustomization;
  String weekly;
  String monthly;
  String includingSaturday;
  String includingSunday;
  List<DeliveryTime> deliveryTime;
  List<PackageDetail> packageDetail;

  PackageDetailsData({
    required this.kitchenId,
    required this.packageId,
    required this.packageName,
    required this.mealFor,
    required this.mealType,
    required this.cuisineType,
    required this.price,
    required this.subscriptionOrderPriorTiming,
    required this.description,
    required this.provideCustomization,
    required this.weekly,
    required this.monthly,
    required this.includingSaturday,
    required this.includingSunday,
    required this.deliveryTime,
    required this.packageDetail,
  });

  factory PackageDetailsData.fromJson(Map<String, dynamic> json) =>
      PackageDetailsData(
        kitchenId: json["kitchen_id"],
        packageId: json["package_id"],
        packageName: json["package_name"],
        mealFor: json["mealfor"],
        mealType: json["mealtype"],
        cuisineType: json["cuisinetype"],
        price: json["price"],
        subscriptionOrderPriorTiming: json["subscription_order_prior_timing"],
        description: json["description"],
        provideCustomization: json["provide_customization"],
        weekly: json["weekly"],
        monthly: json["monthly"],
        includingSaturday: json["including_saturday"],
        includingSunday: json["including_sunday"],
        deliveryTime: List<DeliveryTime>.from(
            json["delivery_time"].map((x) => DeliveryTime.fromJson(x))),
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
    "subscription_order_prior_timing": subscriptionOrderPriorTiming,
    "description": description,
    "provide_customization": provideCustomization,
    "weekly": weekly,
    "monthly": monthly,
    "including_saturday": includingSaturday,
    "including_sunday": includingSunday,
    "delivery_time":
    List<dynamic>.from(deliveryTime.map((x) => x.toJson())),
    "package_detail":
    List<dynamic>.from(packageDetail.map((x) => x.toJson())),
  };
}

class DeliveryTime {
  String fromTime;
  String toTime;
  String time;

  DeliveryTime({
    required this.fromTime,
    required this.toTime,
    required this.time,
  });

  factory DeliveryTime.fromJson(Map<String, dynamic> json) => DeliveryTime(
    fromTime: json["from_time"],
    toTime: json["to_time"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "from_time": fromTime,
    "to_time": toTime,
    "time": time,
  };
}

class PackageDetail {
  String weeklyPackageId;
  String days;
  String daysName;
  String itemName;
  final String weeklyMealPrice;
  final String monthlyMealPrice;
  List<MenuItem> menuItem;

  PackageDetail({
    required this.weeklyPackageId,
    required this.days,
    required this.daysName,
    required this.weeklyMealPrice,
    required this.monthlyMealPrice,
    required this.itemName,
    required this.menuItem,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
    weeklyPackageId: json["weekly_package_id"],
    days: json["days"],
    daysName: json["days_name"],
    itemName: json["item_name"],
    weeklyMealPrice: json["weekly_meal_price"],
    monthlyMealPrice: json["monthly_meal_price"],
    menuItem: List<MenuItem>.from(
        json["menu_item"].map((x) => MenuItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "weekly_package_id": weeklyPackageId,
    "days": days,
    "days_name": daysName,
    "item_name": itemName,
    "weekly_meal_price": weeklyMealPrice,
    "monthly_meal_price": monthlyMealPrice,
    "menu_item": List<dynamic>.from(menuItem.map((x) => x.toJson())),
  };
}

class MenuItem {
  String category;
  List<MenuItemData> menuItems;

  MenuItem({
    required this.category,
    required this.menuItems,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
    category: json["category"],
    menuItems: List<MenuItemData>.from(
        json["menuitems"].map((x) => MenuItemData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "menuitems": List<dynamic>.from(menuItems.map((x) => x.toJson())),
  };
}

class MenuItemData {
  String itemId;
  String itemName;
  String itemQty;
  String itemPrice;

  MenuItemData({
    required this.itemId,
    required this.itemName,
    required this.itemQty,
    required this.itemPrice,
  });

  factory MenuItemData.fromJson(Map<String, dynamic> json) => MenuItemData(
    itemId: json["item_id"],
    itemName: json["item_name"],
    itemQty: json["item_qty"],
    itemPrice: json["item_price"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_name": itemName,
    "item_qty": itemQty,
    "item_price": itemPrice,
  };
}
