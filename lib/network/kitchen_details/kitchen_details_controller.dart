import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/login.dart';
import '../../model/offers_screen/offers_list_model.dart';
import '../../utils/Utils.dart';
import '../end_points.dart';

class KitchenDetailsModel extends ChangeNotifier {
  final log = Logger();
  String _cuisine = '';
  String _mealType = '';
  String get cuisine => _cuisine;
  String get mealType => _mealType;

  /// RESET FILTER
  void resetFilters() {
    _cuisine = '';
    _mealType = '';
    notifyListeners();
  }

  void updateMealType(String value) {
    _mealType = value;

    notifyListeners();
  }

  void updateCuisine(
    String value,
  ) {
    _cuisine = value;

    notifyListeners();
  }

  Future<KitchenDetailsApi> getKitchenDetailsData({
    required String kitchenId,
    required String mealPlan,
    required String mealType,
    required String cuisineType,
    required String mealFor,
  }) async {
    http.Response response;
    try {
      UserPersonalInfo userPersonalInfo = await Utils.getUser();
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
        'token': "123456789",
        'kitchenid': kitchenId,
        'meal_plan': mealPlan,
        'meal_type': mealType,
        'cuisine_type': cuisineType,
        'meal_for': mealFor,
        'customer_id': userPersonalInfo.id
      });
    } catch (e) {
      print("e.toString()");
      print(e.toString());
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
        'token': "123456789",
        'kitchenid': kitchenId,
        'meal_plan': mealPlan,
        'meal_type': mealType,
        'cuisine_type': cuisineType,
        'meal_for': mealFor,
        // 'customer_id': userPersonalInfo.id
      });
    }
    if (response.statusCode == 200) {
      KitchenDetailsApi data =
          KitchenDetailsApi.fromJson(jsonDecode(response.body));

      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  /// GET PRE ORDER LIST

  Future<List<OrderNowDetail>?> getPreOrderList({
    required String kitchenId,
  }) async {
    http.Response response;
    try {
      UserPersonalInfo userPersonalInfo = await Utils.getUser();
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
        'token': "123456789",
        'kitchenid': kitchenId,
        'meal_plan': 'order_now',
        'meal_type': _mealType,
        'cuisine_type': _cuisine,
        'customer_id': userPersonalInfo.id
      });
    } catch (e) {
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
        'token': "123456789",
        'kitchenid': kitchenId,
        'meal_plan': 'order_now',
        'meal_type': _mealType,
        'cuisine_type': _cuisine,
      });
    }

    if (response.statusCode == 200) {
      KitchenDetailsApi data =
          KitchenDetailsApi.fromJson(jsonDecode(response.body));
      final preOrderList = data.data.first.orderNowDetail;

      return preOrderList;
    } else {
      throw Exception('Something went wrong');
    }
  }

  /// GET PACKAGES LIST

  Future<KitchenDetailsApi> getPackagesList({
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
        'meal_type': _mealType,
        'cuisine_type': _cuisine,
        'customer_id': userPersonalInfo.id
      });
    } catch (e) {
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
        'token': "123456789",
        'kitchenid': kitchenId,
        'meal_plan': 'subscription',
        'meal_type': _mealType,
        'cuisine_type': _cuisine,
      });
    }

    if (response.statusCode == 200) {
      KitchenDetailsApi data =
          KitchenDetailsApi.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  /// GET OFFER LISTs

  Future<OffersList> getOfferList({
    required String kitchenId,
  }) async {
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getKitchenOffersList}"), body: {
      'token': "123456789",
      'kitchen_id': kitchenId,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      if (data.isEmpty) {
        OffersList model = OffersList(
          message: jsonDecode(response.body)['message'],
          status: jsonDecode(response.body)['status'],
        );
        return model;
      } else {
        OffersList model = OffersList.fromJson(jsonDecode(response.body));
        return model;
      }
    } else {
      throw Exception('Something went wrong');
    }
  }
}
