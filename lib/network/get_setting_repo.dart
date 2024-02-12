import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/model/get_settings_model.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:food_app/utils/pref_manager.dart';
import 'package:http/http.dart' as http;

class GetSettingModel extends ChangeNotifier {
  GetSetting? getSetting;
  String _subscription_order_prior_timing = '';
  String get subscription_order_prior_timing =>
      _subscription_order_prior_timing;
  Future<GetSetting> getSettings() async {
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getSetting}"),
        body: {"token": "123456789"});
    if (response.statusCode == 200) {
      GetSetting get = GetSetting.fromJson(json.decode(response.body));

      PrefManager.setSubscriptionPriorTiming(
          get.data.subscriptionOrderPriorTiming);
      _subscription_order_prior_timing = get.data.subscriptionOrderPriorTiming;
      print(
          'nikhil setSubscriptionPriorTiming ${get.data.subscriptionOrderPriorTiming}');
      return get;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
