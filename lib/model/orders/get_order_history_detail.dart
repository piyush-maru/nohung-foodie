class GetOrderHistoryDetail {
  bool status;
  String message;
  final OrderDetailsModel? data;

  GetOrderHistoryDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetOrderHistoryDetail.fromJson(Map<String, dynamic> json) =>
      GetOrderHistoryDetail(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : OrderDetailsModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    "data": data?.toJson(),
      };
}

/*class OrderDetailsModel {
  String? orderId;
  String? orderItemsId;
  String? kitchenId;
  String? kitchenName;
  String? orderType;
  String? mealFor;
  String? mealType;
  String? cuisineType;
  String? referenceId;
  String? itemName;
  String? image;
  String? day;
  DateTime? date;
  OrderDate? orderDate;
  String? status;
  String? itemStatus;
  String? dishItem;
  String? deliveryAddress;
  String? deliveryFromTime;
  String? deliveryToTime;
  dynamic description;
  String? totalAmount;

  OrderDetailsModel({
    this.orderId,
    this.orderItemsId,
    this.kitchenId,
    this.kitchenName,
    this.orderType,
    this.mealFor,
    this.mealType,
    this.cuisineType,
    this.referenceId,
    this.itemName,
    this.image,
    this.day,
    this.date,
    this.orderDate,
    this.status,
    this.itemStatus,
    this.dishItem,
    this.deliveryAddress,
    this.deliveryFromTime,
    this.deliveryToTime,
    this.description,
    this.totalAmount,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        orderId: json["order_id"],
        orderItemsId: json["orderitems_id"],
        kitchenId: json["kitchen_id"],
        kitchenName: json["kitchenname"],
        orderType: json["order_type"],
        mealFor: json["meal_for"],
        mealType: json["meal_type"],
        cuisineType: json["cuisine_type"],
        referenceId: json["reference_id"],
        itemName: json["item_name"],
        image: json["image"],
        day: json["day"],
        date: DateTime.parse(json["date"]),
        orderDate: OrderDate.fromJson(json["order_date"]),
        status: json["status"],
        itemStatus: json["item_status"],
        dishItem: json["dish_item"],
        deliveryAddress: json["delivery_address"],
        deliveryFromTime: json["delivery_fromtime"],
        deliveryToTime: json["delivery_totime"],
        description: json["description"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "orderitems_id": orderItemsId,
        "kitchen_id": kitchenId,
        "kitchenname": kitchenName,
        "order_type": orderType,
        "meal_for": mealFor,
        "meal_type": mealType,
        "cuisine_type": cuisineType,
        "reference_id": referenceId,
        "item_name": itemName,
        "image": image,
        "day": day,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "order_date": orderDate!.toJson(),
        "status": status,
        "item_status": itemStatus,
        "dish_item": dishItem,
        "delivery_address": deliveryAddress,
        "delivery_fromtime": deliveryFromTime,
        "delivery_totime": deliveryToTime,
        "description": description,
        "total_amount": totalAmount,
      };
}

class OrderDate {
  String startDate;
  String endDate;

  OrderDate({
    required this.startDate,
    required this.endDate,
  });

  factory OrderDate.fromJson(Map<String, dynamic> json) => OrderDate(
        startDate: json["start_date"],
        endDate: json["end_date"],
      );

  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
      };
}*/

class OrderDetailsModel {
  String? orderId;
  String? kitchenId;
  String? kitchenName;
  String? packageName;
  String? packageDate;
  String? mealFor;
  String? mealType;
  String? cuisineType;
  List<Items>? items;

  OrderDetailsModel(
      {this.orderId,
        this.kitchenId,
        this.kitchenName,
        this.packageName,
        this.packageDate,
        this.mealFor,
        this.mealType,
        this.cuisineType,
        this.items});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    kitchenId = json['kitchen_id'];
    kitchenName = json['kitchen_name'];
    packageName = json['package_name'];
    packageDate = json['package_date'];
    mealFor = json['meal_for'];
    mealType = json['meal_type'];
    cuisineType = json['cuisine_type'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['kitchen_id'] = this.kitchenId;
    data['kitchen_name'] = this.kitchenName;
    data['package_name'] = this.packageName;
    data['package_date'] = this.packageDate;
    data['meal_for'] = this.mealFor;
    data['meal_type'] = this.mealType;
    data['cuisine_type'] = this.cuisineType;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? orderItemId;
  String? deliveryDate;
  String? deliveryFromtime;
  String? deliveryTotime;
  String? items;
  String? status;
  String? isDivert;

  Items(
      {this.orderItemId,
        this.deliveryDate,
        this.deliveryFromtime,
        this.deliveryTotime,
        this.items,
        this.status,
        this.isDivert});

  Items.fromJson(Map<String, dynamic> json) {
    orderItemId = json['order_item_id'];
    deliveryDate = json['delivery_date'];
    deliveryFromtime = json['delivery_fromtime'];
    deliveryTotime = json['delivery_totime'];
    items = json['items'];
    status = json['status'];
    isDivert = json['is_divert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_item_id'] = this.orderItemId;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_fromtime'] = this.deliveryFromtime;
    data['delivery_totime'] = this.deliveryTotime;
    data['items'] = this.items;
    data['status'] = this.status;
    data['is_divert'] = this.isDivert;
    return data;
  }
}

