import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/model/login.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/utils/helper_class.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/cart_screen_class/pre_order_dates.dart';
import '../../model/cart_screen_class/pre_order_time.dart';
import '../../model/update_pre_order_date_time/update_pre_order_date_time_model.dart';
import '../../utils/Utils.dart';
import '../end_points.dart';

class PreOrderModel extends ChangeNotifier {
  final log = Logger();
  Future<GetPreOrderDates> preOrderDates(String KitchenId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/get_pre_order_dates.php"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "kitchen_id": KitchenId
    });

    if (response.statusCode == 200) {
      GetPreOrderDates orderDates =
          GetPreOrderDates.fromJson(json.decode(response.body));
      return orderDates;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<GetPreOrderTime> preOrderTimes(String kitchenId, String date) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response =
        await http.post(Uri.parse("$baseUrl/get_pre_order_times.php"), body: {
      "token": "123456789",
      "kitchen_id": kitchenId,
      "user_id": userPersonalInfo.id,
      "date":
          date.isEmpty ? Helper.formatDateFromDateTime(DateTime.now()) : date
    });

    if (response.statusCode == 200) {
      log.f(json.decode(response.body)["data"]);

      final data = json.decode(response.body)["data"];
      if (data.isEmpty) {
        return GetPreOrderTime(
            message: "Empty",
            status: true,
            data: [PreOrderTime(text: "No Slots", value: "No Slots")]);
      } else {
        GetPreOrderTime orderTime =
            GetPreOrderTime.fromJson(json.decode(response.body));
        return orderTime;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<UpdatePreOrderDateTime> updatePreOrderDateAndTime({
    required String kitchenId,
    required String deliveryDate,
    required String deliveryFromTime,
    required String deliveryToTime,
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.updatePreOrderDateTime}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "kitchen_id": kitchenId.toString(),
      "delivery_date": deliveryDate,
      "delivery_from_time": deliveryFromTime,
      "delivery_to_time": deliveryToTime,
    });
    if (response.statusCode == 200) {
      return UpdatePreOrderDateTime.fromJson(
        json.decode(response.body),
      );
    } else {
      Exception("Something went wrong");
      return UpdatePreOrderDateTime(
          status: false, message: json.decode(response.body));
    }
  }
}
