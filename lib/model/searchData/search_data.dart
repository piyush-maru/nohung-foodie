// To parse this JSON data, do
//
//     final searchData = searchDataFromJson(jsonString);

import 'dart:convert';

SearchData searchDataFromJson(String str) => SearchData.fromJson(json.decode(str));

String searchDataToJson(SearchData data) => json.encode(data.toJson());

/*class SearchData {
  SearchData({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
   required  this.recentSearch,
   required  this.trending,
   required  this.kitchenRecommandation,
  });

  List<String> recentSearch;
  List<Trending> trending;
  List<String> kitchenRecommandation;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    recentSearch: List<String>.from(json["recent_search"].map((x) => x)),
    trending: List<Trending>.from(json["trending"].map((x) => Trending.fromJson(x))),
    kitchenRecommandation: List<String>.from(json["kitchen_recommandation"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "recent_search": List<dynamic>.from(recentSearch.map((x) => x)),
    "trending": List<dynamic>.from(trending.map((x) => x.toJson())),
    "kitchen_recommandation": List<dynamic>.from(kitchenRecommandation.map((x) => x)),
  };
}

class Trending {
  Trending({
    required this.kitchenname,
  });

  String kitchenname;

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
    kitchenname: json["kitchenname"],
  );

  Map<String, dynamic> toJson() => {
    "kitchenname": kitchenname,
  };
}*/

class SearchData {
  bool? status;
  String? message;
  List<Data>? data;

  SearchData({this.status, this.message, this.data});

  SearchData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<RecentSearch>? recentSearch;
  List<Trending>? trending;
  List<String>? kitchenRecommandation;

  Data({this.recentSearch, this.trending, this.kitchenRecommandation});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recent_search'] != null) {
      recentSearch = <RecentSearch>[];
      json['recent_search'].forEach((v) {
        recentSearch!.add(new RecentSearch.fromJson(v));
      });
    }
    if (json['trending'] != null) {
      trending = <Trending>[];
      json['trending'].forEach((v) {
        trending!.add(new Trending.fromJson(v));
      });
    }
    kitchenRecommandation = json['kitchen_recommandation'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentSearch != null) {
      data['recent_search'] =
          this.recentSearch!.map((v) => v.toJson()).toList();
    }
    if (this.trending != null) {
      data['trending'] = this.trending!.map((v) => v.toJson()).toList();
    }
    data['kitchen_recommandation'] = this.kitchenRecommandation;
    return data;
  }
}

class RecentSearch {
  String? keyword;

  RecentSearch({this.keyword});

  RecentSearch.fromJson(Map<String, dynamic> json) {
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyword'] = this.keyword;
    return data;
  }
}

class Trending {
  String? kitchenname;

  Trending({this.kitchenname});

  Trending.fromJson(Map<String, dynamic> json) {
    kitchenname = json['kitchenname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kitchenname'] = this.kitchenname;
    return data;
  }
}
