import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/model/get_order_customisation_details.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:http/http.dart' as http;

import '../../model/login.dart';
import '../../utils/Utils.dart';

class GetOrderCustomizationDetailsModel extends ChangeNotifier {
  GetOrderCustomizeDetails? getOrderCustomizeDetail;

  final List<CustomizeDataFor?> _data = [];

  List<CustomizeDataFor?> orderDetails() => _data;

  Future<GetOrderCustomizeDetails> getOrderCustomizeDetails(
      String packageId, String orderItem, String day) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.GetOrderCustomizeItems}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "package_id": packageId,
      "order_item_id": orderItem,
      "day": day
    });

    if (response.statusCode == 200) {
      GetOrderCustomizeDetails details =
          GetOrderCustomizeDetails.fromJson(jsonDecode(response.body));
      notifyListeners();
      return details;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
