
class GetOfflineDates {
  bool status;
  String message;
  List<OfflineDates> data;

  GetOfflineDates({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetOfflineDates.fromJson(Map<String, dynamic> json) => GetOfflineDates(
    status: json["status"],
    message: json["message"],
    data: List<OfflineDates>.from(json["data"].map((x) => OfflineDates.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OfflineDates {
  DateTime date;

  OfflineDates({
    required this.date,
  });

  factory OfflineDates.fromJson(Map<String, dynamic> json) => OfflineDates(
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
