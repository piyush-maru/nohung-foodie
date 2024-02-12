class AddOrderResponse {
  final bool? status;
  final String? message;
  final Data? data;

  AddOrderResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AddOrderResponse.fromJson(Map<String, dynamic> json) =>
      AddOrderResponse(
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
  final int? type;
  final String? msg;
  final String? netamount;
  final String? customerName;
  final String? customerMobileno;
  final String? transactionId;

  Data({
    this.type,
    this.msg,
    this.netamount,
    this.customerName,
    this.customerMobileno,
    this.transactionId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        msg: json["msg"],
        netamount: json["netamount"],
        customerName: json["customer_name"],
        customerMobileno: json["customer_mobileno"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "msg": msg,
        "netamount": netamount,
        "customer_name": customerName,
        "customer_mobileno": customerMobileno,
        "transaction_id": transactionId,
      };
}
