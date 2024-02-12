class FavOrdersClass {
  FavOrdersClass({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<FavOrdersData?>? data;

  factory FavOrdersClass.fromJson(Map<String, dynamic> json) => FavOrdersClass(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<FavOrdersData?>.from(
                json["data"]!.map((x) => FavOrdersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class FavOrdersData {
  FavOrdersData({
    this.id,
    this.kitchenId,
    this.kitchenName,
    this.profile_pic,
    this.orderId,
    this.orderItems,
    this.address,
    this.orderType,
    this.packageDetail,
    this.createdDate,
    this.orderDate,
    this.endDate,
    this.netAmount,
    this.favoriteOrder,
    this.status,
    this.paymentStatus,
    this.review,
    this.trialOrders,
  });

  String? id;
  String? kitchenId;
  String? kitchenName;
  String? profile_pic;
  String? orderId;
  String? orderItems;
  String? address;
  String? orderType;
  List<PackageDetail?>? packageDetail;
  DateTime? createdDate;
  DateTime? orderDate;
  DateTime? endDate;
  String? netAmount;
  String? favoriteOrder;
  String? status;
  String? paymentStatus;
  String? review;
  List<TrialOrder?>? trialOrders;

  factory FavOrdersData.fromJson(Map<String, dynamic> json) => FavOrdersData(
        id: json["id"],
        kitchenId: json["kitchen_id"],
        kitchenName: json["kitchenname"],
        profile_pic: json["profile_pic"],
        orderId: json["orderid"],
        orderItems: json["order_items"],
        address: json["address"],
        orderType: json["ordertype"],
        packageDetail: json["package_detail"] == null
            ? []
            : List<PackageDetail?>.from(
                json["package_detail"]!.map((x) => PackageDetail.fromJson(x))),
        createdDate: DateTime.parse(json["createddate"]),
        orderDate: DateTime.parse(json["orderdate"]),
        endDate: DateTime.parse(json["enddate"]),
        netAmount: json["netamount"],
        favoriteOrder: json["favorite_order"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        review: json["review"],
        trialOrders: json["trial_orders"] == null
            ? []
            : List<TrialOrder?>.from(
                json["trial_orders"]!.map((x) => TrialOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kitchen_id": kitchenId,
        "kitchenname": kitchenName,
        "profile_pic": profile_pic,
        "orderid": orderId,
        "order_items": orderItems,
        "address": address,
        "ordertype": orderType,
        "package_detail": packageDetail == null
            ? []
            : List<dynamic>.from(packageDetail!.map((x) => x!.toJson())),
        "createddate": createdDate?.toIso8601String(),
        "orderdate":
            "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "enddate":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "netamount": netAmount,
        "favorite_order": favoriteOrder,
        "status": status,
        "payment_status": paymentStatus,
        "review": review,
        "trial_orders": trialOrders == null
            ? []
            : List<dynamic>.from(trialOrders!.map((x) => x!.toJson())),
      };
}

class PackageDetail {
  PackageDetail({
    this.id,
    this.itemName,
    this.mealType,
    this.menu,
    this.cuisine,
    this.startDate,
    this.endDate,
    this.mealPlan,
    this.referenceId,
    this.dailyPkgDetail,
  });

  String? id;
  String? itemName;
  String? mealType;
  String? menu;
  String? cuisine;
  DateTime? startDate;
  DateTime? endDate;
  String? mealPlan;
  String? referenceId;
  List<DailyPkgDetail?>? dailyPkgDetail;

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        id: json["id"],
        itemName: json["item_name"],
        mealType: json["mealtype"],
        menu: json["menu"],
        cuisine: json["cuisine"],
        startDate: DateTime.parse(json["startdate"]),
        endDate: DateTime.parse(json["enddate"]),
        mealPlan: json["mealplan"],
        referenceId: json["reference_id"],
        dailyPkgDetail: json["daily_pkg_detail"] == null
            ? []
            : List<DailyPkgDetail?>.from(json["daily_pkg_detail"]!
                .map((x) => DailyPkgDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "mealtype": mealType,
        "menu": menu,
        "cuisine": cuisine,
        "startdate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "enddate":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "mealplan": mealPlan,
        "reference_id": referenceId,
        "daily_pkg_detail": dailyPkgDetail == null
            ? []
            : List<dynamic>.from(dailyPkgDetail!.map((x) => x!.toJson())),
      };
}

class DailyPkgDetail {
  DailyPkgDetail({
    this.deliveryDate,
    this.deliveryFromTime,
    this.deliveryToTime,
    this.status,
    this.totalAmount,
    this.id,
    this.paymentStatus,
    this.dishItem,
  });

  DateTime? deliveryDate;
  String? deliveryFromTime;
  String? deliveryToTime;
  String? status;
  String? totalAmount;
  String? id;
  String? paymentStatus;
  String? dishItem;

  factory DailyPkgDetail.fromJson(Map<String, dynamic> json) => DailyPkgDetail(
        deliveryDate: DateTime.parse(json["delivery_date"]),
        deliveryFromTime: json["delivery_fromtime"],
        deliveryToTime: json["delivery_totime"],
        status: json["status"],
        totalAmount: json["total_amount"],
        id: json["id"],
        paymentStatus: json["payment_status"],
        dishItem: json["dish_item"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "delivery_fromtime": deliveryFromTime,
        "delivery_totime": deliveryToTime,
        "status": status,
        "total_amount": totalAmount,
        "id": id,
        "payment_status": paymentStatus,
        "dish_item": dishItem,
      };
}

class TrialOrder {
  TrialOrder({
    this.mealType,
    this.menu,
    this.itemName,
    this.cuisine,
  });

  String? mealType;
  String? menu;
  String? itemName;
  String? cuisine;

  factory TrialOrder.fromJson(Map<String, dynamic> json) => TrialOrder(
        mealType: json["mealtype"],
        menu: json["menu"],
        itemName: json["item_name"],
        cuisine: json["cuisine"],
      );

  Map<String, dynamic> toJson() => {
        "mealtype": mealType,
        "menu": menu,
        "item_name": itemName,
        "cuisine": cuisine,
      };
}
