import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/model/login.dart';
import 'package:food_app/model/orders/fav_orders_class.dart';
import 'package:http/http.dart' as http;

import '../../utils/Utils.dart';
import '../api_provider.dart';
import '../end_points.dart';

class FavOrdersModel extends ChangeNotifier {
  FavOrdersClass? favOrdersClass;
  final List<FavOrdersData?> _favOrders = [];

  List<FavOrdersData?> favOrders() => _favOrders;

  Future<FavOrdersClass?> getFavOrders() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getFavOrders}"),
        body: {'token': "123456789", 'user_id': userPersonalInfo.id});

    if (response.statusCode == 200) {
      FavOrdersClass orderData =
          FavOrdersClass.fromJson(jsonDecode(response.body));
      _favOrders.clear();
      _favOrders.addAll(orderData.data ?? []);
      return orderData;
    } else if (response.statusCode == 500) {
      throwIfNoSuccess('message');
    }
    return null;
  }

  Future<FavOrdersClass?> addFavOrders(String userId) async {
    var form = <String, dynamic>{};

    form['token'] = "123456789";
    form['user_id'] = userId;

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.addFavoriteOrder}"), body: form);

    Map<String, dynamic> map = json.decode(response.body);

    if (response.statusCode == 200) {
      var data = FavOrdersClass.fromJson(jsonDecode(response.body)["data"]);
      return data;
    } else if (response.statusCode == 500) {
      throwIfNoSuccess(map['message']);
    }
    return null;
  }
}
