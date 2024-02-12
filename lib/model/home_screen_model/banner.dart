class BeanBanner {
  bool? status;
  String? message;
  Data? data;

  BeanBanner({this.status, this.message, this.data});

  BeanBanner.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != [] ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderItemsId;
  String? orderType;
  String? packageType;
  String? kitchenName;
  String? kitchenMobileNo;
  String? riderName;
  String? riderMobileNo;
  String? riderRating;
  String? riderReview;
  String? trackRiderLatitude;
  String? trackRiderLongitude;
  Meal? meal;

  Data(
      {this.orderItemsId,
      this.orderType,
      this.packageType,
      this.kitchenName,
      this.kitchenMobileNo,
      this.riderName,
      this.riderMobileNo,
      this.riderRating,
      this.riderReview,
      this.trackRiderLatitude,
      this.trackRiderLongitude,
      this.meal});

  Data.fromJson(Map<String, dynamic> json) {
    orderItemsId = json['orderitemsid'];
    orderType = json['ordertype'];
    packageType = json['packagetype'];
    kitchenName = json['kitchen_name'];
    kitchenMobileNo = json['kitchen_mobileno'];
    riderName = json['rider_name'];
    riderMobileNo = json['rider_mobileno'];
    riderRating = json['rider_rating'];
    riderReview = json['rider_review'];
    trackRiderLatitude = json['track_rider_latitude'];
    trackRiderLongitude = json['track_rider_longitude'];
    meal = json['meal'] != null ?  Meal.fromJson(json['meal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['orderitemsid'] = orderItemsId;
    data['ordertype'] = orderType;
    data['packagetype'] = packageType;
    data['kitchen_name'] = kitchenName;
    data['kitchen_mobileno'] = kitchenMobileNo;
    data['rider_name'] = riderName;
    data['rider_mobileno'] = riderMobileNo;
    data['rider_rating'] = riderRating;
    data['rider_review'] = riderReview;
    data['track_rider_latitude'] = trackRiderLatitude;
    data['track_rider_longitude'] = trackRiderLongitude;
    if (meal != null) {
      data['meal'] = meal!.toJson();
    }
    return data;
  }
}

class Meal {
  String? id;
  String? mealPlan;
  String? referenceId;
  String? deliveryDate;
  String? deliveryFromTime;
  String? plan;
  String? itemName;

  Meal(
      {this.id,
      this.mealPlan,
      this.referenceId,
      this.deliveryDate,
      this.deliveryFromTime,
      this.plan,
      this.itemName});

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealPlan = json['mealplan'];
    referenceId = json['reference_id'];
    deliveryDate = json['delivery_date'];
    deliveryFromTime = json['delivery_fromtime'];
    plan = json['plan'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mealplan'] = mealPlan;
    data['reference_id'] = referenceId;
    data['delivery_date'] = deliveryDate;
    data['delivery_fromtime'] = deliveryFromTime;
    data['plan'] = plan;
    data['item_name'] = itemName;
    return data;
  }
}
