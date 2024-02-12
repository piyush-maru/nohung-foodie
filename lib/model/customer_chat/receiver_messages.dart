

class ChatReceiverModel {
  bool status;
  String message;
  List<Datum> data;

  ChatReceiverModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChatReceiverModel.fromJson(Map<String, dynamic> json) => ChatReceiverModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  DateTime createdDate;
  String time;
  String msgType;
  String message;

  Datum({
    required this.createdDate,
    required this.time,
    required this.msgType,
    required this.message,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    createdDate: DateTime.parse(json["createddate"]),
    time: json["time"],
    msgType: json["msg_type"]!,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "createddate": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
    "time": time,
    "msg_type": msgType,
    "message": message,
  };
}

