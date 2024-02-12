import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/model/cart_count_provider/cart_count_provider.dart';
import 'package:food_app/utils/size_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../network/user/user_address_model.dart';
import '../../../providers/address_location_provider.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/asset_constants.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/pref_manager.dart';
import '../../widgets/dialog/custom_dialog.dart';
import '../Cart/cart_screen.dart';
import '../Profile/profile.dart';
import '../home_screen/home_screen.dart';
import '../orders_tab/order_history_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  String area = '';
  String address = '';

  final List<Widget> _children = [
    HomeScreen(mealFor: "mealFor", fromHome: true),
    CartScreen(),
    OrderHistoryScreen(),
    Profile()
  ];
  Future updateLocationAddress(String address, String area) async {
    final locationAddressProvider =
        Provider.of<AddressLocationProvider>(context, listen: false);
    locationAddressProvider.updateAddress(address);
    locationAddressProvider.updateArea(area);
  }

  Future getDefaultAddress() async {
    bool isLogged = await PrefManager.getBool("isLoggedIn");
    if (isLogged == true) {
      final userAddressProvider =
          Provider.of<UserAddressModel>(context, listen: false);
      await userAddressProvider.storeDefaultAddress();
    } else {
      return;
    }
  }

  Future getAddressFromLatLng(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${AppConstant.placesApiKey}');
    final response = await http.get(url);
    final resData = json.decode(response.body);

    area = resData['results'][0]['address_components'][3]['short_name'];
    address = resData['results'][0]['formatted_address'];

    await updateLocationAddress(address, area);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showCustomDialog(
        context: context,
        subtitles: [
          "Please grant location permission in the App permissions settings.",
          'Go to app settings > "App permissions" > "location" and allow access.',
        ],
        title: "Grant Permission",
        widget: MaterialButton(
          height: 65,
          minWidth: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 17),
          child: poppinsText(
            txt: "Allow Access",
            fontSize: 18,
            weight: FontWeight.w600,
            color: Colors.black45,
          ),
          onPressed: () async {
            Navigator.pop(context);
            await Geolocator.openAppSettings();
          },
        ),
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determinePosition();
    // log.f(currentPosition.latitude);
    // log.i(currentPosition.longitude);
    await getAddressFromLatLng(
        currentPosition.latitude, currentPosition.longitude);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);

    getDefaultAddress();
    _gotoUserCurrentPosition();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _pageController.jumpToPage(
        index,
        // duration: const Duration(milliseconds: 500),
        // curve: Curves.easeInOut,
      );
    });
  }

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    final cartCountProvider = Provider.of<CartCountModel>(context);
    return Scaffold(
      // extendBody: true,
      // bottomNavigationBar:
      bottomNavigationBar: Container(
        color: Colors.transparent,
        // height: 120,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 60,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              decoration: BoxDecoration(
                color: Color(0xff2F3443), //botmColor,
                borderRadius: BorderRadius.circular(29),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          _currentIndex = 0;
                          onTabTapped(_currentIndex);
                        },
                        child: _currentIndex == 0
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 5, right: 5),
                                child: Image.asset(
                                  'assets/icons/bottom_nav_bar_icons/semi_circle.png',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Assets.icons.home,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    poppinsText(
                                      txt: 'Home',
                                      fontSize: 9,
                                      weight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          _currentIndex = 1;
                          onTabTapped(_currentIndex);
                        },
                        child: _currentIndex == 1
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 5, right: 5),
                                child: Image.asset(
                                  'assets/icons/bottom_nav_bar_icons/semi_circle.png',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Image.asset(
                                          Assets.icons.cart,
                                          height: 25,
                                          color: Colors.white,
                                        ),
                                        if (!cartCountProvider.isCartEmpty)
                                          Container(
                                            width: 15,
                                            height: 15,
                                            padding: EdgeInsets.all(1.5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppConstant.appColor,
                                            ),
                                            alignment: Alignment.center,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                cartCountProvider.cartCount,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    poppinsText(
                                      txt: 'Cart',
                                      fontSize: 9,
                                      weight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          _currentIndex = 2;

                          onTabTapped(_currentIndex);
                        },
                        child: _currentIndex == 2
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 5, right: 5),
                                child: Image.asset(
                                  'assets/icons/bottom_nav_bar_icons/semi_circle.png',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Assets.icons.orders,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    poppinsText(
                                      txt: 'Order History',
                                      fontSize: 9,
                                      weight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          _currentIndex = 3;
                          onTabTapped(_currentIndex);
                        },
                        child: _currentIndex == 3
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 5, right: 5),
                                child: Image.asset(
                                  'assets/icons/bottom_nav_bar_icons/semi_circle.png',
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      Assets.icons.profile,
                                      height: 25,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    poppinsText(
                                      txt: 'Profile',
                                      fontSize: 9,
                                      weight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  width: SizeConfig.screenWidth! - 20,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.topCenter,
                  // height: 60,
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: _currentIndex == 0
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    Assets.icons.homeSelected,
                                    height: 90,
                                    width: 90,
                                  ),
                                )
                              : SizedBox()),
                      Expanded(
                          child: _currentIndex == 1
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    Assets.icons.cartSelected,
                                    height: 90,
                                    width: 90,
                                    // fit: BoxFit.cover,
                                  ),
                                )
                              : SizedBox()),
                      Expanded(
                          child: _currentIndex == 2
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    Assets.icons.ordersSelected,
                                    height: 90,
                                    width: 90,
                                    // fit: BoxFit.cover,
                                  ),
                                )
                              : SizedBox()),
                      Expanded(
                          child: _currentIndex == 3
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    Assets.icons.profileSelected,
                                    height: 90,
                                    width: 90,
                                    // fit: BoxFit.cover,
                                  ),
                                )
                              : SizedBox()),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 10),
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: _children.length,
          itemBuilder: (context, index) {
            return _children[index];
          },
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          pageSnapping: true,
        ),
      ),
    );
  }
}
