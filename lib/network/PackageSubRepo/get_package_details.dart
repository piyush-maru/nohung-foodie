import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:food_app/network/cart_repo/cart_screen_model.dart';
import 'package:food_app/utils/pref_manager.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../model/package_details_model/package_details_model.dart';
import '../api_provider.dart';
import '../end_points.dart';
import '../kitchen_details/kitchen_details_model.dart';

class PackageDetailModel extends ChangeNotifier {
  var timings = [];
  var rate = 0.0;
  PackageDetailsData? get packageDetailsData => _packageDetailsData;
  PackageDetailsData? _packageDetailsData;
  MealPlan? get mealPlan => _mealPlan;
  MealPlan? _mealPlan;

  void updatePackageDetailsData(PackageDetailsData data) {
    PrefManager.setPackageDetailsInfo(data);
    // notifyListeners();
  }

  void updateMealPlan(MealPlan data) {
    PrefManager.setMealPlanInfo(data);
    // notifyListeners();
  }

  Future<PackageDetailsData> getPackageDetailsData() async {
    return await PrefManager.getPackageDetailsInfo();
  }

  Future<MealPlan> getMealPlan() async {
    return await PrefManager.getMealPlanInfo();
  }

  Future<CustomizationPackageDetailsModel> packageDetail(
      {required String package_id,
      required String kitchen_id,
      required String mealFor}) async {
    print({
      'token': "123456789",
      'package_id': package_id,
      'kitchen_id': kitchen_id,
      'meal_for': mealFor,
    });
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getPackageDetail}"), body: {
      'token': "123456789",
      'package_id': package_id,
      'kitchen_id': kitchen_id,
      'meal_for': mealFor,
    });

    if (response.statusCode == 200) {
      CustomizationPackageDetailsModel data =
          CustomizationPackageDetailsModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  selectTimings(time) {
    if (timings.contains(time)) {
      timings.clear();
      notifyListeners();
    } else {
      timings.clear();
      timings.add(time);
      notifyListeners();
    }
  }

  updateRate(days) {
    // rate = double.parse(packageDetailsForProceed?.price.toString()) *
    double.parse(days);
    notifyListeners();
  }

  resetCart(
      context, kitchenId, mealPlan, typeId, quantityType, i, index) async {
    final cartModel = Provider.of<CartScreenModel>(context, listen: false);
    await cartModel.resetCart().then((value) {
      /// ask Krishna sir that if the user hits start freash and goes to package and closes does this has to add to the cart or not
      //addToCart(context, kitchen_id, mealplan, type_id, quantity_type, i, index);
    });
  }
}
