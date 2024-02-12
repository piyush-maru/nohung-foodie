import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_app/model/home_screen_model/home_screen_model.dart';
import 'package:food_app/model/login.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:food_app/utils/helper_class.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/home_screen_model/top_packages_model.dart';
import '../../model/kitchen_filter_model/kitchen_filter_model.dart';
import '../end_points.dart';

class HomeScreenProvider extends ChangeNotifier {
  String _mealFor = '';
  String _cuisine = '';
  String _cuisineName = '';
  String _mealType = '';
  String _mealForPackage = '';
  String _mealPlan = '';
  String _rating = '';
  String _maxPrice = '';
  String _minPrice = '';

  String get mealFor => _mealFor;
  String get cuisine => _cuisine;
  String get cuisineName => _cuisineName;
  String get mealType => _mealType;
  String get mealForPackage => _mealForPackage;
  String get mealPlan => _mealPlan;
  String get rating => _rating;
  String get maxPrice => _maxPrice;
  String get minPrice => _minPrice;

  void resetFilters() {
    _mealFor = '';
    _cuisine = '';
    _mealType = '';
    _mealPlan = '';
    _mealForPackage = '';
    _cuisineName = '';

    // _ratingsTemp = '';
    _rating = '';
    notifyListeners();
  }

  void updateMealType(String value) {
    _mealType = value;

    notifyListeners();
  }

  void updateMealFor(String value) {
    _mealFor = value;
    _mealForPackage = Helper.getMealForList(value);

    notifyListeners();
  }

  void updateCuisine(
    String value,
  ) {
    _cuisine = value;
    // _cuisinePackage = Helper.getCuisineName(value);

    notifyListeners();
  }

  void updateCuisineName(
    String value,
  ) {
    _cuisineName = value;

    notifyListeners();
  }

  void updateMealPlan(String value) {
    _mealPlan = value;

    notifyListeners();
  }

  void updatePrice(String minPrice, String maxPrice) {
    _maxPrice = maxPrice;
    _minPrice = minPrice;
    notifyListeners();
  }

  var mealForFilter = '0';
  var cuisineFilter = '';
  var mealPlanFilter = '';
  var mealTypeFilter = '';
  var minFilter = 0.0;
  var maxFilter = 0.0;
  final log = Logger();

  double latitude = 0.0;
  double longitude = 0.0;
  var address;

