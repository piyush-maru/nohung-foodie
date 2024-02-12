class GetPostponeMenuDetails {
  bool status;
  String message;
  PostponeMenuData data;

  GetPostponeMenuDetails({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetPostponeMenuDetails.fromJson(Map<String, dynamic> json) => GetPostponeMenuDetails(
    status: json["status"],
    message: json["message"],
    data: PostponeMenuData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class PostponeMenuData {
  CurrentOrderItem currentOrderItem;
  List<NewMenuItem> newMenuItems;
  String mealPlan;
  String dishItem;
  String currentItemPrice;
  String postponeItemPrice;
  String payAmount;
  String taxAmount;
  int noOfItems;
  String newOrderDay;
  DateTime newDate;
  String deliveryFromTime;
  String deliveryToTime;
  double foodieWalletAmount;
  String monthlyPriceVariation;
  String weeklyPriceVariation;

  PostponeMenuData({
    required this.currentOrderItem,
    required this.newMenuItems,
    required this.mealPlan,
    required this.dishItem,
    required this.currentItemPrice,
    required this.postponeItemPrice,
    required this.payAmount,
    required this.taxAmount,
    required this.noOfItems,
    required this.newOrderDay,
    required this.newDate,
    required this.deliveryFromTime,
    required this.deliveryToTime,
    required this.foodieWalletAmount,
    required this.monthlyPriceVariation,
    required this.weeklyPriceVariation,
  });

  factory PostponeMenuData.fromJson(Map<String, dynamic> json) => PostponeMenuData(
    currentOrderItem: CurrentOrderItem.fromJson(json["current_order_item"]),
    newMenuItems: List<NewMenuItem>.from(json["new_menu_items"].map((x) => NewMenuItem.fromJson(x))),
    mealPlan: json["mealplan"],
    dishItem: json["dishItem"],
    currentItemPrice: json["current_item_price"],
    postponeItemPrice: json["postpone_item_price"],
    payAmount: json["pay_amount"],
    taxAmount: json["tax_amount"],
    noOfItems: json["noofitems"],
    newOrderDay: json["new_order_day"],
    newDate: DateTime.parse(json["new_date"]),
    deliveryFromTime: json["delivery_fromtime"],
    deliveryToTime: json["delivery_totime"],
    foodieWalletAmount: json["foodie_wallet_amount"]?.toDouble(),
    monthlyPriceVariation: json["monthly_price_variation"],
    weeklyPriceVariation: json["weekly_price_variation"],
  );

  Map<String, dynamic> toJson() => {
    "current_order_item": currentOrderItem.toJson(),
    "new_menu_items": List<dynamic>.from(newMenuItems.map((x) => x.toJson())),
    "mealplan": mealPlan,
    "dishItem": dishItem,
    "current_item_price": currentItemPrice,
    "postpone_item_price": postponeItemPrice,
    "pay_amount": payAmount,
    "tax_amount": taxAmount,
    "noofitems": noOfItems,
    "new_order_day": newOrderDay,
    "new_date": "${newDate.year.toString().padLeft(4, '0')}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}",
    "delivery_fromtime": deliveryFromTime,
    "delivery_totime": deliveryToTime,
    "foodie_wallet_amount": foodieWalletAmount,
    "monthly_price_variation": monthlyPriceVariation,
    "weekly_price_variation": weeklyPriceVariation,
  };
}

class CurrentOrderItem {
  DateTime date;
  String fromTime;
  String toTime;
  String totalAmount;
  List<Item> items;

  CurrentOrderItem({
    required this.date,
    required this.fromTime,
    required this.toTime,
    required this.totalAmount,
    required this.items,
  });

  factory CurrentOrderItem.fromJson(Map<String, dynamic> json) => CurrentOrderItem(
    date: DateTime.parse(json["date"]),
    fromTime: json["from_time"],
    toTime: json["to_time"],
    totalAmount: json["total_amount"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "from_time": fromTime,
    "to_time": toTime,
    "total_amount": totalAmount,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String itemName;
  String qty;

  Item({
    required this.itemName,
    required this.qty,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemName: json["itemname"],
    qty: json["qty"],
  );

  Map<String, dynamic> toJson() => {
    "itemname": itemName,
    "qty": qty,
  };
}

class NewMenuItem {
  String menuId;
  String itemName;
  String qty;
  String price;

  NewMenuItem({
    required this.menuId,
    required this.itemName,
    required this.qty,
    required this.price,
  });

  factory NewMenuItem.fromJson(Map<String, dynamic> json) => NewMenuItem(
    menuId: json["menuid"],
    itemName: json["itemname"],
    qty: json["qty"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "menuid": menuId,
    "itemname": itemName,
    "qty": qty,
    "price": price,
  };
}
