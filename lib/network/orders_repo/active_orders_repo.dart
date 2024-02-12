import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/model/orders/get_active_order.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/login.dart';
import '../../utils/Utils.dart';
import '../api_provider.dart';
import '../end_points.dart';

class ActiveOrdersModel extends ChangeNotifier {
  final log = Logger();
  GetActiveOrders? getActiveOrder;
  final List<ActiveOrdersData> _activeOrder = [];

  List<ActiveOrdersData> activeOrders() => _activeOrder;

  Future<GetActiveOrders> getActiveOrders() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
      Uri.parse("$baseUrl/${EndPoints.getActiveOrders}"),
      body: {'token': "123456789", 'user_id': userPersonalInfo.id},
    );
    print("------------------------->${userPersonalInfo.id}");
    if (response.statusCode == 200) {
      GetActiveOrders orders =
          GetActiveOrders.fromJson(jsonDecode(response.body));
      //_activeOrder.clear();
      //_activeOrder.addAll(orders.data);
      notifyListeners();

      return orders;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> addToFav(String orderId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.addFavoriteOrder}"), body: {
      "token": "123456789",
      "userid": userPersonalInfo.id,
      "orderid": orderId
    });

    if (response.statusCode == 200) {
    } else {
      throw Exception("Something went wrong");
    }
    return response;
  }

  Future<http.Response> removeFromFav(String OrderId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.removeFavoriteOrder}"), body: {
      "token": "123456789",
      "userid": userPersonalInfo.id,
      "orderid": OrderId
    });
    if (response.statusCode == 200) {
    } else {
      throw Exception("Something went wrong");
    }
    return response;
  }
}
