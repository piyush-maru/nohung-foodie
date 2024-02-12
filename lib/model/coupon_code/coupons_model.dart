class CouponsClass {
  CouponsClass({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Coupon> data;

  factory CouponsClass.fromJson(Map<String, dynamic> json) => CouponsClass(
    status: json["status"],
    message: json["message"],
    data: List<Coupon>.from(json["data"].map((x) => Coupon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Coupon {
  Coupon({
    required this.offerCode,
    required this.discountType,
    required this.discount,
  });

  String offerCode;
  String discountType;
  int discount;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    offerCode: json["offercode"],
    discountType: json["discounttype"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "offercode": offerCode,
    "discounttype": discountType,
    "discount": discount,
  };
}
