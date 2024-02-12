
class TransactionModel {
  TransactionModel({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}