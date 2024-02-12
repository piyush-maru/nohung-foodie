class UpdateOrderItemDetailsModel {
  final int token;
  final int userId;
  final int orderId;
  final int orderItemId;
  final String deliveryAddress;
  final double deliveryLatitude;
  final double deliveryLongitude;
  final String deliveryFromTime;
  final String deliveryToTime;
  final String description;
  final List<CustomizableItem> customisableItems;
  final int isWalletChecked;

  UpdateOrderItemDetailsModel({
    required this.token,
    required this.userId,
    required this.orderId,
    required this.orderItemId,
    required this.deliveryAddress,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    required this.deliveryFromTime,
    required this.deliveryToTime,
    required this.description,
    required this.customisableItems,
    required this.isWalletChecked,
  });

  factory UpdateOrderItemDetailsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> items = json['customisable_items'];

    return UpdateOrderItemDetailsModel(
      token: json['token'],
      userId: json['user_id'],
      orderId: json['order_id'],
      orderItemId: json['order_item_id'],
      deliveryAddress: json['delivery_address'],
      deliveryLatitude: double.parse(json['delivery_latitude']),
      deliveryLongitude: double.parse(json['delivery_longitude']),
      deliveryFromTime: json['delivery_fromtime'],
      deliveryToTime: json['delivery_totime'],
      description: json['description'],
      customisableItems: items.map((item) => CustomizableItem.fromJson(item)).toList(),
      isWalletChecked: json['iswalletchecked'],
    );
  }

  Map<String, dynamic> toJson() {
    List<dynamic> items = customisableItems.map((item) => item.toJson()).toList();

    return {
      'token': token,
      'user_id': userId,
      'order_id': orderId,
      'order_item_id': orderItemId,
      'delivery_address': deliveryAddress,
      'delivery_latitude': deliveryLatitude.toString(),
      'delivery_longitude': deliveryLongitude.toString(),
      'delivery_fromtime': deliveryFromTime,
      'delivery_totime': deliveryToTime,
      'description': description,
      'customisable_items': items,
      'iswalletchecked': isWalletChecked,
    };
  }
}

class CustomizableItem {
  final String id;
  final String itemName;
  final String itemPrice;
  final int quantity;
  final String wVariationPrice;
  final String mVariationPrice;
  final int defaultQuantity;
  final int extraQuantity;

  CustomizableItem({
    required this.id,
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.wVariationPrice,
    required this.mVariationPrice,
    required this.defaultQuantity,
    required this.extraQuantity,
  });

  factory CustomizableItem.fromJson(Map<String, dynamic> json) {
    return CustomizableItem(
      id: json['id'],
      itemName: json['item_name'],
      itemPrice: json['item_price'],
      quantity: json['qty'],
      wVariationPrice: json['w_variation_price'],
      mVariationPrice: json['m_variation_price'],
      defaultQuantity: json['default_qty'],
      extraQuantity: json['extra_qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_name': itemName,
      'item_price': itemPrice,
      'qty': quantity,
      'w_variation_price': wVariationPrice,
      'm_variation_price': mVariationPrice,
      'default_qty': defaultQuantity,
      'extra_qty': extraQuantity,
    };
  }}