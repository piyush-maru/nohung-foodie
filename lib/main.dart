import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/Menu/menu_item_selected_screen.dart';
import 'package:food_app/controller/bottom_bar_controller.dart';
import 'package:food_app/network/PackageSubRepo/get_package_details.dart';
import 'package:food_app/network/coupons_repo.dart';
import 'package:food_app/network/get_setting_repo.dart';
import 'package:food_app/network/home_screen_repo/home_screen_search.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_controller.dart';
import 'package:food_app/network/location_screen/get_default_address.dart';
import 'package:food_app/network/location_screen/location_api_controller.dart';
import 'package:food_app/network/location_screen/location_repo.dart';
import 'package:food_app/network/login_api/login_api_controller.dart';
import 'package:food_app/network/orders_repo/cancel_order_model.dart';
import 'package:food_app/network/orders_repo/fav_orders_model.dart';
import 'package:food_app/network/orders_repo/get_delivery_time_model.dart';
import 'package:food_app/network/orders_repo/get_order_customization_details_model.dart';
import 'package:food_app/network/orders_repo/postponse_order.dart';
import 'package:food_app/network/profile_repo.dart';
import 'package:food_app/network/selectDateTime/GetOfflineDatesModel.dart';
import 'package:food_app/network/selectDateTime/select_date_time_controller.dart';
import 'package:food_app/presentation/screen/Cart/cart_screen.dart';
import 'package:food_app/presentation/screen/Cart/coupons.dart';
import 'package:food_app/presentation/screen/Cart/payment_screen.dart';
import 'package:food_app/presentation/screen/Profile/customer_chat_screen.dart';
import 'package:food_app/presentation/screen/Profile/profile.dart';
import 'package:food_app/presentation/screen/add_package_screen.dart';
import 'package:food_app/presentation/screen/authentication_screens/forgot_password/forgot_password_screen.dart';
import 'package:food_app/presentation/screen/authentication_screens/login/login_with_mobile_screen.dart';
import 'package:food_app/presentation/screen/customer_feedback_screen.dart';
import 'package:food_app/presentation/screen/kitchen_details/kitchen_info.dart';
import 'package:food_app/presentation/screen/landing/landing_screen.dart';
import 'package:food_app/presentation/screen/location_collections/address_list_screen.dart';
import 'package:food_app/presentation/screen/orders_tab/order_history_screen.dart';
import 'package:food_app/presentation/screen/search_location_screen.dart';
import 'package:food_app/presentation/screen/splash/splash_screen.dart';
import 'package:food_app/providers/address_location_provider.dart';
import 'package:food_app/providers/cart_providers/cart_bill_details_provider.dart';
import 'package:food_app/providers/delivery_time_and_dates_provider.dart';
import 'package:food_app/providers/voice_search_provider.dart';
import 'package:food_app/providers/wallet_provider.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/log.dart';
import 'package:food_app/utils/size_config.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/cart_count_provider/cart_count_provider.dart';
import 'model/cuisine_types_provider/cuisine_types_provider.dart';
import 'model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import 'model/menu_list_provider/menu_list_provider.dart';
import 'network/api_provider.dart';
import 'network/cart_repo/cart_screen_model.dart';
import 'network/cart_repo/pre_order_model.dart';
import 'network/chat_repo/customer_chat_repo.dart';
import 'network/check_out/checkout_model.dart';
import 'network/customization_details/customization_details_controller.dart';
import 'network/fav_kitchen_repo/fav_kitchen_model.dart';
import 'network/home_screen_repo/home_screen_api_controller.dart';
import 'network/kitchen_details/subscription_provider.dart';
import 'network/name_screen/name_screen_api_provider.dart';
import 'network/orders_repo/active_order_customization_model.dart';
import 'network/orders_repo/active_orders_repo.dart';
import 'network/orders_repo/invoice_model.dart';
import 'network/orders_repo/order_history_model.dart';
import 'network/orders_repo/rate_order_model.dart';
import 'network/orders_repo/update_order_item_details_model.dart';
import 'network/pre_order/pre_order_provider.dart';
import 'network/searchAddressController/search_api_controller.dart';
import 'network/user/user_address_model.dart';

