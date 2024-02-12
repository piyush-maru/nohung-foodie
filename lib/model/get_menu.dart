class GetMenu {
  bool? status;
  String? message;
  Data? data;

  GetMenu({this.status, this.message, this.data});

  GetMenu.fromJson(Map<String, dynamic> json) {
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
  SouthIndian? southIndian;

  Data({this.southIndian});

  Data.fromJson(Map<String, dynamic> json) {
    southIndian = json['southindian'] != null
        ? SouthIndian.fromJson(json['southindian'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (southIndian != null) {
      data['southindian'] = southIndian!.toJson();
    }
    return data;
  }
}

class SouthIndian {
  Breakfast? breakfast;
  Lunch? lunch;

  SouthIndian({this.breakfast, this.lunch});

  SouthIndian.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'] != null
        ? Breakfast.fromJson(json['breakfast'])
        : null;
    lunch = json['lunch'] != null ? Lunch.fromJson(json['lunch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (breakfast != null) {
      data['breakfast'] = breakfast!.toJson();
    }
    if (lunch != null) {
      data['lunch'] = lunch!.toJson();
    }
    return data;
  }
}

class Breakfast {
  List<Veg>? veg;
  List<NonVeg>? nonVeg;

  Breakfast({this.veg, this.nonVeg});

  Breakfast.fromJson(Map<String, dynamic> json) {
    if (json['veg'] != null) {
      veg = [];
      json['veg'].forEach((v) {
        veg!.add(Veg.fromJson(v));
      });
    }
    if (json['nonveg'] != null) {
      nonVeg = [];
      json['nonveg'].forEach((v) {
        nonVeg!.add(NonVeg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (veg != null) {
      data['veg'] = veg!.map((v) => v.toJson()).toList();
    }
    if (nonVeg != null) {
      data['nonveg'] = nonVeg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Veg {
  String? image;
  String? price;
  String? name;

  Veg({this.image, this.price, this.name});

  Veg.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}

class NonVeg {
  String? image;
  String? price;
  String? name;

  NonVeg({this.image, this.price, this.name});

  NonVeg.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}

class Lunch {
  List<Veg>? veg;

  Lunch({this.veg});

  Lunch.fromJson(Map<String, dynamic> json) {
    if (json['Veg'] != null) {
      veg = [];
      json['Veg'].forEach((v) {
        veg!.add(Veg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (veg != null) {
      data['Veg'] = veg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
