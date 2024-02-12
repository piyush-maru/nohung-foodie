class CreateTransaction {
  bool? status;
  String? message;
  Transaction? data;

  CreateTransaction({this.status, this.message, this.data});

  CreateTransaction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
     data = json['data'] != null ?json['data'] is! List? Transaction.fromJson(json['data']):null : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
   if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
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
