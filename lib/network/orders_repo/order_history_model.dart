import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/login.dart';
import '../../model/orders/get_order_history.dart';
import '../../utils/Utils.dart';
import '../api_provider.dart';
import '../end_points.dart';

class OrderHistoryModel extends ChangeNotifier {
  var logger = Logger();

  GetOrderHistory? getOrderHistory;
  final List<Order> _orderHistory = [];
  bool _isLoading = false;

  List<Order> orderHistoryData() => _orderHistory;
  List<Order> _orderHistoryList = [];
  List<Order> get orderHistoryList => _orderHistoryList;
  bool get isLoading => _isLoading;

  void clearOrderHistoryList() {
    _orderHistoryList.clear();
  }

  void updatedLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> orderHistory({required String offset}) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getOrderHistory}"), body: {
      "token": "123456789",
      "offset": offset,
      "user_id": userPersonalInfo.id
    });

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      if (!decodedData['status']) {
        updatedLoading(false);
        return false;
      } else {
        GetOrderHistory data = GetOrderHistory.fromJson(jsonDecode(response.body));

        if (data.data!.orders != null) {
          _orderHistoryList = List.from(_orderHistoryList!)
            ..addAll(data.data!.orders!);
        }
        updatedLoading(false);
        return true;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }
}
