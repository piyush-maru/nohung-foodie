import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food_app/model/address/get_address_list.dart';
import 'package:food_app/model/address/get_user_address.dart';
import 'package:food_app/model/api_response/api_response.dart';
import 'package:food_app/model/get_delivery_time.dart';
import 'package:food_app/model/kitchen_details_model.dart';
import 'package:food_app/model/payment/create_transaction_response.dart';
import 'package:food_app/model/user_model.dart';
import 'package:food_app/network/end_points.dart';
import 'package:food_app/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/Profile/get_profile.dart';
import '../model/address/confirm_location.dart';
import '../model/cart_screen_class/cart_screen_model_class.dart';
import '../model/cart_screen_class/remove_cart_model.dart';
import '../model/clear_recent_search.dart';
import '../model/coupon_code/apply_coupon_code.dart';
import '../model/customization_details/customization_details.dart';
import '../model/fav_kitchen_classes/fav_kitchen.dart';
import '../model/fav_kitchen_classes/remove_kitchen.dart';
import '../model/forgot_password/forgot_password_model.dart';
import '../model/login.dart';
import '../model/payment/deposit_payment.dart';
import '../model/profile/complete_profile_model.dart';
import '../model/searchData/search_data.dart';
import '../model/signUp/signup_model.dart';
import '../model/verify_otp_reset_password/verify_otp_reset_password_model.dart';

String baseUrl = "https://nohungtest.tech/api/foodies";

class ApiProvider {
  static const String tag = "ApiProvider";
  final log = Logger();

  Foodie? user;
  final Dio _dio = Dio();
  late DioError _dioError;

  ///

