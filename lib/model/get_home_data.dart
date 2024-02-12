class KitchensData {
  bool? status;
  String? message;
  List<Data>? data;

  KitchensData({this.status, this.message, this.data});

  KitchensData.fromJson(Map<String, dynamic> json) {
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
  String? kitchenId;
  String? kitchenName;
  String? address;
  String? mealType;
  String? cuisineType;
  String? discount;
  String? image;
  String? averageRating;
  String? totalReview;
  String? time;
  String? isFavourite;

  @override
  String toString() {
    return "Data($kitchenName,$kitchenId,$mealType,$cuisineType)";
  }

  Data(
      {this.kitchenId,
      this.kitchenName,
      this.address,
      this.mealType,
      this.cuisineType,
      this.discount,
      this.image,
      this.averageRating,
      this.totalReview,
      this.time,
      this.isFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    kitchenId = json['kitchen_id'];
    kitchenName = json['kitchenname'];
    address = json['address'];
    mealType = json['mealtype'];
    cuisineType = json['cuisinetype'];
    discount = json['discount'];
    image = json['image'];
    averageRating = json['average_rating'];
    totalReview = json['total_review'];
    time = json['time'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kitchen_id'] = kitchenId;
    data['kitchenname'] = kitchenName;
    data['address'] = address;
    data['mealtype'] = mealType;
    data['cuisinetype'] = cuisineType;
    data['discount'] = discount;
    data['image'] = image;
    data['average_rating'] = averageRating;
    data['total_review'] = totalReview;
    data['time'] = time;
    data['is_favourite'] = isFavourite;
    return data;
  }
}
