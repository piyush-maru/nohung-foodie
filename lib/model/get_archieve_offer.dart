class GetArchiveOffer {
  bool? status;
  String? message;
  List<Data>? data;

  GetArchiveOffer({this.status, this.message, this.data});

  GetArchiveOffer.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
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
  String? offerId;
  String? userId;
  String? title;
  String? offerCode;
  String? discountType;
  String? discountValue;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? appliesTo;
  String? minRequirement;
  String? usageLimit;
  String? createdDate;

  Data(
      {this.offerId,
      this.userId,
      this.title,
      this.offerCode,
      this.discountType,
      this.discountValue,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.appliesTo,
      this.minRequirement,
      this.usageLimit,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    userId = json['user_id'];
    title = json['title'];
    offerCode = json['offercode'];
    discountType = json['discounttype'];
    discountValue = json['discount_value'];
    startDate = json['startdate'];
    endDate = json['enddate'];
    startTime = json['starttime'];
    endTime = json['endtime'];
    appliesTo = json['appliesto'];
    minRequirement = json['minrequirement'];
    usageLimit = json['usagelimit'];
    createdDate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offer_id'] = offerId;
    data['user_id'] = userId;
    data['title'] = title;
    data['offercode'] = offerCode;
    data['discounttype'] = discountType;
    data['discount_value'] = discountValue;
    data['startdate'] = startDate;
    data['enddate'] = endDate;
    data['starttime'] = startTime;
    data['endtime'] = endTime;
    data['appliesto'] = appliesTo;
    data['minrequirement'] = minRequirement;
    data['usagelimit'] = usageLimit;
    data['createddate'] = createdDate;
    return data;
  }
}
