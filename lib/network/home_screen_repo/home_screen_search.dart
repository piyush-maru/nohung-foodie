import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:http/http.dart' as http;
import '../../model/searchData/home_screen_search_model.dart';


class SearchHomeScreenModel extends ChangeNotifier {


  Future<HomeScreenSearch> getSearchData(String searchText) async {
    http.Response response = await http.post(
        Uri.parse("$baseUrl/search_kitchen_and_items.php"),
        body: {"token": "123456789", "search": searchText});

    if (response.statusCode == 200) {

      HomeScreenSearch screenSearch =
          HomeScreenSearch.fromJson(json.decode(response.body));
      print("------------------------->");
      notifyListeners();
      return screenSearch;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