void main() async {
  _initLog();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  final token = await FirebaseMessaging.instance.getToken();
  print("token is $token");

  FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
    print("nikhil");
    await ApiProvider().addFirebaseToken(token);
  });

  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) async {
      await Firebase.initializeApp();

      runApp(
        DevicePreview(
          enabled: false,
          // enabled: false,
          builder: (BuildContext context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
              ChangeNotifierProvider(
                  create: (context) => CuisineTypesProvider()),
              ChangeNotifierProvider(create: (context) => NameScreenProvider()),
              ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
              ChangeNotifierProvider(
                  create: (context) => CustomizationDetailsController()),
              ChangeNotifierProvider(
                  create: (context) => BottomBarController()),
              ChangeNotifierProvider(create: (context) => OrderHistoryModel()),
              ChangeNotifierProvider(create: (context) => FavOrdersModel()),
              ChangeNotifierProvider(create: (context) => ActiveOrdersModel()),
              ChangeNotifierProvider(
                  create: (context) => ActiveOrderCustomizationModel()),
              ChangeNotifierProvider(
                  create: (context) => MenuItemAddToCartProvider()),
              ChangeNotifierProvider(create: (context) => MenuListProvider()),
              ChangeNotifierProvider(create: (context) => InvoiceModel()),
              ChangeNotifierProvider(create: (context) => RateOrderModel()),
              ChangeNotifierProvider(create: (context) => PostPoneOrderModel()),
              ChangeNotifierProvider(
                  create: (context) => GetOrderCustomizationDetailsModel()),
              ChangeNotifierProvider(create: (context) => UserAddressModel()),
              ChangeNotifierProvider(
                  create: (context) => GetDeliveryTimeModel()),
              ChangeNotifierProvider(create: (context) => CancelOrderModel()),
              ChangeNotifierProvider(
                  create: (context) => CartBillDetailsProvider()),
              ChangeNotifierProvider(
                  create: (context) =>
                      UpdateActiveOrdersCustomizationMenuItemsModel()),
              ChangeNotifierProvider(
                  create: (context) => SearchApiController()),
              ChangeNotifierProvider(create: (context) => GetSettingModel()),
              ChangeNotifierProvider(create: (context) => UserLocations()),
              ChangeNotifierProvider(
                create: (context) => AuthNotifier(),
              ),
              ChangeNotifierProvider(
                create: (context) => VoiceSearchProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => CartScreenModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => CartCountModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => CouponModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => WalletProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => ProfileModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => SubscriptionProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => PreorderProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => HomeScreenProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => LoginApiController(),
              ),
              ChangeNotifierProvider(
                create: (context) => FoodieLocationsModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => KitchenDetailsModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => SelectDateAndTimeModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => CustomizationDetailsController(),
              ),
              ChangeNotifierProvider(
                create: (context) => CheckOutModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => BottomBarController(),
              ),
              ChangeNotifierProvider(
                create: (context) => OrderHistoryModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => FavOrdersModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => ActiveOrdersModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => ActiveOrderCustomizationModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => InvoiceModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => RateOrderModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => PostPoneOrderModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => AddressLocationProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => GetOrderCustomizationDetailsModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => UserAddressModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => GetDeliveryTimeModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => CancelOrderModel(),
              ),
              ChangeNotifierProvider(
                create: (context) =>
                    UpdateActiveOrdersCustomizationMenuItemsModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => GetSettingModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => UserLocations(),
              ),
              ChangeNotifierProvider(
                create: (context) => GetDefaultAddressModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => ChatModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => DeliveryTimeDateProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => FavKitchenModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => SearchHomeScreenModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => PackageDetailModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => PreOrderModel(),
              ),
              ChangeNotifierProvider(
                create: (context) => GetOfflineDatesModel(),
              )
            ],
            child: const App(),
          ),
        ),
      );
    },
  );
}

void _initLog() {
  Log.init();
  Log.setLevel(Level.ALL);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

String dateTimeFormat(String time, String format) {
  return DateFormat(format).format(DateTime.parse(time));
}

class AppState extends State<App> {
  late final FirebaseMessaging _messaging;
  requestFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
      print('User declined or has not accepted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    super.initState();
    requestFCM();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Food App",
          initialRoute: '/',
          theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: AppConstant.appColor,
              fontFamily: "Product Sans"),
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (BuildContext context) => makeRoute(
                  context: context,
                  routeName: settings.name,
                  arguments: settings.arguments),
              maintainState: true,
              fullscreenDialog: false,
            );
          }),
    );
  }

  Widget makeRoute(
      {required BuildContext context,
      required String? routeName,
      Object? arguments}) {
    final Widget child = _buildRoute(
        context: context, routeName: routeName, arguments: arguments);
    return child;
  }

  Widget _buildRoute({
    required BuildContext context,
    required String? routeName,
    Object? arguments,
  }) {
    switch (routeName) {
      case '/':
        return const SplashScreen();
      case '/main':
        return const LandingScreen();
      case '/loginSignUp':
        return const LoginWithMobileScreen();
      case '/home':
        return const LandingScreen();
      case '/orderScreen':
        return const OrderHistoryScreen();
      case '/cart':
        return const CartScreen();
      case '/profile':
        return const Profile(
            // refreshOrdersCallback: () {
            //   future = context.read<ProfileModel>().getProfile();
            // },
            );

      case '/location':
        return const AddressListScreen();
      case '/menuItemSelected':
        return const MenuItemSelectedScreen();
      case '/search':
        return const SearchLocationScreen();
      // case '/searchHistory':
      //   return const SearchHistoryScreen();
      //case '/filter':
      //  return const FilterScreen();
      case '/addPackage':
        return const AddPackageScreen();
      case '/payment':
        return const PaymentScreen();
      case '/forgotPassword':
        return const ForgotPasswordScreen();
      case '/customerFeedback':
        return const CustomerFeedbackScreen();

      case '/kitchenInfo':
        return const KitchenInfo();
      case '/coupon':
        return CouponsScreen(
          kitchenId: "",
        );

      case '/chat':
        return CustomerChatScreen(refreshCallBack: () {});

      // case '/subscriptionAddon':
      //   return const SubscriptionAddons();
      default:
        throw 'Route $routeName is not defined';
    }
  }
}

Future<bool> saveKitchenStatus(bool kitchenStatus) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setBool("kitchen_status", kitchenStatus);
}

Future<int?> getOrdersRequestCount() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt('orders_request_count');
}

Future<bool> saveOrdersRequestCount(int ordersCount) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.setInt("orders_request_count", ordersCount);
}
