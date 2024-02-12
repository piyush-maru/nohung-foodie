import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/model/get_delivery_time.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:http/http.dart' as http;

class GetDeliveryTimeModel extends ChangeNotifier {
  GetDeliveryTime? deliveryTime;

  final List<GetDeliveryTime> _deliveryTime = [];

  List<GetDeliveryTime> deliveryTimings() => _deliveryTime;

  Future<GetDeliveryTime> getDeliveryTime(String kitchenId,String pId) async {
    final http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getDeliveryTime}"),
        body: {'token': "123456789",
          'kitchen_id': kitchenId,
          "package_id": pId,
          //"mealfor":mealFor
        });
    print("======================>${pId}");
    if (response.statusCode == 200) {
      GetDeliveryTime getTime = GetDeliveryTime.fromJson(jsonDecode(response.body));
notifyListeners();
      return getTime;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
