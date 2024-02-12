
class GetUserAddressDetails {
  GetUserAddressDetails({
    required this.status,
    required this.message,
    required this.details,
  });

  bool? status;
  String? message;
  List<UserAddressDetails>? details;

  GetUserAddressDetails.fromJson(Map<String, dynamic> json) {
    status =json["status"];
    message = json["message"];
     if (json['data'] != null) {
      details = [];
     json['data'].forEach((v) {
        details?.add(UserAddressDetails.fromJson(v));
      });
    }
    //data: UserAddressDetails.fromJson(json["data"]),
  }
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["message"] = message;
    if (details != null) {
      data['data'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserAddressDetails {
  UserAddressDetails({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
    this.isDefault,
    this.street,
    this.landmark,
    this.addressType
  });

  String? id;
  String? address;
  String? latitude;
  String? longitude;
  String? isDefault;
  String? street;
  String? landmark;
  String? addressType;


  factory UserAddressDetails.fromJson(Map<String, dynamic> json) => UserAddressDetails(
    id: json['id'],
    address:json['address'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    isDefault: json['is_default'],
    street: json['street'],
    landmark: json['landmark'],
    addressType: json['address_type']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_default'] = isDefault;
    data['street'] = street;
    data['landmark'] = landmark;
    data['address_type'] = addressType;
    return data;
  }
}
