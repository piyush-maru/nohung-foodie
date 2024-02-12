class CuisineTypesModel {
  final List<Cuisines>? data;

  CuisineTypesModel({
    this.data,
  });

  factory CuisineTypesModel.fromJson(Map<String, dynamic> json) =>
      CuisineTypesModel(
        data: json["data"] == null
            ? []
            : List<Cuisines>.from(
                json["data"]!.map((x) => Cuisines.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Cuisines {
  final String? name;
  final Menu? package;
  final Menu? menu;

  Cuisines({
    this.name,
    this.package,
    this.menu,
  });

  factory Cuisines.fromJson(Map<String, dynamic> json) => Cuisines(
        name: json["name"],
        package:
            json["package"] == null ? null : Menu.fromJson(json["package"]),
        menu: json["menu"] == null ? null : Menu.fromJson(json["menu"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "package": package?.toJson(),
        "menu": menu?.toJson(),
      };
}

class Menu {
  final String? key;
  final String? value;

  Menu({
    this.key,
    this.value,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
