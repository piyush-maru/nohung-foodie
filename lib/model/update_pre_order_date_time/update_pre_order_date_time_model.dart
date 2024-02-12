class UpdatePreOrderDateTime {
  final bool? status;
  final String? message;
  final List? data;

  UpdatePreOrderDateTime({
    this.status,
    this.message,
    this.data,
  });

  factory UpdatePreOrderDateTime.fromJson(Map<String, dynamic> json) =>
      UpdatePreOrderDateTime(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
      };
}
