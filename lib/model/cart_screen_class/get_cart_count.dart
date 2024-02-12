class GetCartCount {
  bool status;
  String message;
  int data;

  GetCartCount({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCartCount.fromJson(Map<String, dynamic> json) => GetCartCount(
    status: json["status"],
    message: json["message"],
    data: json['data'] is List ? 0 : (json['data'] as Map<String, dynamic>)['cart_count'] as int,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
  };
}


class GetCartCountData {
  int cartCount;

  GetCartCountData({
    required this.cartCount,
  });

  factory GetCartCountData.fromJson(dynamic json) => GetCartCountData(
    cartCount: json["cart_count"],
  );

  Map<String, dynamic> toJson() => {
    "cart_count": cartCount,
  };
}

