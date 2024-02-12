import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/address/default_address.dart';
import '../../model/login.dart';
import '../../utils/utils.dart';
import '../api_provider.dart';
import '../end_points.dart';

class GetDefaultAddressModel extends ChangeNotifier {
  Future<DefaultAddress?> getDefaultAddress() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getDefaultAddress}"),
        body: {"token": "123456789", "user_id": userPersonalInfo.id});
    if (response.statusCode == 200) {
      notifyListeners();
      return DefaultAddress.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something went wrong");
    }
  }
}
