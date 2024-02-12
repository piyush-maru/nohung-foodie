//
//
// class HomeScreenSearch {
//   bool status;
//   String message;
//   List<HomeScreenSearchData> data;
//
//   HomeScreenSearch({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory HomeScreenSearch.fromJson(Map<String, dynamic> json) => HomeScreenSearch(
//     status: json["status"],
//     message: json["message"],
//     data: List<HomeScreenSearchData>.from(json["data"].map((x) => HomeScreenSearchData.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class HomeScreenSearchData {
//   Type type;
//   String name;
//   String description;
//   String image;
//
//   HomeScreenSearchData({
//     required this.type,
//     required this.name,
//     required this.description,
//     required this.image,
//   });
//
//   factory HomeScreenSearchData.fromJson(Map<String, dynamic> json) => HomeScreenSearchData(
//     type: typeValues.map[json["type"]]!,
//     name: json["name"],
//     description: json["description"],
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "type": typeValues.reverse[type],
//     "name": name,
//     "description": description,
//     "image": image,
//   };
// }
//
// enum Type { MENU, KITCHEN, PACKAGE }
//
// final typeValues = EnumValues({
//   "kitchen": Type.KITCHEN,
//   "menu": Type.MENU,
//   "package": Type.PACKAGE
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

class HomeScreenSearch {
  bool status;
  String message;
  List<HomeScreenSearchData> data;

  HomeScreenSearch({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeScreenSearch.fromJson(Map<String, dynamic> json) => HomeScreenSearch(
    status: json["status"],
    message: json["message"],
    data: List<HomeScreenSearchData>.from(json["data"].map((x) => HomeScreenSearchData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class HomeScreenSearchData {
  String kitchenId;
  Type type;
  String name;
  String description;
  String image;

  HomeScreenSearchData({
    required this.kitchenId,
    required this.type,
    required this.name,
    required this.description,
    required this.image,
  });

  factory HomeScreenSearchData.fromJson(Map<String, dynamic> json) => HomeScreenSearchData(
    kitchenId: json["kitchenid"],
    type: typeValues.map[json["type"]]!,
    name: json["name"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "kitchenid": kitchenId,
    "type": typeValues.reverse[type],
    "name": name,
    "description": description,
    "image": image,
  };
}

enum Type { MENU, PACKAGE, KITCHEN }

final typeValues = EnumValues({
  "kitchen": Type.KITCHEN,
  "menu": Type.MENU,
  "package": Type.PACKAGE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
