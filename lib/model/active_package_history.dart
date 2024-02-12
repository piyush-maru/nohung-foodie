class BeanActivePackageHistory {
  bool? status;
  String? message;
  List<Data>? data;

  BeanActivePackageHistory({this.status, this.message, this.data});

  BeanActivePackageHistory.fromJson(Map<String, dynamic> json) {
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
  String? packageName;
  String? orderId;
  String? orderDates;
  String? cuisineType;
  List<DayList>? dayList;

  Data(
      {this.packageName,
      this.orderId,
      this.orderDates,
      this.cuisineType,
      this.dayList});

  Data.fromJson(Map<String, dynamic> json) {
    packageName = json['packagename'];
    orderId = json['orderid'];
    orderDates = json['order_dates'];
    cuisineType = json['cuisinetype'];
    if (json['day_list'] != null) {
      dayList = [];
      json['day_list'].forEach((v) {
        dayList!.add(DayList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packagename'] = packageName;
    data['orderid'] = orderId;
    data['order_dates'] = orderDates;
    data['cuisinetype'] = cuisineType;
    if (dayList != null) {
      data['day_list'] = dayList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayList {
  String? id;
  String? day;
  String? menuItem;
  String? time;
  String? status;

  DayList({this.id, this.day, this.menuItem, this.time, this.status});

  DayList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    menuItem = json['menu_item'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['menu_item'] = menuItem;
    data['time'] = time;
    data['status'] = status;
    return data;
  }
}
