class GetActiveOrders {
  bool status;
  String message;
  List<ActiveOrdersData> data;

  GetActiveOrders({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetActiveOrders.fromJson(Map<String, dynamic> json) =>
      GetActiveOrders(
        status: json["status"],
        message: json["message"],
        data: List<ActiveOrdersData>.from(
            json["data"].map((x) => ActiveOrdersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ActiveOrdersData {
  final String? id;
  final String? kitchenname;
  final String? address;
  final String? orderid;
  final String? ordertype;
  final String? orderamount;
  final String? createddate;
  final DateTime? orderdate;
  final String? netamount;
  final String? review;
  final String? reviewDescription;
  final String? status;
  final String? paymentStatus;
  final String? orderNowDeliveryDate;
  final String? orderNowDeliveryFromTime;
  final String? orderNowDeliveryToTime;
  final String? fromdate;
  final String? todate;
  String? favoriteOrder;
  final String? orderOn;
  final List<PackageDetail>? packageDetail;
  final List<TrialOrder>? trialOrders;
  final String? orderfrom;
  final String? orderItems;

  ActiveOrdersData({
    this.id,
    this.kitchenname,
    this.address,
    this.orderid,
    this.ordertype,
    this.orderamount,
    this.createddate,
    this.orderdate,
    this.netamount,
    this.review,
    this.reviewDescription,
    this.status,
    this.paymentStatus,
    this.orderNowDeliveryDate,
    this.orderNowDeliveryFromTime,
    this.orderNowDeliveryToTime,
    this.fromdate,
    this.todate,
    this.favoriteOrder,
    this.orderOn,
    this.packageDetail,
    this.trialOrders,
    this.orderfrom,
    this.orderItems,
  });

  factory ActiveOrdersData.fromJson(Map<String, dynamic> json) =>
      ActiveOrdersData(
        id: json["id"],
        kitchenname: json["kitchenname"],
        address: json["address"],
        orderid: json["orderid"],
        ordertype: json["ordertype"],
        orderamount: json["orderamount"],
        createddate: json["createddate"],
        orderdate: json["orderdate"] == null
            ? null
            : DateTime.parse(json["orderdate"]),
        netamount: json["netamount"],
        review: json["review"],
        reviewDescription: json["review_description"],
        status: json["status"],
        paymentStatus: json["payment_status"],
        orderNowDeliveryDate: json["order_now_delivery_date"],
        orderNowDeliveryFromTime: json["order_now_delivery_from_time"],
        orderNowDeliveryToTime: json["order_now_delivery_to_time"],
        fromdate: json["fromdate"],
        todate: json["todate"],
        favoriteOrder: json["favorite_order"],
        orderOn: json["order_on"],
        packageDetail: json["package_detail"] == null
            ? []
            : List<PackageDetail>.from(
                json["package_detail"]!.map((x) => PackageDetail.fromJson(x))),
        trialOrders: json["trial_orders"] == null
            ? []
            : List<TrialOrder>.from(
                json["trial_orders"]!.map((x) => TrialOrder.fromJson(x))),
        orderfrom: json["orderfrom"],
        orderItems: json["order_items"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kitchenname": kitchenname,
        "address": address,
        "orderid": orderid,
        "ordertype": ordertype,
        "orderamount": orderamount,
        "createddate": createddate,
        "orderdate":
            "${orderdate!.year.toString().padLeft(4, '0')}-${orderdate!.month.toString().padLeft(2, '0')}-${orderdate!.day.toString().padLeft(2, '0')}",
        "netamount": netamount,
        "review": review,
        "review_description": reviewDescription,
        "status": status,
        "payment_status": paymentStatus,
        "order_now_delivery_date": orderNowDeliveryDate,
        "order_now_delivery_from_time": orderNowDeliveryFromTime,
        "order_now_delivery_to_time": orderNowDeliveryToTime,
        "fromdate": fromdate,
        "todate": todate,
        "favorite_order": favoriteOrder,
        "order_on": orderOn,
        "package_detail": packageDetail == null
            ? []
            : List<dynamic>.from(packageDetail!.map((x) => x.toJson())),
        "trial_orders": trialOrders == null
            ? []
            : List<dynamic>.from(trialOrders!.map((x) => x.toJson())),
        "orderfrom": orderfrom,
        "order_items": orderItems,
      };
}

class PackageDetail {
  final String? id;
  final String? itemName;
  final String? mealtype;
  final String? menu;
  final String? cuisine;
  final DateTime? startdate;
  final DateTime? enddate;
  final String? mealplan;
  final String? referenceId;
  final List<DailyPkgDetail>? dailyPkgDetail;

  PackageDetail({
    this.id,
    this.itemName,
    this.mealtype,
    this.menu,
    this.cuisine,
    this.startdate,
    this.enddate,
    this.mealplan,
    this.referenceId,
    this.dailyPkgDetail,
  });

  factory PackageDetail.fromJson(Map<String, dynamic> json) => PackageDetail(
        id: json["id"],
        itemName: json["item_name"],
        mealtype: json["mealtype"],
        menu: json["menu"],
        cuisine: json["cuisine"],
        startdate: json["startdate"] == null
            ? null
            : DateTime.parse(json["startdate"]),
        enddate:
            json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        mealplan: json["mealplan"],
        referenceId: json["reference_id"],
        dailyPkgDetail: json["daily_pkg_detail"] == null
            ? []
            : List<DailyPkgDetail>.from(json["daily_pkg_detail"]!
                .map((x) => DailyPkgDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "mealtype": mealtype,
        "menu": menu,
        "cuisine": cuisine,
        "startdate":
            "${startdate!.year.toString().padLeft(4, '0')}-${startdate!.month.toString().padLeft(2, '0')}-${startdate!.day.toString().padLeft(2, '0')}",
        "enddate":
            "${enddate!.year.toString().padLeft(4, '0')}-${enddate!.month.toString().padLeft(2, '0')}-${enddate!.day.toString().padLeft(2, '0')}",
        "mealplan": mealplan,
        "reference_id": referenceId,
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
 // final String? isDivert;
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
   // this.isDivert,
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
        //isDivert: json["is_divert"],
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
       // "is_divert": isDivert,
        "divert_order_id": divertOrderId,
      };
}






class TrialOrder {
  final String? mealtype;
  final String? menu;
  final String? itemName;
  final String? cuisine;

  TrialOrder({
    this.mealtype,
    this.menu,
    this.itemName,
    this.cuisine,
  });

  factory TrialOrder.fromJson(Map<String, dynamic> json) => TrialOrder(
        mealtype: json["mealtype"],
        menu: json["menu"],
        itemName: json["item_name"],
        cuisine: json["cuisine"],
      );

  Map<String, dynamic> toJson() => {
        "mealtype": mealtype,
        "menu": menu,
        "item_name": itemName,
        "cuisine": cuisine,
      };
}
