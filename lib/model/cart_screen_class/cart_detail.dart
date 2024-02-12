class BeanCartDetail {
  bool? status;
  String? message;
  Data? data;

  BeanCartDetail({this.status, this.message, this.data});

  BeanCartDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  List<CartItems>? cartItems;
  String? distanceInKm;
  String? totalAmount;
  String? taxAmount;
  String? deliveryCharge;

  Data(
      {this.cartItems,
      this.distanceInKm,
      this.totalAmount,
      this.taxAmount,
      this.deliveryCharge});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    distanceInKm = json['distance_in_km'];
    totalAmount = json['total_amount'];
    taxAmount = json['tax_amount'];
    deliveryCharge = json['delivery_charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['distance_in_km'] = distanceInKm;
    data['total_amount'] = totalAmount;
    data['tax_amount'] = taxAmount;
    data['delivery_charge'] = deliveryCharge;
    return data;
  }
}

class CartItems {
  String? cartId;
  String? kitchenId;
  String? itemName;
  String? menuImage;
  String? quantity;
  String? price;
  String? mealType;
  String? cuisineType;
  String? deliveryDate;
  String? deliveryFromTime;
  String? deliveryToTime;
  String? includingSaturday;
  String? includingSunday;
  String? createdDate;

  CartItems(
      {this.cartId,
      this.kitchenId,
      this.itemName,
      this.menuImage,
      this.quantity,
      this.price,
      this.mealType,
      this.cuisineType,
      this.deliveryDate,
      this.deliveryFromTime,
      this.deliveryToTime,
      this.includingSaturday,
      this.includingSunday,
      this.createdDate});

  CartItems.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    kitchenId = json['kitchen_id'];
    itemName = json['item_name'];
    menuImage = json['menuimage'];
    quantity = json['quantity'];
    price = json['price'];
    mealType = json['mealtype'];
    cuisineType = json['cuisinetype'];
    deliveryDate = json['delivery_date'];
    deliveryFromTime = json['delivery_fromtime'];
    deliveryToTime = json['delivery_totime'];
    includingSaturday = json['including_saturday'];
    includingSunday = json['including_sunday'];
    createdDate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_id'] = cartId;
    data['kitchen_id'] = kitchenId;
    data['item_name'] = itemName;
    data['menuimage'] = menuImage;
    data['quantity'] = quantity;
    data['price'] = price;
    data['mealtype'] = mealType;
    data['cuisinetype'] = cuisineType;
    data['delivery_date'] = deliveryDate;
    data['delivery_fromtime'] = deliveryFromTime;
    data['delivery_totime'] = deliveryToTime;
    data['including_saturday'] = includingSaturday;
    data['including_sunday'] = includingSunday;
    data['createddate'] = createdDate;
    return data;
  }
}
