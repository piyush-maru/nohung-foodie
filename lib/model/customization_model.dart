
class CustomizationModel {
  CustomizationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<DateTimeValues> data;

  factory CustomizationModel.fromJson(Map<String, dynamic> json) => CustomizationModel(
    status: json["status"],
    message: json["message"],
    data: List<DateTimeValues>.from(json["data"].map((x) => DateTimeValues.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DateTimeValues {
  DateTimeValues({
    required this.date,
    required this.dayName,
  });

  String date;
  String dayName;

  factory DateTimeValues.fromJson(Map<String, dynamic> json) => DateTimeValues(
    date: json["date"],
    dayName: json["day_name"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "day_name": dayName,
  };
}
