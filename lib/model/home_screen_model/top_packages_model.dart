//
// class TopPackages {
//   bool? status;
//   String? message;
//   List<Data>? data;
//
//   TopPackages({this.status, this.message, this.data});
//
//   TopPackages.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? kitchenId;
//   String? kitchenname;
//   String? foodType;
//   String? image;
//   String? mealfor;
//   String? packageId;
//   String? packageName;
//   String? description;
//   String? provideCustomization;
//   String? cuisines;
//   String? including;
//   String? includingSaturday;
//   String? includingSunday;
//   String? weekly;
//   String? monthly;
//   String? mealtype;
//   String? price;
//   String? oneDayPrice;
//   String? weeklyPriceOn;
//   String? monthlyPriceOn;
//   String? weeklyNewPrice;
//   String? weeklyOldPrice;
//   String? monthlyNewPrice;
//   String? monthlyOldPrice;
//
//   Data(
//       {this.kitchenId,
//         this.kitchenname,
//         this.foodType,
//         this.image,
//         this.mealfor,
//         this.packageId,
//         this.packageName,
//         this.description,
//         this.provideCustomization,
//         this.cuisines,
//         this.including,
//         this.includingSaturday,
//         this.includingSunday,
//         this.weekly,
//         this.monthly,
//         this.mealtype,
//         this.price,
//         this.oneDayPrice,
//         this.weeklyPriceOn,
//         this.monthlyPriceOn,
//         this.weeklyNewPrice,
//         this.weeklyOldPrice,
//         this.monthlyNewPrice,
//         this.monthlyOldPrice});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     kitchenId = json['kitchen_id'];
//     kitchenname = json['kitchenname'];
//     foodType = json['food_type'];
//     image = json['image'];
//     mealfor = json['mealfor'];
//     packageId = json['package_id'];
//     packageName = json['package_name'];
//     description = json['description'];
//     provideCustomization = json['provide_customization'];
//     cuisines = json['cuisines'];
//     including = json['including'];
//     includingSaturday = json['including_saturday'];
//     includingSunday = json['including_sunday'];
//     weekly = json['weekly'];
//     monthly = json['monthly'];
//     mealtype = json['mealtype'];
//     price = json['price'];
//     oneDayPrice = json['one_day_price'];
//     weeklyPriceOn = json['weekly_price_on'];
//     monthlyPriceOn = json['monthly_price_on'];
//     weeklyNewPrice = json['weekly_new_price'];
//     weeklyOldPrice = json['weekly_old_price'];
//     monthlyNewPrice = json['monthly_new_price'];
//     monthlyOldPrice = json['monthly_old_price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['kitchen_id'] = this.kitchenId;
//     data['kitchenname'] = this.kitchenname;
//     data['food_type'] = this.foodType;
//     data['image'] = this.image;
//     data['mealfor'] = this.mealfor;
//     data['package_id'] = this.packageId;
//     data['package_name'] = this.packageName;
//     data['description'] = this.description;
//     data['provide_customization'] = this.provideCustomization;
//     data['cuisines'] = this.cuisines;
//     data['including'] = this.including;
//     data['including_saturday'] = this.includingSaturday;
//     data['including_sunday'] = this.includingSunday;
//     data['weekly'] = this.weekly;
//     data['monthly'] = this.monthly;
//     data['mealtype'] = this.mealtype;
//     data['price'] = this.price;
//     data['one_day_price'] = this.oneDayPrice;
//     data['weekly_price_on'] = this.weeklyPriceOn;
//     data['monthly_price_on'] = this.monthlyPriceOn;
//     data['weekly_new_price'] = this.weeklyNewPrice;
//     data['weekly_old_price'] = this.weeklyOldPrice;
//     data['monthly_new_price'] = this.monthlyNewPrice;
//     data['monthly_old_price'] = this.monthlyOldPrice;
//     return data;
//   }
// }
//

class TopPackages {
  bool status;
  String message;
  List<TopPackagesData> data;

  TopPackages({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TopPackages.fromJson(Map<String, dynamic> json) => TopPackages(
    status: json["status"],
    message: json["message"],
    data: List<TopPackagesData>.from(json["data"].map((x) => TopPackagesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}


class TopPackagesData {
  String kitchenId;
  String kitchenName;
  String rating;
  String foodType;
  String image;
  String mealFor;
  String packageId;
  String packageName;
  String description;
  String provideCustomization;
  String cuisines;
  String including;
  String includingSaturday;
  String includingSunday;
  String weekly;
  String monthly;
  String mealType;
  String price;
  String oneDayPrice;
  String weeklyPriceOn;
  String monthlyPriceOn;
  String weeklyNewPrice;
  String weeklyOldPrice;
  String monthlyNewPrice;
  String monthlyOldPrice;

  TopPackagesData({
    required this.kitchenId,
    required this.kitchenName,
    required this.rating,
    required this.foodType,
    required this.image,
    required this.mealFor,
    required this.packageId,
    required this.packageName,
    required this.description,
    required this.provideCustomization,
    required this.cuisines,
    required this.including,
    required this.includingSaturday,
    required this.includingSunday,
    required this.weekly,
    required this.monthly,
    required this.mealType,
    required this.price,
    required this.oneDayPrice,
    required this.weeklyPriceOn,
    required this.monthlyPriceOn,
    required this.weeklyNewPrice,
    required this.weeklyOldPrice,
    required this.monthlyNewPrice,
    required this.monthlyOldPrice,
  });

  factory TopPackagesData.fromJson(Map<String, dynamic> json) => TopPackagesData(
    kitchenId: json["kitchen_id"],
    kitchenName: json["kitchenname"],
    rating: json["rating"]!,
    foodType: json["food_type"]!,
    image: json["image"],
    mealFor: json["mealfor"],
    packageId: json["package_id"],
    packageName: json["package_name"],
    description: json["description"],
    provideCustomization: json["provide_customization"]!,
    cuisines: json["cuisines"],
    including: json["including"]!,
    includingSaturday: json["including_saturday"],
    includingSunday: json["including_sunday"],
    weekly: json["weekly"],
    monthly: json["monthly"],
    mealType: json["mealtype"],
    price: json["price"],
    oneDayPrice: json["one_day_price"],
    weeklyPriceOn: json["weekly_price_on"],
    monthlyPriceOn: json["monthly_price_on"],
    weeklyNewPrice: json["weekly_new_price"],
    weeklyOldPrice: json["weekly_old_price"],
    monthlyNewPrice: json["monthly_new_price"],
    monthlyOldPrice: json["monthly_old_price"],
  );

  Map<String, dynamic> toJson() => {
    "kitchen_id": kitchenId,
    "kitchenname": kitchenName,
    "rating": rating,
    "food_type": foodType,
    "image": image,
    "mealfor": mealFor,
    "package_id": packageId,
    "package_name": packageName,
    "description": description,
    "provide_customization": provideCustomization,
    "cuisines": cuisines,
    "including": including,
    "including_saturday": includingSaturday,
    "including_sunday": includingSunday,
    "weekly": weekly,
    "monthly": monthly,
    "mealtype": mealType,
    "price": price,
    "one_day_price": oneDayPrice,
    "weekly_price_on": weeklyPriceOn,
    "monthly_price_on": monthlyPriceOn,
    "weekly_new_price": weeklyNewPrice,
    "weekly_old_price": weeklyOldPrice,
    "monthly_new_price": monthlyNewPrice,
    "monthly_old_price": monthlyOldPrice,
  };


}

