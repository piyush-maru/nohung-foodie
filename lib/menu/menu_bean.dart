
class MenuBean {
  bool? status;
  String? message;
  Data? data;

  MenuBean({this.status, this.message, this.data});

  MenuBean.fromJson(Map<String, dynamic> json) {
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
  String? mealName;
  Map<String,List<MealType>>? mealTypes={};

  Breakfast({this.mealTypes,this.mealName});

  Breakfast.fromJson(Map<String, dynamic>? json) {
    if(json!=null)
    {
      int firstTime=0;
      json.forEach((key, value) {
       if(firstTime==0) {
         mealName=key;
       }
       firstTime+=1;
        List<MealType> meals=[];

        json[key].forEach((v) {
          meals.add(MealType.fromJson(v));

        });
        mealTypes![key]=meals;
      });
    }
    else
    {
      mealTypes={};
    }
  }

  Map<String, dynamic>? toJson() {
    Map<String, dynamic>? data = {};
    if (mealTypes!.isNotEmpty) {
      data=mealTypes;
    }
    return data;
  }
}

class MealType {
  String? image;
  String? price;
  String? name;

  MealType({this.image, this.price, this.name});

  MealType.fromJson(Map<String, dynamic> json) {
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
  String? mealName;
  Map<String,List<MealType>>? mealTypes={};

  Lunch({this.mealTypes,this.mealName});

  Lunch.fromJson(Map<String, dynamic>? json) {
    if(json!=null)
    {
      int firstTime=0;
      json.forEach((key, value) {
        if(firstTime==0) {
          mealName=key;
        }
        firstTime+=1;
        List<MealType> meals=[];

        json[key].forEach((v) {
          meals.add(MealType.fromJson(v));

        });
        mealTypes![key]=meals;
      });
    }
    else
    {
      mealTypes={};
    }
  }

  Map<String, dynamic>? toJson() {
    Map<String, dynamic>? data = {};
    if (mealTypes!.isNotEmpty) {
      data=mealTypes;
    }
    return data;
  }
}