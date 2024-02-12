import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/cart_count_provider/cart_count_provider.dart';
import '../../model/cart_screen_class/cart_screen_model_class.dart';
import '../../model/cart_screen_class/update_cart.dart';
import '../../model/login.dart';
import '../../network/end_points.dart';
import '../../utils/Utils.dart';

class CartBillDetailsProvider extends ChangeNotifier {
  final cartCountProvider = CartCountModel();

  Future<GetCartDetailsModel> getCartBillDetails() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getCartDetails}"),
        body: {'token': "123456789", 'user_id': userPersonalInfo.id});
    final log = Logger();

    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body);
      if (!resBody["status"]) {
        return GetCartDetailsModel(
            data: CartDetailsData(
                pre_order_delivery_date: "",
                pre_order_delivery_fromtime: "",
                pre_order_delivery_totime: "",
                actualDeliveryCharge: '',
                actualPackagingCharges: "",
                cartItems: [],
                cartTotal: "",
                couponDiscount: "",
                deliveryCharge: "",
                kitchenDetailData: KitchenDetailData(),
                myLocation: MyLocation(
                    addressId: '',
                    address: "",
                    latitude: '',
                    longitude: '',
                    street: '',
                    landmark: '',
                    addressType: ''),
                packagingCharges: "",
                subTotal: "",
                taxAmount: "",
                walletBalance: ""),
            message: resBody["message"],
            status: resBody["status"]);
      }
      GetCartDetailsModel data =
          GetCartDetailsModel.fromJson(jsonDecode(response.body));

      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<BeanUpdateCart> updateCart(
      {required String cartId, required String type}) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.editCart}"), body: {
      "user_id": userPersonalInfo.id,
      "token": "123456789",
      "cart_id": cartId,
      "quantity": "1",
      "quantity_type": type,
    });
    notifyListeners();

    return BeanUpdateCart.fromJson(
      json.decode(response.body),
    );
  }
}
