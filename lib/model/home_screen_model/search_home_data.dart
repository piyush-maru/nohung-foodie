class BeanSearchData {
  bool? status;
  String? message;
  List<Data2>? data;

  BeanSearchData({this.status, this.message, this.data});

  BeanSearchData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(Data2.fromJson(v));
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

class Data2 {
  List<RecentSearch>? recentSearch;
  List<Trending>? trending;
  List<KitchenRecommendation>? kitchenRecommendation;

  Data2({this.recentSearch, this.trending, this.kitchenRecommendation});

  Data2.fromJson(Map<String, dynamic> json) {
    if (json['recent_search'] != null) {
      recentSearch = [];

        json['recent_search'].forEach((v) {
          recentSearch!.add(RecentSearch.fromJson(v));
        });
    }
    if (json['trending'] != null) {
      trending = [];
      json['trending'].forEach((v) {
        trending!.add(Trending.fromJson(v));
      });
    }
    if (json['kitchen_recommandation'] != null) {
      kitchenRecommendation = [];

        json['kitchen_recommandation'].forEach((v) {
          kitchenRecommendation!.add(KitchenRecommendation.fromJson(v));
        });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (recentSearch != null) {
      data['recent_search'] =
          recentSearch!.map((v) => v.toJson()).toList();
    }
    if (trending != null) {
      data['trending'] = trending!.map((v) => v.toJson()).toList();
    }
    if (kitchenRecommendation != null) {
      data['kitchen_recommandation'] =
          kitchenRecommendation!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword'] = keyword;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kitchenname'] = kitchenname;
    return data;
  }
}

class KitchenRecommendation {
  String? kitchenId;
  String? kitchenName;

  String? address;
  String? cuisineType;
  String? mealType;
  String? discount;
  String? image;
  String? averageRating;
  String? totalReview;
  String? time;
  String? isFavourite;


  KitchenRecommendation(
      {this.kitchenId,
      this.kitchenName,
      this.address,
      this.cuisineType,
      this.mealType,
      this.discount,
      this.image,
      this.averageRating,
      this.totalReview,
      this.isFavourite,
      this.time});

  KitchenRecommendation.fromJson(Map<String, dynamic> json) {
    kitchenId = json['kitchen_id'];
    kitchenName = json['kitchenname'];
    address = json['address'];
    cuisineType = json['cuisinetype'];
    mealType = json['mealtype'];
    discount = json['discount'];
    image = json['image'];
    isFavourite = json['is_favourite'];
    averageRating = json['average_rating'];
    totalReview = json['total_review'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kitchen_id'] = kitchenId;
    data['kitchenname'] = kitchenName;
    data['address'] = address;
    data['cuisinetype'] = cuisineType;
    data['mealtype'] = mealType;
    data['discount'] = discount;
    data['image'] = image;
    data['is_favourite'] = isFavourite;
    data['average_rating'] = averageRating;
    data['total_review'] = totalReview;
    data['time'] = time;
    return data;
  }
}
