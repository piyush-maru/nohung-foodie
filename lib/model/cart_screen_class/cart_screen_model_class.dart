import 'dart:convert';

GetCartDetailsModel getCartDetailFromJson(String str) =>
    GetCartDetailsModel.fromJson(json.decode(str));

String getCartDetailToJson(GetCartDetailsModel data) =>
    json.encode(data.toJson());

class GetCartDetailsModel {
  GetCartDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  var status;
  String message;
  CartDetailsData data;

  factory GetCartDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetCartDetailsModel(
        status: json["status"] ?? '',
        message: json["message"] ?? '',
        data: CartDetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class CartDetailsData {
  CartDetailsData({
    required this.kitchenDetailData,
    required this.cartItems,
    required this.cartTotal,
    required this.taxAmount,
    required this.deliveryCharge,
    required this.actualDeliveryCharge,
    this.to_date,
    this.cart_count,
    this.from_date,
    required this.actualPackagingCharges,
    required this.packagingCharges,
    required this.couponDiscount,
    required this.subTotal,
    required this.myLocation,
    required this.walletBalance,
    this.pre_order_delivery_date,
    this.pre_order_delivery_fromtime,
    this.pre_order_delivery_totime,
  });

  List<CartItem> cartItems;
  String cartTotal;
  String taxAmount;
  String deliveryCharge;
  String actualDeliveryCharge;
  String? to_date;
  String? cart_count;
  String? from_date;
  String actualPackagingCharges;
  String packagingCharges;
  String couponDiscount;
  String subTotal;
  MyLocation myLocation;
  String walletBalance;
  String? pre_order_delivery_date;
  String? pre_order_delivery_fromtime;
  String? pre_order_delivery_totime;
  KitchenDetailData kitchenDetailData;

  factory CartDetailsData.fromJson(Map<String, dynamic> json) =>
      CartDetailsData(
        cartItems: List<CartItem>.from(
            json["cart_items"].map((x) => CartItem.fromJson(x))),
        cartTotal: json["cart_total"],
        taxAmount: json["tax_amount"],
        deliveryCharge: json["delivery_charge"],
        actualDeliveryCharge: json["actual_delivery_charge"],
        to_date: json["to_date"],
        cart_count: json["cart_count"],
        from_date: json["from_date"],
        actualPackagingCharges: json["actual_packaging_charges"],
        packagingCharges: json["packaging_charge"],
        couponDiscount: json["coupon_discount"],
        subTotal: json["sub_total"],
        myLocation: MyLocation.fromJson(json["my_location"]),
        kitchenDetailData: KitchenDetailData.fromJson(json["kitchen_detail"]),
        walletBalance: json["wallet_balance"],
        pre_order_delivery_date: json["pre_order_delivery_date"],
        pre_order_delivery_fromtime: json["pre_order_delivery_fromtime"],
        pre_order_delivery_totime: json["pre_order_delivery_totime"],
      );

  Map<String, dynamic> toJson() => {
        "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "cart_total": cartTotal,
        "tax_amount": taxAmount,
        "delivery_charge": deliveryCharge,
        "actual_delivery_charge": actualDeliveryCharge,
        "to_date": to_date,
        "cart_count": cart_count,
        "from_date": from_date,
        "actual_packaging_charges": actualPackagingCharges,
        "packaging_charge": packagingCharges,
        "coupon_discount": couponDiscount,
        "sub_total": subTotal,
        "my_location": myLocation.toJson(),
        "wallet_balance": walletBalance,
        "pre_order_delivery_date": pre_order_delivery_date,
        "pre_order_delivery_fromtime": pre_order_delivery_fromtime,
        "pre_order_delivery_totime": pre_order_delivery_totime,
      };
}

class CartItem {
  CartItem({
    required this.cartId,
    required this.kitchenId,
    required this.itemName,
    required this.menuimage,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.mealtype,
    required this.typeid,
    required this.cuisinetype,
    required this.deliveryDate,
    required this.deliveryFromtime,
    required this.deliveryTotime,
    required this.includingSaturday,
    required this.includingSunday,
    required this.createddate,
  });

  String cartId;
  String kitchenId;
  String itemName;
  String menuimage;
  String quantity;
  String price;
  String totalPrice;
  String mealtype;
  String typeid;
  String cuisinetype;
  String deliveryDate;
  String deliveryFromtime;
  String deliveryTotime;
  String includingSaturday;
  String includingSunday;
  DateTime createddate;

  bool get isTrial => mealtype == "trial" ? true : false;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        cartId: json["cart_id"],
        kitchenId: json["kitchen_id"],
        itemName: json["item_name"],
        menuimage: json["menuimage"],
        quantity: json["quantity"],
        price: json["price"],
        totalPrice: json["total_price"],
        mealtype: json["mealtype"],
        typeid: json["typeid"],
        cuisinetype: json["cuisinetype"],
        // deliveryDate: DateTime.parse(json["delivery_date"]),
        deliveryDate: json["delivery_date"],
        deliveryFromtime: json["delivery_fromtime"],
        deliveryTotime: json["delivery_totime"],
        includingSaturday: json["including_saturday"],
        includingSunday: json["including_sunday"],
        createddate: DateTime.parse(json["createddate"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "kitchen_id": kitchenId,
        "item_name": itemName,
        "menuimage": menuimage,
        "quantity": quantity,
        "price": price,
        "total_price": totalPrice,
        "mealtype": mealtype,
        "typeid": typeid,
        "cuisinetype": cuisinetype,
        "delivery_date": deliveryDate,
        // "delivery_date":
        //         "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
        "delivery_fromtime": deliveryFromtime,
        "delivery_totime": deliveryTotime,
        "including_saturday": includingSaturday,
        "including_sunday": includingSunday,
        "createddate": createddate.toIso8601String(),
      };
}

class MyLocation {
  MyLocation({
    required this.addressId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.street,
    required this.landmark,
    required this.addressType,
  });

  String addressId;
  String address;
  String latitude;
  String longitude;
  String street;
  String landmark;
  String addressType;

  factory MyLocation.fromJson(Map<String, dynamic> json) => MyLocation(
        addressId: json["address_id"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        street: json["street"],
        landmark: json["landmark"],
        addressType: json["address_type"],
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "street": street,
        "landmark": landmark,
        "address_type": addressType,
      };
}

class KitchenDetailData {
  KitchenDetailData({
    this.kitchenId,
    this.kitchenName,
    this.latitude,
    this.longitude,
  });

  String? kitchenId;
  String? kitchenName;
  String? latitude;
  String? longitude;

  factory KitchenDetailData.fromJson(Map<String, dynamic> json) =>
      KitchenDetailData(
        kitchenId: json["kitchen_id"],
        kitchenName: json["kitchen_name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "kitchen_name": kitchenName,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class CartItems {
  String cartId;
  String kitchenId;
  String itemName;
  String menuimage;
  String quantity;
  String price;
  String totalPrice;
  String mealtype;
  String typeid;
  String cuisinetype;
  String deliveryDate;
  String deliveryFromtime;
  String deliveryTotime;
  String includingSaturday;
  String includingSunday;
  DateTime createddate;

  CartItems({
    required this.cartId,
    required this.kitchenId,
    required this.itemName,
    required this.menuimage,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.mealtype,
    required this.typeid,
    required this.cuisinetype,
    required this.deliveryDate,
    required this.deliveryFromtime,
    required this.deliveryTotime,
    required this.includingSaturday,
    required this.includingSunday,
    required this.createddate,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
        cartId: json["cart_id"],
        kitchenId: json["kitchen_id"],
        itemName: json["item_name"],
        menuimage: json["menuimage"],
        quantity: json["quantity"],
        price: json["price"],
        totalPrice: json["total_price"],
        mealtype: json["mealtype"],
        typeid: json["typeid"],
        cuisinetype: json["cuisinetype"],
        deliveryDate: json["delivery_date"],
        deliveryFromtime: json["delivery_fromtime"],
        deliveryTotime: json["delivery_totime"],
        includingSaturday: json["including_saturday"],
        includingSunday: json["including_sunday"],
        createddate: DateTime.parse(json["createddate"]),
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "kitchen_id": kitchenId,
        "item_name": itemName,
        "menuimage": menuimage,
        "quantity": quantity,
        "price": price,
        "total_price": totalPrice,
        "mealtype": mealtype,
        "typeid": typeid,
        "cuisinetype": cuisinetype,
        "delivery_date": deliveryDate,
        "delivery_fromtime": deliveryFromtime,
        "delivery_totime": deliveryTotime,
        "including_saturday": includingSaturday,
        "including_sunday": includingSunday,
        "createddate": createddate.toIso8601String(),
      };
}

class KitchenDetail {
  String kitchenId;
  String kitchenName;
  String kitchenProfile;
  String latitude;
  String longitude;

  KitchenDetail({
    required this.kitchenId,
    required this.kitchenName,
    required this.kitchenProfile,
    required this.latitude,
    required this.longitude,
  });

  factory KitchenDetail.fromJson(Map<String, dynamic> json) => KitchenDetail(
        kitchenId: json["kitchen_id"],
        kitchenName: json["kitchen_name"],
        kitchenProfile: json["kitchen_profile"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "kitchen_id": kitchenId,
        "kitchen_name": kitchenName,
        "kitchen_profile": kitchenProfile,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class UserLocation {
  String addressId;
  String address;
  String latitude;
  String longitude;
  String street;
  String landmark;
  String addressType;

  UserLocation({
    required this.addressId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.street,
    required this.landmark,
    required this.addressType,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        addressId: json["address_id"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        street: json["street"],
        landmark: json["landmark"],
        addressType: json["address_type"],
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "street": street,
        "landmark": landmark,
        "address_type": addressType,
      };
}
