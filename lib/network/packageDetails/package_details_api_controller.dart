import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/cart_repo/cart_screen_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../model/cart_count_provider/cart_count_provider.dart';
import '../../model/package_details_model/package_details_model.dart';
import '../end_points.dart';
import '../pre_order/pre_order_provider.dart';

class PackageDetailsModel extends ChangeNotifier {
  var isLoading = false;
  CustomizationPackageDetailsModel? _packageDetails;
  var timings = [];

  CustomizationPackageDetailsModel get packageDetails => _packageDetails!;
  //PackageDetailsData? _packageDetailsForProceed;
  PackageDetailsData? _packageDetailsForProceed;

  PackageDetailsData? get packageDetailsForProceed => _packageDetailsForProceed;
  List<PackageDetail>? _menuItemProceed;

  List<PackageDetail> get menuItemProceed => _menuItemProceed!;
  final ApiProvider _apiProvider = ApiProvider();
  var rate = 0.0;

  Future<CustomizationPackageDetailsModel?> packageDetail(
      String packageId, String kitchenId, String mealfor) async {
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getPackageDetail}"), body: {
      'token': "123456789",
      'package_id': packageId,
      'kitchen_id': kitchenId,
      'meal_for': mealfor,
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
      context, kitchenId, mealplan, typeId, quantityType, i, index) async {
    final cartModel = Provider.of<CartScreenModel>(context, listen: false);
    final cartCountProvider =
        Provider.of<CartCountModel>(context, listen: false);
    final preOrderProvider = Provider.of<PreorderProvider>(context);

    await cartModel.resetCart().then((value) {
      cartCountProvider.checkCartCount(provider: preOrderProvider);

      /// ask Krishna sir that if the user hits start freash and goes to package and closes does this has to add to the cart or not
      //addToCart(context, kitchen_id, mealplan, type_id, quantity_type, i, index);
    });
  }
}
