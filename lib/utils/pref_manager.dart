import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/package_details_model/package_details_model.dart';
import '../network/kitchen_details/kitchen_details_model.dart';
import 'constants/app_constants.dart';

class PrefManager {
  /// Storing Meal Plan Info
  static void setMealPlanInfo(MealPlan data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spMealPlan, jsonEncode(data));
  }

  /// Retrieving Meal Plan Info
  static Future<MealPlan> getMealPlanInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(AppConstant.spMealPlan);

    return MealPlan.fromJson(json.decode(data!));
  }

  /// Storing subscription_order_prior_timing
  static void setSubscriptionPriorTiming(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spSubscriptionPriorTiming, jsonEncode(data));
  }

  /// Retrieving subscription_order_prior_timing
  static Future<String> getSubscriptionPriorTiming() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(AppConstant.spSubscriptionPriorTiming);

    return data ?? "";
  }

  /// Storing Package Details Info
  static void setPackageDetailsInfo(PackageDetailsData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.spPackageDetails, jsonEncode(data));
  }

  /// Retrieving Package Details Info
  static Future<PackageDetailsData> getPackageDetailsInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(AppConstant.spPackageDetails);

    return PackageDetailsData.fromJson(json.decode(data!));
  }

  static void putString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    return value ?? "";
  }

  static void putBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(key);
    return value ?? false;
  }

  static void setLang(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.lang, value);
  }

  static Future<String> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(AppConstant.lang);
    return value ?? "en";
  }

  static void clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
