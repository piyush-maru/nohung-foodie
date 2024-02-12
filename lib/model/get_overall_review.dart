class GetOverAllReview {
  bool? status;
  String? message;
  List<Data>? data;

  GetOverAllReview({this.status, this.message, this.data});

  GetOverAllReview.fromJson(Map<String, dynamic> json) {
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
  int? avgRatings;
  String? totalReview;
  String? excellent;
  String? good;
  String? average;
  String? poor;

  Data(
      {this.avgRatings,
      this.totalReview,
      this.excellent,
      this.good,
      this.average,
      this.poor});

  Data.fromJson(Map<String, dynamic> json) {
    avgRatings = json['avg_rattings'];
    totalReview = json['total_review'];
    excellent = json['excellent'];
    good = json['good'];
    average = json['average'];
    poor = json['poor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avg_rattings'] = avgRatings;
    data['total_review'] = totalReview;
    data['excellent'] = excellent;
    data['good'] = good;
    data['average'] = average;
    data['poor'] = poor;
    return data;
  }
}
