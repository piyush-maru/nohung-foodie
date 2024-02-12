import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_model.dart';
import 'package:http/http.dart' as http;

import '../../model/login.dart';
import '../../utils/Utils.dart';
import '../end_points.dart';

class SubscriptionMealTypesResponse {
  final bool isBreakfastEmpty;
  final bool isDinnerEmpty;
  final bool isLunchEmpty;
  final int mealTypeIndex;

  const SubscriptionMealTypesResponse({
    required this.isBreakfastEmpty,
    required this.isDinnerEmpty,
    required this.isLunchEmpty,
    required this.mealTypeIndex,
  });
}

class SubscriptionProvider extends ChangeNotifier {
  Future<SubscriptionMealTypesResponse> getSubscriptionDetailsList({
    required String kitchenId,
  }) async {
    http.Response response;
    try {
      UserPersonalInfo userPersonalInfo = await Utils.getUser();
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
        'token': "123456789",
        'kitchenid': kitchenId,
        'meal_plan': 'subscription',
        'meal_type': '',
        'cuisine_type': '',
        'customer_id': userPersonalInfo.id
      });
    } catch (e) {
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
        'token': "123456789",
        'kitchenid': kitchenId,
        'meal_plan': 'subscription',
        'meal_type': '',
        'cuisine_type': '',
      });
    }
    if (response.statusCode == 200) {
      final res = KitchenDetailsApi.fromJson(jsonDecode(response.body));
      final subscriptionPackageDetail = res.data.first.subscriptionDetail;

      if (subscriptionPackageDetail!.breakfast!.isEmpty) {
        if (subscriptionPackageDetail!.lunch!.isEmpty) {
          if (subscriptionPackageDetail!.dinner!.isEmpty) {
            return SubscriptionMealTypesResponse(
                isBreakfastEmpty: subscriptionPackageDetail!.breakfast!.isEmpty,
                isDinnerEmpty: subscriptionPackageDetail!.dinner!.isEmpty,
                isLunchEmpty: subscriptionPackageDetail!.lunch!.isEmpty,
                mealTypeIndex: -1);
          } else {
            return SubscriptionMealTypesResponse(
                isBreakfastEmpty: subscriptionPackageDetail!.breakfast!.isEmpty,
                isDinnerEmpty: subscriptionPackageDetail!.dinner!.isEmpty,
                isLunchEmpty: subscriptionPackageDetail!.lunch!.isEmpty,
                mealTypeIndex: 2);
          }
        } else {
          return SubscriptionMealTypesResponse(
              isBreakfastEmpty: subscriptionPackageDetail!.breakfast!.isEmpty,
              isDinnerEmpty: subscriptionPackageDetail!.dinner!.isEmpty,
              isLunchEmpty: subscriptionPackageDetail!.lunch!.isEmpty,
              mealTypeIndex: 1);
        }
      } else {
        return SubscriptionMealTypesResponse(
            isBreakfastEmpty: subscriptionPackageDetail!.breakfast!.isEmpty,
            isDinnerEmpty: subscriptionPackageDetail!.dinner!.isEmpty,
            isLunchEmpty: subscriptionPackageDetail!.lunch!.isEmpty,
            mealTypeIndex: 0);
      }
    } else {
      throw Exception('Something went wrong');
    }
  }
}
