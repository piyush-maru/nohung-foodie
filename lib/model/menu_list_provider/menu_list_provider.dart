import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../network/api_provider.dart';
import '../../network/end_points.dart';
import '../../network/kitchen_details/kitchen_details_model.dart';

class MenuListProvider extends ChangeNotifier {
  final log = Logger();
  AutoScrollController? controller;
  List<OrderNowDetail> _menuList = <OrderNowDetail>[];
  List<OrderNowDetail> get menuList => _menuList;
  bool _isMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen;
  int _selectedMenuIndex = 0;
  int get selectedMenuIndex => _selectedMenuIndex;

  void updateMenuStatus({required bool value}) {
    _isMenuOpen = value;
    notifyListeners();
  }

  void updateSelectedMenuIndex({required int index}) {
    _selectedMenuIndex = index;
  }

  Future<List<OrderNowDetail>?> getPreOrderDetails({
    required String kitchenId,
  }) async {
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
      'token': "123456789",
      'kitchenid': kitchenId,
      'meal_plan': 'order_now',
      'meal_type': '',
      'cuisine_type': '',
      'meal_for': '',
    });

    if (response.statusCode == 200) {
      final res = KitchenDetailsApi.fromJson(jsonDecode(response.body));
      return res.data.first.orderNowDetail;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
