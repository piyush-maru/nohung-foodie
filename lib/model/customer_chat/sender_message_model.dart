

class ChatSenderModel {
  bool status;
  String message;
  Data data;

  ChatSenderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChatSenderModel.fromJson(Map<String, dynamic> json) => ChatSenderModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String msgType;
  String userid;
  String message;
  DateTime createddate;

  Data({
    required this.msgType,
    required this.userid,
    required this.message,
    required this.createddate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    msgType: json["msg_type"],
    userid: json["userid"],
    message: json["message"],
    createddate: DateTime.parse(json["createddate"]),
  );

  Map<String, dynamic> toJson() => {
    "msg_type": msgType,
    "userid": userid,
    "message": message,
    "createddate": createddate.toIso8601String(),
  };
}
