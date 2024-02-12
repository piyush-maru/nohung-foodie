import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/model/orders/get_order_history_detail.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/login.dart';
import '../../utils/Utils.dart';

class ActiveOrderCustomizationModel extends ChangeNotifier {
  GetOrderHistoryDetail? getOrderHistoryDetail;
  final log = Logger();
  final List<OrderDetailsModel?> _orderHistoryDetail = [];

  List<OrderDetailsModel?> orderHistoryDetails() => _orderHistoryDetail;

  Future<GetOrderHistoryDetail?> gettingOrderHistoryDetail(
      String orderId) async {

    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    log.t({
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      'order_id': orderId
    });
    print("======================)))))>${orderId}");
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getOrderHistoryDetails}"), body: {
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      'order_id': orderId
    });
    if (response.statusCode == 200) {
      GetOrderHistoryDetail history =
          GetOrderHistoryDetail.fromJson(jsonDecode(response.body));
      log.f(history.data?.orderId);
      log.f(history.data?.items?.first.orderItemId);//history.data.first.orderItemsId
      _orderHistoryDetail.clear();
      //_orderHistoryDetail.addAll(history.data);//history.data
      notifyListeners();
      return history;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