  Future<LoginModel?> loginWithMobile(number) async {
    http.Response response = await http.post(
      Uri.parse("$baseUrl/${EndPoints.login}"),
      body: {"token": "123456789", "mobilenumber": number},
    );

    if (response.statusCode == 200) {
      LoginModel data = LoginModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }

  /// forgot Password
  Future<ForgotPasswordModel?> forgotPassword(
      {required String phone, required String email}) async {
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.forgotPassword}"),
        body: {"token": "123456789", "mobileno": phone, "email": email});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      if (data.isEmpty) {
        ForgotPasswordModel model = ForgotPasswordModel(
            status: jsonDecode(response.body)['status'],
            message: jsonDecode(response.body)['message']);
        return model;
      } else {
        ForgotPasswordModel model =
            ForgotPasswordModel.fromJson(jsonDecode(response.body));
        return model;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  /// Reset Password
  Future<ApiResponse?> resetPassword({
    required String code,
    required String userID,
    required String password,
  }) async {
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.resetPassword}"), body: {
      "token": "123456789",
      "code": code,
      "user_id": userID,
      "new_password": password,
    });

    if (response.statusCode == 200) {
      ApiResponse data = ApiResponse.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<LoginModel?> loginWithEmailPassword(
      {required String email, required String password}) async {
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.loginWithEmail}"),
        body: {"token": "123456789", "email": email, "password": password});
    LoginModel loginModel;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      if (data.isEmpty) {
        loginModel = LoginModel(
            status: false, message: jsonDecode(response.body)['message']);
        return loginModel;
      } else {
        data = LoginModel.fromJson(jsonDecode(response.body));
        return data;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<SignupModel?> signup(
      {required String name,
      required String number,
      required String email,
      required String password}) async {
    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.register}"), body: {
      'token': "123456789",
      "name": name,
      'mobilenumber': number,
      'email': email,
      'password': password,
    });
    SignupModel signupModel;

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      if (data.isEmpty) {
        signupModel = SignupModel(
            status: false, message: jsonDecode(response.body)['message']);
        return signupModel;
      } else {
        signupModel = SignupModel.fromJson(jsonDecode(response.body));
        return signupModel;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  /// VERIFY OTP FOR LOGGING IN

  Future<LoginModel?> verifyOtp(
      {required String number,
      required String otp,
      required String type,
      required String userID}) async {
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.verifyOtp}"), body: {
      "token": "123456789",
      "user_id": userID,
      "otp": otp,
      "type": type
    });
    LoginModel loginModel;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      if (data.isEmpty) {
        loginModel = LoginModel(
            status: false, message: jsonDecode(response.body)['message']);
        return loginModel;
      } else {
        loginModel = LoginModel.fromJson(jsonDecode(response.body));
        return loginModel;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  /// VERIFY OTP FOR RESET PASSWORD
  Future<VerifyOTPResetPasswordModel?> verifyOtpResetPassword(
      {required String number,
      required String otp,
      required String userID}) async {
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.verifyOtp}"), body: {
      "token": "123456789",
      "otp": otp,
      "user_id": userID,
      "type": "forgot_password"
    });
    VerifyOTPResetPasswordModel model;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      log.f(jsonDecode(response.body));

      if (data.isEmpty) {
        model = VerifyOTPResetPasswordModel(
            status: false, message: jsonDecode(response.body)['message']);
        return model;
      } else {
        model = VerifyOTPResetPasswordModel.fromJson(jsonDecode(response.body));
        return model;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  /// VERIFY OTP FOR PROFILE UPDATE
  Future<VerifyOTPResetPasswordModel?> verifyOtpUpdateProfile({
    required String number,
    required String otp,
  }) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    log.e({
      "token": "123456789",
      "otp": otp,
      "user_id": userPersonalInfo.id,
      "mobile_number": number,
    });
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.verifyUpdateMobileOtp}"), body: {
      "token": "123456789",
      "otp": otp,
      "user_id": userPersonalInfo.id,
      "mobile_number": number,
    });
    VerifyOTPResetPasswordModel model;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      log.f(jsonDecode(response.body));

      if (data.isEmpty) {
        model = VerifyOTPResetPasswordModel(
            status: false, message: jsonDecode(response.body)['message']);
        return model;
      } else {
        model = VerifyOTPResetPasswordModel.fromJson(jsonDecode(response.body));
        return model;
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  ///

  Future addFirebaseToken(String token) async {
    try {
      UserPersonalInfo login = await Utils.getUser();
      http.Response response = await http.post(
          Uri.parse(
            "$baseUrl/${EndPoints.firebase_token}",
          ),
          body: {
            "token": "123456789",
            "user_id": login!.id,
            "device_token":
                token /*"dCeXRzeyROumFo8_UYblLD:APA91bHwXbi-GwmAPiBJuHUpuDm-UiwwhIZ-avfaiZBsCa8wZ25JXMtLGN6RGCw9CprZQpK8mH_YQ42B1gzcgAx_SxXmwAXv7hjcRRhwzSR6TRR6QqTc4fLtyJQTB6F-L1Iz3B7BTxx3"*/,
          });
      print(
          "<1++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++userId=1=${login.id}");
      print("Firebase token login Screen $token");

      if (response.statusCode == 200) {
        print(
            "<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++token=${token}");
        print(
            "<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++RESPONCE=${response.body}");
        return json.decode(response.body);
      }
    } catch (error) {
      print(error);
      print(
          "<++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++error");
      throw Exception("Something went wrong");
    }
  }

  Future<BeanClearRecentSearch?> clearSearchHttp() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.clearRecentSearch}"),
        body: {'token': "123456789", 'user_id': userPersonalInfo.id});

    if (response.statusCode == 200) {
      BeanClearRecentSearch data =
          BeanClearRecentSearch.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<SearchData?> searchHttp(String search_location_or_kitchen,
      customer_latitude, customer_longitude) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.search}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      'search_location_or_kitchen':
          search_location_or_kitchen, //"23.0512878",//.search_location_or_kitchen,
      'customer_latitude': "23.0512878", //double.parse(customer_latitude),
      'customer_longitude':
          "72.5192373", //customer_longitude,//double.parse(customer_longitude),
    });

    if (response.statusCode == 200) {
      SearchData data = SearchData.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<GetDeliveryTime?> getDeliveryTime(String packageId) async {
    final http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getDeliveryTime}"),
        body: {'token': '123456789', 'package_id': packageId});
    if (response.statusCode == 200) {
      GetDeliveryTime time =
          GetDeliveryTime.fromJson(json.decode(response.body));
      return time;
    } else {
      throw Exception("Something went wrong");
    }
  }

  //Future<BeanAddCustomizeTime?> addCustomizedPackageDateTime(
  //     FormData params) async {
  //   try {
  //     Response response = await _dio.post(
  //         "$baseUrl/${EndPoints.addCustomizedPackageDateTime}",
  //         data: params);
  //     return BeanAddCustomizeTime.fromJson(
  //       json.decode(response.data),
  //     );
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  // Future<GetDeliveryTime?> getCard(FormData params) async {
  //   try {
  //     Response response = await _dio
  //         .post("$baseUrl/${EndPoints.getDeliveryTime}", data: params);
  //     return GetDeliveryTime.fromJson(
  //       json.decode(response.data),
  //     );
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  // Future<BeanClearRecentSearch?> clearRecentSearch(FormData params) async {
  //   try {
  //     Response response = await _dio
  //         .post("$baseUrl/${EndPoints.clearRecentSearch}", data: params);
  //     return BeanClearRecentSearch.fromJson(
  //       json.decode(response.data),
  //     );
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  // Future<BeanFavKitchen?> favKitchen(FormData params) async {
  //   try {
  //     Response response = await _dio
  //         .post("$baseUrl/${EndPoints.addFavoriteKitchen}", data: params);
  //     return BeanFavKitchen.fromJson(
  //       json.decode(response.data),
  //     );
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  Future<BeanFavKitchen?> favKitchenHttp(kitchenId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.addFavoriteKitchen}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      "kitchenid": kitchenId,
    });
    if (response.statusCode == 200) {
      BeanFavKitchen data = BeanFavKitchen.fromJson(jsonDecode(response.body));

      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<BeanRemoveKitchen?> removeKitchenHttp(userID, kitchenId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.removeKitchen}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      "kitchenid": kitchenId
    });

    if (response.statusCode == 200) {
      BeanRemoveKitchen data =
          BeanRemoveKitchen.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  // Future<BeanRemoveKitchen?> removeKitchen(FormData params) async {
  //   try {
  //     Response response =
  //     await _dio.post("$baseUrl/${EndPoints.removeKitchen}", data: params);
  //     return BeanRemoveKitchen.fromJson(
  //       json.decode(response.data),
  //     );
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  Future<GetAddressList?> getUserAddressListHttp() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.searchLocation}"),
        body: {'token': "123456789", 'userid': userPersonalInfo.id});

    if (response.statusCode == 200) {
      GetAddressList data = GetAddressList.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<GetAddressList?> getAddress() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.searchLocation}"),
        body: {"token": "123456789", "user_id": userPersonalInfo.id});
    if (response.statusCode == 200) {
      GetAddressList addressList =
          GetAddressList.fromJson(json.decode(response.body));
      return addressList;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<BeanDepositPayment?> depositPayment(FormData params) async {
    try {
      Response response =
          await _dio.post("$baseUrl/${EndPoints.depositPayment}", data: params);
      return BeanDepositPayment.fromJson(
        json.decode(response.data),
      );
    } catch (error) {
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  // Future<BeanAddCard?> beanAddCard(FormData params) async {
  //   try {
  //     Response response =
  //     await _dio.post("$baseUrl/${EndPoints.addCardDetail}", data: params);
  //     return BeanAddCard.fromJson(
  //       json.decode(response.data),
  //     );
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  // Future<BeanGetCard?> beanGetCard(FormData params) async {
  //   try {
  //     Response response =
  //     await _dio.post("$baseUrl/${EndPoints.getCards}", data: params);
  //     return BeanGetCard.fromJson(
  //       json.decode(response.data),
  //     );
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  Future setDefaultAddress(FormData params) async {
    try {
      Response response = await _dio
          .post("$baseUrl/${EndPoints.setDefaultAddress}", data: params);
      return json.decode(response.data);
    } catch (error) {
      Map<dynamic, dynamic>? map = _dioError.response!.data;
      if (_dioError.response!.statusCode == 500) {
        throwIfNoSuccess(map!['message']);
      } else {
        throwIfNoSuccess("Something gone wrong.");
      }
    }
    return null;
  }

  Future<CompleteProfile?> completeProfileHttp(
      String name, String email) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.completeProfile}"), body: {
      'token': "123456789",
      "user_id": userPersonalInfo.id,
      'email': email
    });

    if (response.statusCode == 200) {
      CompleteProfile data =
          CompleteProfile.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }

  // Future<CompleteProfile?> completeProfile(FormData params) async {
  //   try {
  //     Response response =
  //     await _dio.post("$baseUrl/complete_profile.php", data: params);
  //
  //     return CompleteProfile.fromJson(json.decode(response.data));
  //   } catch (error) {
  //     Map<dynamic, dynamic>? map = _dioError.response!.data;
  //     if (_dioError.response!.statusCode == 500) {
  //       throwIfNoSuccess(map!['message']);
  //     } else {
  //       throwIfNoSuccess("Something gone wrong.");
  //     }
  //   }
  //   return null;
  // }

  Future<KitchenDetails?> kitchenDetails(String kitchenId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.kitchenDetail}"), body: {
      "token": "123456789",
      "kitchenid": kitchenId,
      "meal_plan": "subscription",
      "meal_type": "123456789",
      'cuisine_type': "0,1",
      'customer_id': userPersonalInfo.id,
    });

    if (response.statusCode == 200) {
      KitchenDetails data = KitchenDetails.fromJson(jsonDecode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<GetCartDetailsModel?> getCartDetailHttp() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getCartDetails}"),
        body: {'token': "123456789", 'user_id': userPersonalInfo.id});

    if (response.statusCode == 200) {
      GetCartDetailsModel data =
          GetCartDetailsModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<DeleteCartItem?> deleteCartItemHttp(String cart_id) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.removeCart}"), body: {
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      'cart_id': cart_id
    });

    if (response.statusCode == 200) {
      DeleteCartItem data = DeleteCartItem.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<ApplyCouponCode?> applyCouponCodeHttp(
      String kitchen_id, String coupon_code) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.applyCouponCode}"), body: {
      'token': "123456789",
      'user_id': userPersonalInfo.id,
      'kitchen_id': kitchen_id,
      'coupon_code': coupon_code
    });

    if (response.statusCode == 200) {
      ApplyCouponCode data =
          ApplyCouponCode.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<CustomizationDetails?> getPackageCustomizableItemHttp(
      String package_id, String weekly_package_id) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getPackageCustomizableItem}"),
        body: {
          'token': "123456789",
          'package_id': package_id,
          'weekly_package_id': weekly_package_id,
          'user_id': userPersonalInfo.id
        });

    if (response.statusCode == 200) {
      CustomizationDetails data =
          CustomizationDetails.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<GetUserAddress?> getUserAddressHttp() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getAddressList}"),
        body: {'token': "123456789", 'userid': userPersonalInfo.id});

    if (response.statusCode == 200) {
      GetUserAddress data = GetUserAddress.fromMap(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<LoginModel?> socialLoginHttp(String name, String email) async {
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.loginWithEmail}"),
        body: {'token': "123456789", 'password': name, 'email': email});

    if (response.statusCode == 200) {
      LoginModel data = LoginModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<BeanConfirmLocation?> saveLocationHttp(selectedPlace, pincode,
      double latitude, double longitude, street, landmark, address) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.confirmLocation}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      'location': selectedPlace,
      'pincode': pincode,
      'latitude': latitude,
      'longitude': longitude,
      'street': street,
      'landmark': landmark,
      'address_type': address
    });

    if (response.statusCode == 200) {
      BeanConfirmLocation data =
          BeanConfirmLocation.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<BeanConfirmLocation?> confirmLocationHttp(
    selectedPlace,
    currentPosition,
    pincode,
    latitude,
    longitude,
  ) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.confirmLocation}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      'location': selectedPlace,
      'pincode': pincode,
      'latitude': latitude,
      'longitude': longitude
    });

    if (response.statusCode == 200) {
      BeanConfirmLocation data =
          BeanConfirmLocation.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<CustomizationDetails?> addCustomizedPackageItemHttp(
      packageId, weeklyPackageId, menuItems) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.addCustomizedPackageItem}"),
        body: {
          'token': "123456789",
          'package_id': packageId,
          'weekly_package_id': weeklyPackageId,
          'menu_items': menuItems,
          'user_id': userPersonalInfo.id
        });

    if (response.statusCode == 200) {
      CustomizationDetails data =
          CustomizationDetails.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<bool> updateProfileStringHttp(
      String name, String email, String mobileNumber, removeProfile) async {
    var request =
        http.MultipartRequest('POST', Uri.parse("$baseUrl/update_profile.php"));
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    request.fields['token'] = '123456789';
    request.fields['user_id'] = userPersonalInfo.id.toString();
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['mobile_number'] = mobileNumber;
    request.fields['remove_profile'] = removeProfile;

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();

    final formattedRes = json.decode(responseBody);

    final isOTPSent = formattedRes['data']['otp_sent'];
    if (isOTPSent == 1) {
      return false;
    }
    return true;
  }

  Future<GetProfile?> getProfile() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/get_my_profile.php"),
        body: {'token': '123456789', 'user_id': userPersonalInfo.id});

    if (response.statusCode == 200) {
      GetProfile data = GetProfile.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<bool> updateProfileHttp(
    String name,
    String email,
    String mobileNumber,
    String profileImage,
    removeProfile,
  ) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    var request =
        http.MultipartRequest('POST', Uri.parse("$baseUrl/update_profile.php"));

    request.fields['token'] = '123456789';
    request.fields['user_id'] = userPersonalInfo.id.toString();
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['mobile_number'] = mobileNumber;
    request.fields['remove_profile'] = removeProfile;
    request.files
        .add(await http.MultipartFile.fromPath('profile_image', profileImage));

    var response = await request.send();
    final responseBody = await response.stream.bytesToString();

    final formattedRes = json.decode(responseBody);

    final isOTPSent = formattedRes['data']['otp_sent'];
    if (isOTPSent == 1) {
      return false;
    }
    return true;
  }

  Future<TransactionModel?> createTransactionApi(
      String paymentId, String invoiceId) async {
    var mapHeader = <String, String>{};
    mapHeader['Accept'] = "application/json";
    var map = new Map<String, String>();
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    map['user_id'] = userPersonalInfo.id ?? "";
    map['razorpay_payment_id'] = paymentId;
    map['invoice_id'] = invoiceId;
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.createTransaction}"), body: map);

    return TransactionModel.fromJson(
      json.decode(response.body),
    );
  }
}

void throwIfNoSuccess(String response) {
  throw HttpException(response);
}
