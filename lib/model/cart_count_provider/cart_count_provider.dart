import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/login.dart';
import '../../network/end_points.dart';
import '../../network/pre_order/pre_order_provider.dart';
import '../../utils/Utils.dart';

class CartCountModel extends ChangeNotifier {
  final log = Logger();

  bool get isCartEmpty => _isCartEmpty;
  bool _isCartEmpty = true;
  String get cartCount => _cartCount;
  String _cartCount = '';

  void checkCartCount({int? count, required PreorderProvider provider}) async {
    if (count != null) {
      if (count > 0) {
        _isCartEmpty = false;
        _cartCount = count.toString();
      } else {
        provider.resetData();

        _isCartEmpty = true;

        _cartCount = count.toString();
      }

      notifyListeners();
    } else {
      http.Response response;

      try {
        UserPersonalInfo userPersonalInfo = await Utils.getUser();

        response = await http.post(
            Uri.parse("$baseUrl/${EndPoints.getCartItemsCount}"),
            body: {'token': "123456789", 'user_id': userPersonalInfo.id});
      } catch (e) {
        print(e.toString());
        return;
      }

      if (response.statusCode == 200) {
        final resBody = jsonDecode(response.body);

        if (resBody["status"]) {
          final cartCount = resBody["data"]["cart_count"];

          if (cartCount > 0) {
            _isCartEmpty = false;
            _cartCount = cartCount.toString();
          } else {
            provider.resetData();

            _isCartEmpty = true;
            _cartCount = cartCount.toString();
          }

          notifyListeners();
        } else {
          provider.resetData();

          _isCartEmpty = true;
          notifyListeners();
        }
      }
    }
  }
}
