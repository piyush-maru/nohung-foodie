import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:http/http.dart' as http;

import '../../model/login.dart';
import '../../utils/Utils.dart';

class RateOrderModel extends ChangeNotifier {
  var ratingFilter = 2.5;
  updateRating(rating) {
    ratingFilter = rating;
    notifyListeners();
  }
  Future<http.Response> rateOrder(
      BuildContext context,
      String KitchenId,
      String orderId,
      double rating,
      String foodQuantity,
      String message,
      String taste,
      String quantity) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.rateOrder}"), body: {
      "token": "123456789",
      "kitchen_id": KitchenId,
      "customer_id": userPersonalInfo.id,
      "order_id": orderId,
      "rating": rating,
      "foodquality": foodQuantity,
      "message": message,
      "taste": taste,
      "quantity": quantity
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.body)));
      return response;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
