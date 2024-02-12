class BeanCustomizedPackage {
  bool? status;
  String? message;
  List<Data>? data;

  BeanCustomizedPackage({this.status, this.message, this.data});

  BeanCustomizedPackage.fromJson(Map<String, dynamic> json) {
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
  String? category;
  List<MenuItems>? menuItems;

  Data({this.category, this.menuItems});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    if (json['menuitems'] != null) {
      menuItems = [];
      json['menuitems'].forEach((v) {
        menuItems!.add(MenuItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    if (menuItems != null) {
      data['menuitems'] = menuItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuItems {
  String? menuId;
  String? itemName;
  String? itemPrice;
  int itemQty = 0;

  bool? isCheckedDays = false;

  MenuItems({this.menuId, this.itemName, this.itemPrice});

  MenuItems.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    itemName = json['itemname'];
    itemPrice = json['itemprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['itemname'] = itemName;
    data['itemprice'] = itemPrice;
    return data;
  }
}
