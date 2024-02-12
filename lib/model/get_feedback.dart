class GetFeedback {
  bool? status;
  String? message;
  Data? data;

  GetFeedback({this.status, this.message, this.data});

  GetFeedback.fromJson(Map<String, dynamic> json) {
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
  String? totalRating;
  String? totalReview;
  List<Feedback>? feedback;

  Data({this.totalRating, this.totalReview, this.feedback});

  Data.fromJson(Map<String, dynamic> json) {
    totalRating = json['totalrating'];
    totalReview = json['totalreview'];
    if (json['feedback'] != null) {
      feedback = [];
      json['feedback'].forEach((v) {
        feedback!.add(Feedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalrating'] = totalRating;
    data['totalreview'] = totalReview;
    if (feedback != null) {
      data['feedback'] = feedback!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Feedback {
  String? customerName;
  String? customerPhoto;
  String? rating;
  String? message;
  String? createdtime;

  Feedback(
      {this.customerName,
      this.customerPhoto,
      this.rating,
      this.message,
      this.createdtime});

  Feedback.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    customerPhoto = json['customer_photo'];
    rating = json['rating'];
    message = json['message'];
    createdtime = json['createdtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_name'] = customerName;
    data['customer_photo'] = customerPhoto;
    data['rating'] = rating;
    data['message'] = message;
    data['createdtime'] = createdtime;
    return data;
  }
}
