class PostponeOrderModel {
  final bool? status;
  final String? message;
  final Data? data;

  PostponeOrderModel({
    this.status,
    this.message,
    this.data,
  });

  factory PostponeOrderModel.fromJson(Map<String, dynamic> json) =>
      PostponeOrderModel(
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
  final String? wallet;
  final String? orderId;
  final String? orderNumber;
  final double? netamount;
  final double? payAmount;
  final String? customerName;
  final String? customerEmail;
  final String? customerMobileno;
  final String? transactionId;

  Data({
    this.wallet,
    this.orderId,
    this.orderNumber,
    this.netamount,
    this.payAmount,
    this.customerName,
    this.customerEmail,
    this.customerMobileno,
    this.transactionId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallet: json["wallet"],
        orderId: json["order_id"],
        orderNumber: json["order_number"],
        netamount: json["netamount"]?.toDouble(),
        payAmount: json["pay_amount"]?.toDouble(),
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerMobileno: json["customer_mobileno"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "wallet": wallet,
        "order_id": orderId,
        "order_number": orderNumber,
        "netamount": netamount,
        "pay_amount": payAmount,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_mobileno": customerMobileno,
        "transaction_id": transactionId,
      };
}
