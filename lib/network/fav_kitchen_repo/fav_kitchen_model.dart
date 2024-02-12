import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../model/fav_kitchen_classes/fav_kitchen.dart';
import '../../model/fav_kitchen_classes/get_fav_kitchen.dart';
import '../../model/fav_kitchen_classes/remove_kitchen.dart';
import '../../model/login.dart';
import '../../utils/Utils.dart';
import '../api_provider.dart';
import '../end_points.dart';

class FavKitchenModel extends ChangeNotifier {
  Future<GetFavKitchen> getFavKitchen() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    print("$baseUrl/get_favorite_kitchens.php");
    print({"token": "123456789", "userid": userPersonalInfo.id});
    http.Response response = await http.post(
        Uri.parse("$baseUrl/get_favorite_kitchens.php"),
        body: {"token": "123456789", "userid": "${userPersonalInfo.id}"});
    if (response.statusCode == 200) {
      GetFavKitchen getFavKitchen =
          GetFavKitchen.fromJson(json.decode(response.body));
      return getFavKitchen;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<BeanFavKitchen?> favKitchenHttp(kitchenId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.addFavoriteKitchen}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      "kitchenid": kitchenId,
    });
    if (response.statusCode == 200) {
      BeanFavKitchen data = BeanFavKitchen.fromJson(jsonDecode(response.body));

      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<BeanRemoveKitchen?> removeKitchenHttp(kitchenId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.removeKitchen}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      "kitchenid": kitchenId
    });

    if (response.statusCode == 200) {
      BeanRemoveKitchen data = BeanRemoveKitchen.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
