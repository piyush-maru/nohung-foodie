import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/get_offline_dates.dart';
import '../api_provider.dart';

class GetOfflineDatesModel extends ChangeNotifier {
  Future<GetOfflineDates> getOfflineDates(String kitchenId) async {
    http.Response response =
        await http.post(Uri.parse("$baseUrl/get_offline_dates.php"),body: {
          "token":"123456789",
          "kitchen_id":kitchenId
        });
    if (response.statusCode == 200) {
      GetOfflineDates getOfflineDate =
          GetOfflineDates.fromJson(jsonDecode(response.body));
      return getOfflineDate;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
