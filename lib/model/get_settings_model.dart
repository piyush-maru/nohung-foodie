

class GetSetting {
  bool status;
  String message;
  Data data;

  GetSetting({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetSetting.fromJson(Map<String, dynamic> json) => GetSetting(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String taxOnOrder;
  String deliveryChargePerKm;
  String priorTimeToCancelEditOrder;
  String subscriptionOrderPriorTiming;
  String facebookAppId;
  String facebookAppSecret;
  String googleClientId;
  String googleClientSecret;

  Data({
    required this.taxOnOrder,
    required this.deliveryChargePerKm,
    required this.priorTimeToCancelEditOrder,
    required this.subscriptionOrderPriorTiming,
    required this.facebookAppId,
    required this.facebookAppSecret,
    required this.googleClientId,
    required this.googleClientSecret,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    taxOnOrder: json["tax_on_order"],
    deliveryChargePerKm: json["delivery_charge_per_km"],
    priorTimeToCancelEditOrder: json["prior_time_to_cancel_edit_order"],
    subscriptionOrderPriorTiming: json["subscription_order_prior_timing"],
    facebookAppId: json["facebook_app_id"],
    facebookAppSecret: json["facebook_app_secret"],
    googleClientId: json["google_client_id"],
    googleClientSecret: json["google_client_secret"],
  );

  Map<String, dynamic> toJson() => {
    "tax_on_order": taxOnOrder,
    "delivery_charge_per_km": deliveryChargePerKm,
    "prior_time_to_cancel_edit_order": priorTimeToCancelEditOrder,
    "subscription_order_prior_timing": subscriptionOrderPriorTiming,
    "facebook_app_id": facebookAppId,
    "facebook_app_secret": facebookAppSecret,
    "google_client_id": googleClientId,
    "google_client_secret": googleClientSecret,
  };
}
