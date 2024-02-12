class PostponeOrder {
  bool? status;
  String? message;
  Data? data;

  PostponeOrder({
    this.status, 
    this.message,
    this.data
  });

  PostponeOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json["data"]);

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data1 = <String, dynamic>{};
    data1['status'] = status;
    data1['message'] = message;
    data1["data"] = data!.toJson();    
    return data1;
  }
}
class Data {
  String? transactionId;

  Data({
    this.transactionId
   });

  Data.fromJson(Map<String, dynamic> json) {

   transactionId = json['transaction_id'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['transaction_id'] = transactionId;
    return data;
  }
}