  Future<HomeKitchen> getHomeScreenData({
    required String mealFor,
    required String cuisineType,
    required String mealType,
    required String mealPlan,
    required String minPrice,
    required String maxPrice,
    required String rating,
    required String customerLatitude,
    required String customerLongitude,
  }) async {
    http.Response response;
    try {
      UserPersonalInfo userPersonalInfo = await Utils.getUser();

      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.searchKitchen}"), body: {
        'token': "123456789",
        'customer_id': userPersonalInfo.id,
        'mealfor': mealFor,
        'cuisinetype': cuisineType,
        'mealtype': mealType.isEmpty ? "2" : mealType.isEmpty,
        'mealplan': mealPlan,
        'min_price': minPrice,
        'max_price': maxPrice,
        'rating': '',
        'customer_latitude': "17.4431103",
        'customer_longitude': "78.3869877"
      });
    } catch (e) {
      print(e.toString());
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.searchKitchen}"), body: {
        'token': "123456789",
        //'customer_id': /*userPersonalInfo.id.isEmpty?"":*/userPersonalInfo.id,
        'mealfor': mealFor,
        'cuisinetype': cuisineType,
        'mealtype': mealType,
        'mealplan': mealPlan,
        'min_price': minPrice,
        'max_price': maxPrice,
        'rating': '',
        'customer_latitude': "17.4431103",
        'customer_longitude': "78.3869877"
      });
    }

    if (response.statusCode == 200) {
      HomeKitchen data = HomeKitchen.fromJson(jsonDecode(response.body));
      // log.d(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<HomeKitchen> filteredKitchens(
      {required KitchenFilters filters}) async {
    http.Response response;
    final log = Logger();
    log.f({
      'token': "123456789",
      'mealfor': filters.mealfor,
      'cuisinetype': filters.cuisinetype,
      'mealtype': filters.mealtype,
      'mealplan': filters.mealplan,
      'min_price': filters.minPrice,
      'max_price': filters.maxPrice,
      'rating': filters.rating,
      'customer_latitude': "17.4431103",
      'customer_longitude': "78.3869877"
    });
    try {
      UserPersonalInfo userPersonalInfo = await Utils.getUser();

      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.searchKitchen}"), body: {
        'token': "123456789",
        'customer_id': userPersonalInfo.id,
        'mealfor': filters.mealfor,
        'cuisinetype': filters.cuisinetype,
        'mealtype': filters.mealtype,
        'mealplan': filters.mealplan,
        'min_price': filters.minPrice,
        'max_price': filters.maxPrice,
        'rating': filters.rating,
        'customer_latitude': "17.4431103",
        'customer_longitude': "78.3869877"
      });
    } catch (e) {
      print(e.toString());
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.searchKitchen}"), body: {
        'token': "123456789",
        //'customer_id': /*userPersonalInfo.id.isEmpty?"":*/userPersonalInfo.id,
        'mealfor': filters.mealfor,
        'cuisinetype': filters.cuisinetype,
        'mealtype': filters.mealtype,
        'mealplan': filters.mealplan,
        'min_price': filters.minPrice,
        'max_price': filters.maxPrice,
        'rating': filters.rating,
        'customer_latitude': "17.4431103",
        'customer_longitude': "78.3869877"
      });
    }

    if (response.statusCode == 200) {
      HomeKitchen data = HomeKitchen.fromJson(jsonDecode(response.body));

      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<List<TopPackagesData>> getTopPackages(
      {required String mealTypeFilter,
      required String mealForFilter,
      required String cuisineFilter}) async {
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getTopPackages}"), body: {
      'token': "123456789",
    });

    if (response.statusCode == 200) {
      TopPackages data = TopPackages.fromJson(jsonDecode(response.body));
      List<TopPackagesData> filteredList;
      filteredList = data.data.where((kitchen) {
        String mealtype = kitchen.mealType;

        return mealtype.contains(mealTypeFilter);
      }).toList();
      if (cuisineFilter.isNotEmpty) {
        filteredList = filteredList.where((kitchen) {
          // Remove instances of "meals"
          List<String> fetchedCuisineList = kitchen.cuisines.split(',');
          List<String> filterCuisineList = cuisineFilter.split(',');
          filterCuisineList = filterCuisineList
              .map((word) =>
                  word.replaceAll('North Indian Meals', 'North Indian'))
              .toList();
          filterCuisineList = filterCuisineList
              .map((word) =>
                  word.replaceAll('South Indian Meals', 'South Indian'))
              .toList();

          log.f('nikka ${filterCuisineList}');
          return fetchedCuisineList.any((e) => filterCuisineList.contains(e));
        }).toList();
      }

      if (mealForFilter.isNotEmpty) {
        filteredList = filteredList.where((kitchen) {
          List<String> fetchedMealForList = kitchen.mealFor.split(',');
          List<String> filterMealForList = mealForFilter.split(',');

          return fetchedMealForList.any((e) => filterMealForList.contains(e));
        }).toList();
      }

      return filteredList;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<void> getAddressFromLatLong(
      Position position, longtitudeIn, latitudeIn) async {
    latitude = longtitudeIn;
    notifyListeners();
    longitude = latitudeIn;
    address = "";
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    notifyListeners();
    Placemark place = placeMarks[0];
    notifyListeners();
    address =
        '${place.street}, ${place.subLocality}, ${place.locality},${place.country},${place.postalCode}';
    notifyListeners();
  }

  void FavUpdate(i, to) {
    notifyListeners();
  }
}
