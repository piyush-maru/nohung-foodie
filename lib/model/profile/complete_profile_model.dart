class CompleteProfile {
  CompleteProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Map<String, String> data;

  factory CompleteProfile.fromJson(Map<String, dynamic> json) => CompleteProfile(
    status: json["status"],
    message: json["message"],
    data: Map.from(json["data"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
