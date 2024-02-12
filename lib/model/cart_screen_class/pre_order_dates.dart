class GetPreOrderDates {
  bool status;
  String message;
  List<PreOrderDates> data;

  GetPreOrderDates({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetPreOrderDates.fromJson(Map<String, dynamic> json) =>
      GetPreOrderDates(
        status: json["status"],
        message: json["message"],
        data: List<PreOrderDates>.from(
            json["data"].map((x) => PreOrderDates.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PreOrderDates {
  String date;
  String formattedDate;

  PreOrderDates({
    required this.date,
    required this.formattedDate,
  });

  factory PreOrderDates.fromJson(Map<String, dynamic> json) => PreOrderDates(
        date: json["date"],
        formattedDate: json["formatted_date"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "formatted_date": formattedDate,
      };
}
