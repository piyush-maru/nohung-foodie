import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/model/add_customize_package_time.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:http/http.dart' as http;

import '../../model/login.dart';
import '../end_points.dart';

class SelectDateAndTimeModel extends ChangeNotifier {
  var weekly = true;
  var monthly = false;
  var numberOfDays = 0;
  var rate = '';
  var onDayRate = 0.00;

  updateRate(i, sunday, saturday) {
    if (weekly == true && sunday && saturday == true) {
      onDayRate = double.parse(i) / 7;
      notifyListeners();
      rate = i.toString();
      notifyListeners();
    } else if (weekly == true && sunday == true && saturday == false) {
      var local = onDayRate * 6;
      rate = local.toStringAsFixed(2);
      notifyListeners();
    } else if (weekly == true && sunday == false && saturday == true) {
      var local = onDayRate * 6;
      rate = local.toStringAsFixed(2);
      notifyListeners();
    } else if (weekly == true && sunday == false && saturday == false) {
      var local = onDayRate * 5;
      rate = local.toStringAsFixed(2);
      notifyListeners();
    } else if (weekly == false && saturday == true && sunday == true) {
      var local = onDayRate * 30;
      notifyListeners();
      rate = local.toStringAsFixed(2);
      notifyListeners();
    } else if (weekly == false && saturday == false && sunday == true) {
      var local = onDayRate * 26;
      notifyListeners();
      rate = local.toStringAsFixed(2);
      notifyListeners();
    } else if (weekly == false && saturday == true && sunday == false) {
      var local = onDayRate * 26;
      notifyListeners();
      rate = local.toStringAsFixed(2);
      notifyListeners();
    } else if (weekly == false && saturday == false && sunday == false) {
      var local = onDayRate * 22;
      notifyListeners();
      rate = local.toStringAsFixed(2);
      notifyListeners();
    }
    return i;
  }

  update(index) {
    if (index == 0) {
      weekly = true;
      notifyListeners();
      numberOfDays = 7;
      notifyListeners();
      monthly = false;
      notifyListeners();
    } else if (index == 1) {
      weekly = false;
      notifyListeners();
      monthly = true;
      notifyListeners();
      numberOfDays = 30;
      notifyListeners();
    }
  }

  Future<BeanAddCustomizeTime> addCustomizedPackageDateTime(
      {required String package_id,
      required String deliveryStartDate,
      required String deliveryEndDate,
      required String deliveryTime,
      required String mealPlan,
      required bool includingSaturday,
      required bool includingSunday}) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    print({
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      "package_id": package_id,
      "delivery_startdate": deliveryStartDate,
      "delivery_enddate": deliveryEndDate,
      "delivery_time": deliveryTime,
      "meal_plan": mealPlan,
      "including_saturday": includingSaturday ? "1" : "0",
      "including_sunday": includingSunday ? "1" : "0"
    });
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.addCustomizedPackageDateTime}"),
        body: {
          'token': "123456789",
          'user_id': userPersonalInfo.id,
          "package_id": package_id,
          "delivery_startdate": deliveryStartDate,
          "delivery_enddate": deliveryEndDate,
          "delivery_time": deliveryTime,
          "meal_plan": mealPlan,
          "including_saturday": includingSaturday ? "1" : "0",
          "including_sunday": includingSunday ? "1" : "0"
        });

    if (response.statusCode == 200) {
      BeanAddCustomizeTime data =
          BeanAddCustomizeTime.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

// addCustomizedPackageDateTimeHttp(
//   context,
//   package_id,
//   delivery_startdate,
//   delivery_enddate,
//   delivery_time,
//   meal_plan,
//   including_saturday,
//   including_sunday,
//   customization,
// ) async {
//   BeanLogin? user = await Utils.getUser();
//   await ApiProvider()
//       .addCustomizedPackageDateTime(
//     package_id,
//     delivery_startdate,
//     delivery_enddate,
//     delivery_time,
//     meal_plan,
//     including_saturday,
//     including_sunday,
//   )
//       .then((value) {
//     if (value['status'].toString() == 'true') {
//       Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => CheckoutScreen(
//             user_id: userPersonalInfo.id,
//             package_id: package_id,
//             mealplan: meal_plan,
//             customization: customization,
//           ),
//         ),
//       );
//     } else {}
//   });
// }
}
