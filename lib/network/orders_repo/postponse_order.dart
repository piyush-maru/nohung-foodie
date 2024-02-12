import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/get_postpone_menu_details.dart';
import '../../model/login.dart';
import '../../utils/Utils.dart';
import '../api_provider.dart';
import '../end_points.dart';

class PostPoneOrderModel extends ChangeNotifier {
  GetPostponeMenuDetails? getPostponeMenuDetails;
  final List<GetPostponeMenuDetails> _postponeMenu = [];

  List<GetPostponeMenuDetails> postponeMenuData() => _postponeMenu;

  Future<GetPostponeMenuDetails> getPostPoneMenu(String orderItemId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.postponemenuItems}"), body: {
      'token': '123456789',
      'user_id': userPersonalInfo.id,
      'order_item_id': orderItemId
    });

    if (response.statusCode == 200) {
      GetPostponeMenuDetails postponeMenuDetails =
          GetPostponeMenuDetails.fromJson(jsonDecode(response.body));
      notifyListeners();
      return postponeMenuDetails;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> postponeOrder(
      String orderItemId, String isWalletChecked) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.postponeOrder}"), body: {
      'token': '123456789',
      'user_id': userPersonalInfo.id,
      'order_item_id': orderItemId,
      'iswalletchecked': isWalletChecked,
    });
    if (response.statusCode == 200) {
      print(
          "==============================postponeOrder>${jsonDecode(response.body)}");
      notifyListeners();
    } else {
      throw Exception("Something went wrong");
    }
    return response;
  }
}
