class BeanGetPackages {
  bool? status;
  String? message;
  List<Data>? data;

  BeanGetPackages({this.status, this.message, this.data});

  BeanGetPackages.fromJson(Map<String, dynamic> json) {
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
  String? packageId;
  String? userId;
  String? packageName;
  String? cuisineType;
  String? mealType;
  String? mealFor;
  String? weeklyPlanType;
  String? monthlyPlanType;
  String? startDate;
  String? includingSaturday;
  String? includingSunday;
  String? monthlyPrice;
  String? weeklyPrice;
  String? createdDate;

  Data(
      {this.packageId,
      this.userId,
      this.packageName,
      this.cuisineType,
      this.mealType,
      this.mealFor,
      this.weeklyPlanType,
      this.monthlyPlanType,
      this.startDate,
      this.includingSaturday,
      this.includingSunday,
      this.monthlyPrice,
      this.weeklyPrice,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    packageId = json['package_id'];
    userId = json['user_id'];
    packageName = json['packagename'];
    cuisineType = json['cuisinetype'];
    mealType = json['mealtype'];
    mealFor = json['mealfor'];
    weeklyPlanType = json['weeklyplantype'];
    monthlyPlanType = json['monthlyplantype'];
    startDate = json['startdate'];
    includingSaturday = json['including_saturday'];
    includingSunday = json['including_sunday'];
    monthlyPrice = json['monthlyprice'];
    weeklyPrice = json['weeklyprice'];
    createdDate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['package_id'] = packageId;
    data['user_id'] = userId;
    data['packagename'] = packageName;
    data['cuisinetype'] = cuisineType;
    data['mealtype'] = mealType;
    data['mealfor'] = mealFor;
    data['weeklyplantype'] = weeklyPlanType;
    data['monthlyplantype'] = monthlyPlanType;
    data['startdate'] = startDate;
    data['including_saturday'] = includingSaturday;
    data['including_sunday'] = includingSunday;
    data['monthlyprice'] = monthlyPrice;
    data['weeklyprice'] = weeklyPrice;
    data['createddate'] = createdDate;
    return data;
  }
}
