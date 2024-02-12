class GetPreOrderTime {
  bool status;
  String message;
  List<PreOrderTime> data;

  GetPreOrderTime({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetPreOrderTime.fromJson(Map<String, dynamic> json) =>
      GetPreOrderTime(
        status: json["status"],
        message: json["message"],
        data: List<PreOrderTime>.from(
            json["data"].map((x) => PreOrderTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PreOrderTime {
  String value;
  String text;
  final int? isWithin60Minute;

  PreOrderTime({
    required this.value,
    required this.text,
    this.isWithin60Minute,
  });

  factory PreOrderTime.fromJson(Map<String, dynamic> json) => PreOrderTime(
        value: json["value"],
        text: json["text"],
        isWithin60Minute: json["is_within_60_minute"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
        "is_within_60_minute": isWithin60Minute,
      };
}
