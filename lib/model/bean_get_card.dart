class BeanGetCard {
  bool? status;
  String? message;
  List<Data>? data;

  BeanGetCard({this.status, this.message, this.data});

  BeanGetCard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? cardName;
  String? image;
  String? cardNumber;
  String? holderName;
  String? validThru;
  String? isDefault;

  Data(
      {this.id,
        this.cardName,
        this.image,
        this.cardNumber,
        this.holderName,
        this.validThru,
        this.isDefault});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardName = json['card_name'];
    image = json['image'];
    cardNumber = json['card_number'];
    holderName = json['holder_name'];
    validThru = json['valid_thru'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['card_name'] = cardName;
    data['image'] = image;
    data['card_number'] = cardNumber;
    data['holder_name'] = holderName;
    data['valid_thru'] = validThru;
    data['is_default'] = isDefault;
    return data;
  }
}