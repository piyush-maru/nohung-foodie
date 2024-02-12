import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../model/cart_screen_class/add_cart.dart';
import '../../model/cart_screen_class/apply_promo.dart';
import '../../model/cart_screen_class/cart_screen_model_class.dart';
import '../../model/coupon_code/apply_coupon_code.dart';
import '../../model/create_order.dart';
import '../../model/login.dart';
import '../../model/offers_screen/offers_list_model.dart';
import '../../models/add_order_response_model.dart';
import '../../utils/Utils.dart';
import '../end_points.dart';

class CartScreenModel extends ChangeNotifier {
  final log = Logger();

  String _deliveryInstruction = '';
  String _couponCode = '';
  String get deliveryInstruction => _deliveryInstruction;
  String get couponCode => _couponCode;
  GetCartDetailsModel? _cartDetail;

  GetCartDetailsModel get cartDetail => _cartDetail!;
  CartDetailsData? _cartDetailsData;

  CartDetailsData? get cartDetailsData => _cartDetailsData;

  void updateDeliveryInstruction(String value) {
    _deliveryInstruction = value;
  }

  void updateCouponCode(String value) {
    _couponCode = value;
  }

  Future<bool> removeCartItem({
    required String cartID,
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.removeCart}"), body: {
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      'cart_id': cartID
    });
    notifyListeners();
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<bool> manageTempCart({required String userID}) async {
    final token = await FirebaseMessaging.instance.getToken();

    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.manageTempCart}"),
        body: {'token': "123456789", 'device_token': token, 'user_id': userID});
    notifyListeners();
    log.i(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<GetCartDetailsModel> getCartDetails() async {
    http.Response response;
    try {
      UserPersonalInfo userPersonalInfo = await Utils.getUser();

      response = await http.post(
          Uri.parse("$baseUrl/${EndPoints.getCartDetails}"),
          body: {'token': "123456789", 'user_id': userPersonalInfo.id});
    } catch (e) {
      print(e.toString());
      response = await http
          .post(Uri.parse("$baseUrl/${EndPoints.getCartDetails}"), body: {
        'token': "123456789",
      });
    }

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

  Future<void> refreshCartDetails() async {
    notifyListeners();
  }

  Future<AddOrderResponse> placeOrder({
    required String kitchenId,
    required String addressId,
    required bool isWalletActive,
    required String name,
    required String couponCode,
    required String instructions,
    required String number,
    // required bool isPaymentOnline
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final body = {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "kitchen_id": '${kitchenId}',
      "orderingforname": name,
      "orderingformobileno": number,
      "addressid": '${addressId}',//
      "coupon_code": couponCode,
      "payment_by_wallet": isWalletActive ? "1" : "0",
      'payment_method': '1',
      'instruction': _deliveryInstruction,
    };
    print("--------userPersonalInfo.id>${userPersonalInfo.id}");
    print("--------kitchenId>${kitchenId}");
    print("--------name>${name}");
    print("--------number>${number}");
    print("--------addressId>${addressId}");
    print("--------couponCode>${couponCode}");
    print("--------isWalletActive>${isWalletActive ? "1" : "0"}");
    print("--------_deliveryInstruction>${_deliveryInstruction}");
    log.f(body);
    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.addOrder}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "kitchen_id": '${kitchenId}',
      "orderingforname": name,
      "orderingformobileno": number,
      "addressid": '${addressId}',//
      "coupon_code": '',
      "payment_by_wallet": isWalletActive ? "1" : "0",
      'payment_method': '1',
      'instruction': _deliveryInstruction,
    });
    _deliveryInstruction = '';
    _couponCode = '';
    log.i(response.statusCode);
    log.i(response.request);
    log.i(json.decode(response.body));
    final data = json.decode(response.body);
    if (!data['status']) {
      return AddOrderResponse(message: data['message'], status: data['status']);
    } else {
      return AddOrderResponse.fromJson(
        json.decode(response.body),
      );
    }
  }

  Future<CreateOrder> transactionSuccess({
    required String txnid,
    required String razorpay_payment_id,
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.successTransaction}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "txnid": txnid,
      "razorpay_payment_id": razorpay_payment_id,
    });

    return CreateOrder.fromJson(
      json.decode(response.body),
    );
  }

  Future<CreateOrder> transactionFailed({
    required String txnid,
    required String razorpay_payment_id,
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.failedTransaction}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "txnid": txnid,
      "razorpay_payment_id": razorpay_payment_id,
    });

    return CreateOrder.fromJson(
      json.decode(response.body),
    );
  }

  Future<BeanApplyPromo> applyPromo(String kitchenId, String couponCode) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.applyCouponCode}"), body: {
      "kitchen_id": kitchenId,
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "coupon_code": couponCode
    });
    return BeanApplyPromo.fromJson(
      json.decode(response.body),
    );
  }

  Future<ApplyCouponCode> applyCouponCode(
      {required String kitchenID, required String couponCode}) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    log.f({
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      'kitchen_id': kitchenID,
      'coupon_code': couponCode
    });

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.applyCouponCode}"), body: {
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      'kitchen_id': kitchenID,
      'coupon_code': couponCode
    });

    if (response.statusCode == 200) {
      ApplyCouponCode data =
          ApplyCouponCode.fromJson(jsonDecode(response.body));

      log.f(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  var totalAmount;

  Future<OffersList> getCouponsHttp() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getCoupons}"),
        body: {'token': "123456789", 'kitchen_id': userPersonalInfo.id});

    if (response.statusCode == 200) {
      var data = OffersList.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<BeanAddCart> addToCart({
    required String kitchenId,
    required String menuID,
    required String quantityType,
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.addToCart}"), body: {
      "user_id": userPersonalInfo.id,
      "token": "123456789",
      "kitchen_id": kitchenId,
      "type_id": menuID,
      "mealplan": "trial",
      "quantity": "1",
      "quantity_type": quantityType
    });
    return BeanAddCart.fromJson(
      json.decode(response.body),
    );
  }

  Future<BeanAddCart> addToCartWithoutLogin({
    required String kitchenId,
    required String menuID,
    required String quantityType,
    required bool forSubscription,
    String? startDate,
    required String mealPlan,
    String? endDate,
    String? fromTime,
    String? toTime,
    String? includeSat,
    String? includeSun,
  }) async {
    final token = await FirebaseMessaging.instance.getToken();
    print('token is $token');
    http.Response response;
    if (!forSubscription) {
      response = await http.post(
          Uri.parse("$baseUrl/${EndPoints.addToCartWithoutLogin}"),
          body: {
            "device_token": token,
            "token": "123456789",
            "kitchen_id": kitchenId,
            "type_id": menuID,
            "mealplan": mealPlan,
            "quantity": "1",
            "quantity_type": quantityType
          });
    } else {
      final body = {
        "device_token": token,
        "token": "123456789",
        "kitchen_id": kitchenId,
        "type_id": menuID,
        "mealplan": "trial",
        "quantity": "1",
        "quantity_type": quantityType,
        "delivery_startdate": startDate,
        "delivery_enddate": endDate,
        "delivery_fromtime": fromTime,
        "delivery_totime": toTime,
        "including_saturday": includeSat,
        "including_sunday": includeSun,
      };
      log.f('json.decode(response.body)$body ');

      response = await http.post(
          Uri.parse("$baseUrl/${EndPoints.addToCartWithoutLogin}"),
          body: {
            "device_token": token,
            "token": "123456789",
            "kitchen_id": kitchenId,
            "type_id": menuID,
            "mealplan": "trial",
            "quantity": "1",
            "quantity_type": quantityType,
            "delivery_startdate": startDate,
            "delivery_enddate": endDate,
            "delivery_fromtime": fromTime,
            "delivery_totime": toTime,
            "including_saturday": includeSat,
            "including_sunday": includeSun,
          });
    }
    log.f(json.decode(response.body));
    return BeanAddCart.fromJson(
      json.decode(response.body),
    );
  }

  Future<BeanAddCart> addSubscriptionToCart({
    required String kitchenId,
    required String packageId,
    required String mealPlan,
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    log.t({
      "user_id": userPersonalInfo.id,
      "token": "123456789",
      "kitchen_id": kitchenId,
      "type_id": packageId,
      "mealplan": mealPlan,
      "quantity": "1",
      "quantity_type": "0"
    });
    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.addToCart}"), body: {
      "user_id": userPersonalInfo.id,
      "token": "123456789",
      "kitchen_id": kitchenId,
      "type_id": packageId,
      "mealplan": mealPlan,
      "quantity": "1",
      "quantity_type": "0"
    });

    return BeanAddCart.fromJson(
      json.decode(response.body),
    );
  }
  //
  // Future<GetCartCount> getCartCount() async {
  //   UserPersonalInfo userPersonalInfo = await Utils.getUser();
  //   http.Response response = await http.post(
  //       Uri.parse("$baseUrl/${EndPoints.getCartItemsCount}"),
  //       body: {'token': "123456789", 'user_id': userPersonalInfo.id});
  //
  //   if (response.statusCode == 200) {
  //     GetCartCount data = GetCartCount.fromJson(jsonDecode(response.body));
  //     return data;
  //   } else {
  //     throw Exception('Something went wrong');
  //   }
  // }

  Future<bool> resetCart() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.resetCart}"),
        body: {'token': "123456789", 'user_id': userPersonalInfo.id});

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Something went wrong');
    }
  }

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }
}
