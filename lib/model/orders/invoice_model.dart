class InvoiceModelClass {
  bool status;
  String message;
  List<InvoiceData> data;

  InvoiceModelClass({
    required this.status,
    required this.message,
    required this.data,
  });

  factory InvoiceModelClass.fromJson(Map<String, dynamic> json) => InvoiceModelClass(
    status: json["status"],
    message: json["message"],
    data: List<InvoiceData>.from(json["data"].map((x) => InvoiceData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class InvoiceData {
  String orderId;
  String orderNumber;
  DateTime orderTime;
  String customerName;
  String subscriptionPeriod;
  String deliveryAddress;
  String kitchenName;
  String kitchenAddress;
  String paymentMode;
  String itemName;
  String itemQuantity;
  String unitPrice;
  String subTotal;
  String taxAmount;
  String deliveryCharge;
  String couponDiscount;
  String packagingCharges;
  String total;

  InvoiceData({
    required this.orderId,
    required this.orderNumber,
    required this.orderTime,
    required this.customerName,
    required this.subscriptionPeriod,
    required this.deliveryAddress,
    required this.kitchenName,
    required this.kitchenAddress,
    required this.paymentMode,
    required this.itemName,
    required this.itemQuantity,
    required this.unitPrice,
    required this.subTotal,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.couponDiscount,
    required this.packagingCharges,
    required this.total,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
    orderId: json["order_id"],
    orderNumber: json["order_number"],
    orderTime: DateTime.parse(json["order_time"]),
    customerName: json["customer_name"],
    subscriptionPeriod: json["subscription_period"],
    deliveryAddress: json["deliveryaddress"],
    kitchenName: json["kitchen_name"],
    kitchenAddress: json["kitchen_address"],
    paymentMode: json["payment_mode"],
    itemName: json["item_name"],
    itemQuantity: json["item_quantity"],
    unitPrice: json["unit_price"],
    subTotal: json["sub_total"],
    taxAmount: json["tax_amount"],
    deliveryCharge: json["delivery_charge"],
    couponDiscount: json["coupon_discount"],
    packagingCharges: json["packaging_charges"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "order_number": orderNumber,
    "order_time": orderTime.toIso8601String(),
    "customer_name": customerName,
    "subscription_period": subscriptionPeriod,
    "deliveryaddress": deliveryAddress,
    "kitchen_name": kitchenName,
    "kitchen_address": kitchenAddress,
    "payment_mode": paymentMode,
    "item_name": itemName,
    "item_quantity": itemQuantity,
    "unit_price": unitPrice,
    "sub_total": subTotal,
    "tax_amount": taxAmount,
    "delivery_charge": deliveryCharge,
    "coupon_discount": couponDiscount,
    "packaging_charges": packagingCharges,
    "total": total,
  };
}
