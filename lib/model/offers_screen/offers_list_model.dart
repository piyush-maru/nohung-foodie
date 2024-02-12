import 'dart:convert';

OffersList offersListFromJson(String str) =>
    OffersList.fromJson(json.decode(str));

String offersListToJson(OffersList data) => json.encode(data.toJson());

class OffersList {
  OffersList({
    required this.status,
    required this.message,
    this.data,
  });

  bool status;
  String message;
  List<Offer>? data;

  factory OffersList.fromJson(Map<String, dynamic> json) => OffersList(
        status: json["status"],
        message: json["message"],
        data: List<Offer>.from(json["data"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Offer {
  Offer({
    required this.offerCode,
    required this.discountType,
    required this.discount,
    required this.upToAmount,
    required this.title,
  });

  String offerCode;
  String discountType;
  String discount;
  String upToAmount;
  String title;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerCode: json["offercode"],
        discountType: json["discounttype"],
        discount: json["discount"],
        upToAmount: json["upto_amount"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "offercode": offerCode,
        "discounttype": discountType,
        "discount": discount,
        "upto_amount": upToAmount,
        "title": title,
      };
}
