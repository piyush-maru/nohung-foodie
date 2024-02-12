import 'package:flutter/cupertino.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:http/http.dart' as http;

import '../../model/login.dart';
import '../end_points.dart';

class CancelOrderModel extends ChangeNotifier {
  Future<http.Response> cancelOrder(String orderItemId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.cancelOrderItem}"), body: {
      "token": "123456789",
      "orderitem_id": orderItemId,
      "user_id": userPersonalInfo.id
    });

    if (response.statusCode == 200) {
    } else {
      throw Exception("Something went wrong");
    }
    return response;
  }
}
