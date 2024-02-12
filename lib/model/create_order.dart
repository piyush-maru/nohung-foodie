class CreateOrder {
  bool? status;
  String? message;

  CreateOrder({
    this.status,
    this.message,
  });

  CreateOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;

    return data;
  }
}

class Transaction {
  Transaction({
    required this.transactionId,
  });

  String transactionId;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        transactionId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": transactionId,
      };
}
