class GetOrderHistory {
  final bool? status;
  final String? message;
  final Data? data;

  GetOrderHistory({
    this.status,
    this.message,
    this.data,
  });

  factory GetOrderHistory.fromJson(Map<String, dynamic> json) =>
      GetOrderHistory(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? totalPages;
  final List<Order>? orders;

  Data({
    this.totalPages,
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalPages: json["total_pages"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  final String? orderId;
  final String? kitchenId;
  final String? kitchenname;
  final String? ordernumber;
  final String? orderfrom;
  final String? orderOf;
  final String? totalbill;
  final String? ordertype;
  final String? mealFor;
  final String? mealType;
  final String? cuisineType;
  final List<PackageDetail>? packageDetail;
  final String? createddate;
  final DateTime? orderdate;
  final DateTime? enddate;
  final String? netamount;
  String? favoriteOrder;
  final String? status;
  final String? paymentStatus;
  final String? isActive;
  final String? isComplete;
  final int? isReview;
  final ReviewDetail? reviewDetail;
  final dynamic orderNowDeliveryDate;
  final List<TrialOrder>? trialOrders;

  Order({
    this.orderId,
    this.kitchenId,
    this.kitchenname,
    this.ordernumber,
    this.orderfrom,
    this.orderOf,
    this.totalbill,
    this.ordertype,
    this.mealFor,
    this.mealType,
    this.cuisineType,
    this.packageDetail,
    this.createddate,
    this.orderdate,
    this.enddate,
    this.netamount,
    this.favoriteOrder,
    this.status,
    this.paymentStatus,
    this.isActive,
    this.isComplete,
    this.isReview,
    this.reviewDetail,
    this.orderNowDeliveryDate,
    this.trialOrders,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        kitchenId: json["kitchen_id"],
        kitchenname: json["kitchenname"],
        ordernumber: json["ordernumber"],
        orderfrom: json["orderfrom"],
        orderOf: json["order_of"],
        totalbill: json["totalbill"],
        ordertype: json["ordertype"],
        mealFor: json["meal_for"],
        mealType: json["meal_type"],
        cuisineType: json["cuisine_type"],
        packageDetail: json["package_detail"] == null
            ? []
            : List<PackageDetail>.from(
                json["package_detail"]!.map((x) => PackageDetail.fromJson(x))),
        createddate: json["createddate"],
        orderdate: json["orderdate"] == null
            ? null
            : DateTime.parse(json["orderdate"]),
        enddate:
            json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        netamount: json["netamount"],
        favoriteOrder: json["favorite_order"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        isActive: json["is_active"],
        isComplete: json["is_complete"],
        isReview: json["is_review"],
        reviewDetail: json["review_detail"] == null
            ? null
            : ReviewDetail.fromJson(json["review_detail"]),
        orderNowDeliveryDate: json["order_now_delivery_date"],
        trialOrders: json["trial_orders"] == null
            ? []
            : List<TrialOrder>.from(
                json["trial_orders"]!.map((x) => TrialOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "kitchen_id": kitchenId,
        "kitchenname": kitchenname,
        "ordernumber": ordernumber,
        "orderfrom": orderfrom,
        "order_of": orderOf,
        "totalbill": totalbill,
        "ordertype": ordertype,
        "meal_for": mealFor,
        "meal_type": mealType,
        "cuisine_type": cuisineType,
        "package_detail": packageDetail == null
            ? []
            : List<dynamic>.from(packageDetail!.map((x) => x.toJson())),
        "createddate": createddate,
        "orderdate":
            "${orderdate!.year.toString().padLeft(4, '0')}-${orderdate!.month.toString().padLeft(2, '0')}-${orderdate!.day.toString().padLeft(2, '0')}",
        "enddate":
            "${enddate!.year.toString().padLeft(4, '0')}-${enddate!.month.toString().padLeft(2, '0')}-${enddate!.day.toString().padLeft(2, '0')}",
        "netamount": netamount,
        "favorite_order": favoriteOrder,
        "status": status,
        "payment_status": paymentStatus,
        "is_active": isActive,
        "is_complete": isComplete,
        "is_review": isReview,
        "review_detail": reviewDetail?.toJson(),
        "order_now_delivery_date": orderNowDeliveryDate,
        "trial_orders": trialOrders == null
            ? []
            : List<dynamic>.from(trialOrders!.map((x) => x.toJson())),
      };
}

class OrderNowDeliveryDateClass {
  final String? date;
  final String? fromTime;
  final String? toTime;

  OrderNowDeliveryDateClass({
    this.date,
    this.fromTime,
    this.toTime,
  });

  factory OrderNowDeliveryDateClass.fromJson(Map<String, dynamic> json) =>
      OrderNowDeliveryDateClass(
        date: json["date"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "from_time": fromTime,
        "to_time": toTime,
      };
}

class PackageDetail {
  final String? id;
  final String? itemName;
  final String? menu;
  final String? cuisine;
  final DateTime? startdate;
  final DateTime? enddate;
  final String? mealplan;
  final String? referenceId;
  final String? cuisinetype;
  final String? mealtype;
  final List<DailyPkgDetail>? dailyPkgDetail;

  PackageDetail({
    this.id,
    this.itemName,
    this.menu,
    this.cuisine,
    this.startdate,
    this.enddate,
    this.mealplan,
    this.referenceId,
    this.cuisinetype,
    this.mealtype,
    this.dailyPkgDetail,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        id: json["id"],
        itemName: json["item_name"],
        menu: json["menu"],
        cuisine: json["cuisine"],
        startdate: json["startdate"] == null
            ? null
            : DateTime.parse(json["startdate"]),
        enddate:
            json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        mealplan: json["mealplan"],
        referenceId: json["reference_id"],
        cuisinetype: json["cuisinetype"],
        mealtype: json["mealtype"],
        dailyPkgDetail: json["daily_pkg_detail"] == null
            ? []
            : List<DailyPkgDetail>.from(json["daily_pkg_detail"]!
                .map((x) => DailyPkgDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "menu": menu,
        "cuisine": cuisine,
        "startdate":
            "${startdate!.year.toString().padLeft(4, '0')}-${startdate!.month.toString().padLeft(2, '0')}-${startdate!.day.toString().padLeft(2, '0')}",
        "enddate":
            "${enddate!.year.toString().padLeft(4, '0')}-${enddate!.month.toString().padLeft(2, '0')}-${enddate!.day.toString().padLeft(2, '0')}",
        "mealplan": mealplan,
        "reference_id": referenceId,
        "cuisinetype": cuisinetype,
        "mealtype": mealtype,
        "daily_pkg_detail": dailyPkgDetail == null
            ? []
            : List<dynamic>.from(dailyPkgDetail!.map((x) => x.toJson())),
      };
}

class DailyPkgDetail {
  final String? id;
  final String? orderId;
  final DateTime? deliveryDate;
  final String? deliveryFromtime;
  final String? deliveryTotime;
  final String? status;
  final String? totalAmount;
  final String? paymentStatus;
  final String? dishItem;
  final String? isDivert;
  final String? divertOrderId;

  DailyPkgDetail({
    this.id,
    this.orderId,
    this.deliveryDate,
    this.deliveryFromtime,
    this.deliveryTotime,
    this.status,
    this.totalAmount,
    this.paymentStatus,
    this.dishItem,
    this.isDivert,
    this.divertOrderId,
  });

  factory DailyPkgDetail.fromJson(Map<String, dynamic> json) => DailyPkgDetail(
        id: json["id"],
        orderId: json["order_id"],
        deliveryDate: json["delivery_date"] == null
            ? null
            : DateTime.parse(json["delivery_date"]),
        deliveryFromtime: json["delivery_fromtime"],
        deliveryTotime: json["delivery_totime"],
        status: json["status"],
        totalAmount: json["total_amount"],
        paymentStatus: json["payment_status"],
        dishItem: json["dish_item"],
        isDivert: json["is_divert"],
        divertOrderId: json["divert_order_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "delivery_date":
            "${deliveryDate!.year.toString().padLeft(4, '0')}-${deliveryDate!.month.toString().padLeft(2, '0')}-${deliveryDate!.day.toString().padLeft(2, '0')}",
        "delivery_fromtime": deliveryFromtime,
        "delivery_totime": deliveryTotime,
        "status": status,
        "total_amount": totalAmount,
        "payment_status": paymentStatus,
        "dish_item": dishItem,
        "is_divert": isDivert,
        "divert_order_id": divertOrderId,
      };
}

class ReviewDetail {
  final String? rating;
  final String? reviewMessage;
  final String? foodquality;
  final String? taste;
  final String? quantity;

  ReviewDetail({
    this.rating,
    this.reviewMessage,
    this.foodquality,
    this.taste,
    this.quantity,
  });

  factory ReviewDetail.fromJson(Map<String, dynamic> json) => ReviewDetail(
        rating: json["rating"],
        reviewMessage: json["review_message"],
        foodquality: json["foodquality"],
        taste: json["taste"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "review_message": reviewMessage,
        "foodquality": foodquality,
        "taste": taste,
        "quantity": quantity,
      };
}

class TrialOrder {
  final String? mealtype;
  final String? menu;
  final String? itemName;
  final String? cuisine;
  final String? cuisinetype;

  TrialOrder({
    this.mealtype,
    this.menu,
    this.itemName,
    this.cuisine,
    this.cuisinetype,
  });

  factory TrialOrder.fromJson(Map<String, dynamic> json) => TrialOrder(
        mealtype: json["mealtype"],
        menu: json["menu"],
        itemName: json["item_name"],
        cuisine: json["cuisine"],
        cuisinetype: json["cuisinetype"],
      );

  Map<String, dynamic> toJson() => {
        "mealtype": mealtype,
        "menu": menu,
        "item_name": itemName,
        "cuisine": cuisine,
        "cuisinetype": cuisinetype,
      };
}
