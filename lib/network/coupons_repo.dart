import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:http/http.dart' as http;

import '../model/coupon_code/coupons_model.dart';

class CouponModel extends ChangeNotifier {
  final List<Coupon> _coupons = [];

  List<Coupon> getAllCoupons() => _coupons;

  Future<http.Response> getCoupons(String kitchenId) async {
    final response = await http.post(Uri.parse("${baseUrl}get_coupons.php"),
        body: kitchenId);

    if (response.statusCode == 200) {
      List<Coupon> getCoupon = [];
      for (final coupon in jsonDecode(response.body)["data"]) {
        getCoupon.add(Coupon.fromJson(coupon));
        _coupons.clear();
        _coupons.addAll(getCoupon);
        notifyListeners();
      }
      return response;
    } else {
      throw Exception("Could not load");
    }
  }
}
