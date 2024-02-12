import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/profile_repo.dart';
import 'package:food_app/presentation/screen/authentication_screens/reset_password/reset_password_screen.dart';
import 'package:food_app/presentation/screen/authentication_screens/signup/signup_screen.dart';
import 'package:food_app/utils/pref_manager.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/Profile/get_profile.dart';
import '../../model/address/confirm_location.dart';
import '../../model/api_response/api_response.dart';
import '../../model/forgot_password/forgot_password_model.dart';
import '../../model/login.dart';
import '../../model/signUp/signup_model.dart';
import '../../model/verify_otp_reset_password/verify_otp_reset_password_model.dart';
import '../../presentation/screen/authentication_screens/reset_password/password_successfully_changed_screen.dart';
import '../../presentation/screen/authentication_screens/verify_otp/verify_otp_screen.dart';
import '../../presentation/screen/landing/landing_screen.dart';
import '../../presentation/screen/order_dispatched_screen.dart';
import '../../presentation/widgets/snack_bar/custom_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../cart_repo/cart_screen_model.dart';

class LoginApiController extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get wrongOTP => _wrongOTP;
  bool _canResend = false;
  bool _wrongOTP = false;
  bool get canResend => _canResend;

  void updateLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void updateWrongOTP(bool value) {
    _wrongOTP = value;
    notifyListeners();
  }

  void updateCanResendOTP(bool value) {
    _canResend = value;
    notifyListeners();
  }

  /// Login with email and password
  Future<void> loginWithEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    updateLoading();

    LoginModel? bean = await ApiProvider()
        .loginWithEmailPassword(password: password, email: email);

    if (bean?.status == true) {
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      print("---------------------->${bean!.data!.id!}");
      PrefManager.putBool(AppConstant.session, true);

      final userPersonalInfo = UserPersonalInfo(
          id: bean.data!.id,
          username: bean.data!.kitchenname,
          mobilenumber: bean.data!.mobilenumber,
          email: bean.data!.email,
          referalCode: bean.data!.referalCode);
      PrefManager.putString(
        AppConstant.userProfile,
        jsonEncode(userPersonalInfo),
      );
      saveUser(context, bean.data!.id!);
      await Future.delayed(Duration(milliseconds: 1500), () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      });

      updateLoading();
    } else {
      updateLoading();
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomErrorSnackBarMsg(text: bean!.message!, context: context, time: 2);
    }
  }

  /// Forgot Password
  Future<void> forgotPassword(
      {required String phone,
      required String email,
      required BuildContext context}) async {
    updateLoading();

    ForgotPasswordModel? bean =
        await ApiProvider().forgotPassword(email: email, phone: phone);

    if (bean?.status == true) {
      log.f(bean!.message);
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      await Future.delayed(Duration(milliseconds: 1500), () async {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                VerifyOTPScreen(
                    type: 'forgot_password',
                    userID: bean.data!.userID!,
                    mobileNumber: phone,
                    forForgotPassword: true),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(animation),
                child: child,
              );
            },
          ),
        );
      });

      updateLoading();
    } else {
      updateLoading();
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomErrorSnackBarMsg(text: bean!.message!, context: context, time: 2);
    }
  }

  /// Forgot Password
  Future<void> resetPassword(
      {required String code,
      required String userID,
      required String password,
      required BuildContext context}) async {
    updateLoading();

    ApiResponse? bean = await ApiProvider()
        .resetPassword(password: password, userID: userID, code: code);

    if (bean?.status == true) {
      log.f(bean!.message);
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      await Future.delayed(
        Duration(milliseconds: 1500),
        () async {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const PasswordSuccessfullyChangedScreen(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
            (route) => false, // Removes all routes in the stack
          );
          // }
          // else  {
          //   Navigator.of(context).push(
          //     PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) =>
          //           SignUpScreen(
          //         mobileNumber: number,
          //       ),
          //       transitionDuration: const Duration(milliseconds: 500),
          //       transitionsBuilder:
          //           (context, animation, secondaryAnimation, child) {
          //         return SlideTransition(
          //           position:
          //               Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
          //                   .animate(animation),
          //           child: child,
          //         );
          //       },
          //     ),
          //   );
          // }
        },
      );

      updateLoading();
    } else {
      updateLoading();
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomErrorSnackBarMsg(text: bean!.message!, context: context, time: 2);
    }
  }

  /// Login with mobile number
  Future<void> loginWithMobile(
      {required String number, required BuildContext context}) async {
    updateLoading();

    LoginModel? bean = await ApiProvider().loginWithMobile(number);

    if (bean?.status == true) {
      log.f(bean!.message);
      log.f(bean!.data);
      // ScaffoldMessenger.of(context).clearSnackBars();
      //
      // CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      await Future.delayed(Duration(milliseconds: 1500), () async {
        // if (bean!.message == "Verify your account by enter otp.") {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                VerifyOTPScreen(
                    userID: bean.data?.userID ?? bean.data!.id!,
                    mobileNumber: number,
                    type: bean.data?.type ?? 'login'),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(animation),
                child: child,
              );
            },
          ),
        );
      });

      updateLoading();
    } else {
      updateLoading();
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomErrorSnackBarMsg(text: bean!.message!, context: context, time: 2);
    }
  }

  /// RESEND  OTP
  Future<void> resendOTP(
      {required String number, required BuildContext context}) async {
    updateLoading();
    updateCanResendOTP(false);

    LoginModel? bean = await ApiProvider().loginWithMobile(number);

    if (bean?.status == true) {
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      await Future.delayed(Duration(milliseconds: 1500), () async {
        updateLoading();
      });
    } else {
      updateLoading();
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomErrorSnackBarMsg(text: bean!.message!, context: context, time: 2);
    }
  }

  Future<void> signup(
      {required String name,
      required String number,
      required String email,
      required String password,
      required BuildContext context}) async {
    updateLoading();

    SignupModel? bean = await ApiProvider()
        .signup(name: name, number: number, email: email, password: password);
    log.f(bean?.status);
    log.f(bean?.data);
    log.f(bean?.message);
    if (bean?.status == true) {
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      PrefManager.putBool(AppConstant.session, true);

      final userPersonalInfo = UserPersonalInfo(
          id: bean.data!.first.id,
          username: bean.data!.first.name,
          mobilenumber: bean.data!.first.mobilenumber,
          email: bean.data!.first.email,
          referalCode: '');
      PrefManager.putString(
        AppConstant.userProfile,
        jsonEncode(userPersonalInfo),
      );
      saveUser(context, bean.data!.first.id!);
      log.f("signnn otp");
      log.f(jsonEncode(bean.data!.first));
      await Future.delayed(Duration(milliseconds: 1500), () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      });

      updateLoading();
    } else {
      updateLoading();
      ScaffoldMessenger.of(context).clearSnackBars();

      CustomErrorSnackBarMsg(text: bean!.message!, context: context, time: 2);
    }
  }

  /// Verify otp for logging in or creating new account
  Future<void> verifyMobileOTP(
      {required String type,
      required String otp,
      required BuildContext context,
      required String number,
      required String userID}) async {
    updateLoading();

    LoginModel? bean = await ApiProvider()
        .verifyOtp(number: number, otp: otp, userID: userID, type: type);

    if (bean?.status == true) {
      log.f("for otp");
      log.f(bean!.message);

      if (bean!.data!.type == 'register') {
        ScaffoldMessenger.of(context).clearSnackBars();

        CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
        await Future.delayed(Duration(milliseconds: 1500), () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(mobileNumber: number),
              ),
              (route) => false);
        });

        updateLoading();
      } else if (bean.message == 'Login successfully.') {
        PrefManager.putBool(AppConstant.session, true);

        final userPersonalInfo = UserPersonalInfo(
            id: bean.data!.id,
            username: bean.data!.kitchenname,
            mobilenumber: bean.data!.mobilenumber,
            email: bean.data!.email,
            referalCode: bean.data!.referalCode);
        PrefManager.putString(
          AppConstant.userProfile,
          jsonEncode(userPersonalInfo),
        );
        saveUser(context, bean.data!.id!);
        log.f(jsonEncode(bean));
        ScaffoldMessenger.of(context).clearSnackBars();

        CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
        await Future.delayed(Duration(milliseconds: 1500), () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LandingScreen(),
              ),
              (route) => false);
        });

        updateLoading();
      } else {
        updateLoading();
        ScaffoldMessenger.of(context).clearSnackBars();

        CustomErrorSnackBarMsg(
            text: bean.message ??
                "Something went wrong. Contact the Nohung Team if the issue persists.",
            context: context,
            time: 2);
      }
    } else {
      updateLoading();
      updateWrongOTP(true);
    }
  }

  /// Verify otp for reset password
  Future<void> verifyMobileOTPResetPassword(
      {required String otp,
      required BuildContext context,
      required String number,
      required String userID}) async {
    updateLoading();

    VerifyOTPResetPasswordModel? bean =
        await ApiProvider().verifyOtpResetPassword(
      number: number,
      userID: userID,
      otp: otp,
    );

    if (bean?.status == true) {
      log.f("for otp");
      log.f(bean!.message);

      ScaffoldMessenger.of(context).clearSnackBars();

      CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      await Future.delayed(
        Duration(milliseconds: 1500),
        () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResetPasswordScreen(userID: userID, code: bean.data!.code!),
              ),
              (route) => false);
        },
      );

      updateLoading();
    } else {
      updateLoading();
      updateWrongOTP(true);
    }
  }

  /// Verify otp for update profile (Phone Number Change)
  Future<void> verifyMobileOTPUpdateProfile({
    required String otp,
    required BuildContext context,
    required String number,
  }) async {
    updateLoading();

    VerifyOTPResetPasswordModel? bean =
        await ApiProvider().verifyOtpUpdateProfile(
      number: number,
      otp: otp,
    );

    if (bean?.status == true) {
      log.f("for otp");
      log.f(bean!.message);

      ScaffoldMessenger.of(context).clearSnackBars();

      CustomSnackBarMsg(text: bean!.message!, context: context, time: 2);
      await Future.delayed(
        Duration(milliseconds: 1500),
        () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LandingScreen(),
            ),
          );
        },
      );

      updateLoading();
    } else {
      updateLoading();
      updateWrongOTP(true);
    }
  }

  ///
  String name = '';
  String number = '';
  bool skip = false;
  ApiProvider _apiProvider = ApiProvider();
  bool isEmail = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController? pinController = TextEditingController();
  var log = Logger();

  updateSkip() {
    skip = !skip;
    notifyListeners();
  }

  socialLoginUpdate(emailLogin) {
    if (emailLogin == true) {
      isEmail = true;
      notifyListeners();
    } else if (emailLogin == false) {
      isEmail = false;
      notifyListeners();
    }
  }

  socialLoginClear() {
    isEmail = false;
    notifyListeners();
  }

  Future getLocation(currentPosition, context) async {
    Location location = Location();
    LocationData _pos = await location.getLocation();
    currentPosition = LatLng(_pos.latitude!, _pos.longitude!);

    notifyListeners();
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
        (route) => false);
  }

  void saveToken(String firebaseToken) async {
    await Firebase.initializeApp();

    ApiProvider().addFirebaseToken(firebaseToken);
  }

  void saveUser(BuildContext context, String userID) async {
    /// MANAGE TEMP CART
    Provider.of<CartScreenModel>(context, listen: false)
        .manageTempCart(userID: userID);

    /// SAVE REFERRAL CODE

    Provider.of<ProfileModel>(context, listen: false).getProfile();
    await Firebase.initializeApp();

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    String? token = await _firebaseMessaging.getToken();

    //String? id =FirebaseAuth.instance.currentUser!.uid;
    await ApiProvider().addFirebaseToken(token!);
    UserPersonalInfo? user = await Utils.getUser();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("isLoggedIn", true);

    await sharedPreferences.setString("userid", user.id!);
  }

  Future confirmLocationHttp(PickResult selectedPlace, currentPosition, userid,
      pincode, latitude, longitude, context) async {
    BeanConfirmLocation bean = await (ApiProvider().confirmLocationHttp(
      selectedPlace,
      currentPosition,
      pincode,
      latitude,
      longitude,
    ) as FutureOr<BeanConfirmLocation>);

    if (bean.status == true) {
      PrefManager.putBool(AppConstant.session, true);

      Utils.showToast(bean.message!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDispatchedScreen(
            currentPosition!.latitude,
            currentPosition!.longitude,
            selectedPlace.formattedAddress.toString(),
          ),
        ),
      );
    } else {
      Utils.showToast(bean.message!);
    }
  }

  Future<GetProfile?> getProfileDetails(context) async {
    final profileModel = Provider.of<ProfileModel>(context, listen: false);
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    FormData from = FormData.fromMap(
        {"user_id": userPersonalInfo.id, "token": "123456789"});
    GetProfile? bean = await profileModel.getProfile();
    if (bean!.status == true) {
      name = bean.data[0].username;
      notifyListeners();
      number = bean.data[0].mobileNumber;
      notifyListeners();
      return bean;
    } else {
      Utils.showToast(
        bean.message.toString(),
      );
    }
    return null;
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppConstant.appColor;
    Path path = Path()
      ..relativeLineTo(0, 320)
      ..quadraticBezierTo(size.width / 2, 380.0, size.width, 320)
      ..relativeLineTo(0, -320)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
