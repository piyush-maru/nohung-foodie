import 'dart:convert';

GetAddressList getAddressListFromJson(String str) =>
    GetAddressList.fromJson(json.decode(str));

String getAddressListToJson(GetAddressList data) => json.encode(data.toJson());

class GetAddressList {
  GetAddressList({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<GetAddressListData>? data;

  factory GetAddressList.fromJson(Map<String, dynamic> json) => GetAddressList(
        status: json["status"],
        message: json["message"],
        data: List<GetAddressListData>.from(
            json["data"].map((x) => GetAddressListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetAddressListData {
  GetAddressListData({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
    this.isDefault,
  });

  String? id;
  String? address;
  String? latitude;
  String? longitude;
  String? isDefault;

  factory GetAddressListData.fromJson(Map<String, dynamic> json) =>
      GetAddressListData(
        id: json["id"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "is_default": isDefault,
      };
}
