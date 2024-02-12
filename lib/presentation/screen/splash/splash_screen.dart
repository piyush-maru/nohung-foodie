import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:spring/spring.dart';

import '../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../network/get_setting_repo.dart';
import '../../../network/pre_order/pre_order_provider.dart';
import '../../../utils/constants/asset_constants.dart';
import '../../../utils/pref_manager.dart';
import '../authentication_screens/login/login_with_mobile_screen.dart';
import '../landing/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Logger log = Logger();
  String area = '';
  String address = '';
  void navigate() async {
    Future.delayed(
        Duration(
          milliseconds: 3000,
        ), () async {
      bool isLogged = await PrefManager.getBool("isLoggedIn");
      if (isLogged == true) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LandingScreen(),
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
          (route) => false, // Removes all routes in the stack
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginWithMobileScreen(),
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
          ),
          (route) => false, // Removes all routes in the stack
        );
      }
    });
  }

  getCartCount() async {
    final preOrderProvider =
        Provider.of<PreorderProvider>(context, listen: false);

    Provider.of<CartCountModel>(context, listen: false)
        .checkCartCount(provider: preOrderProvider);
  }
  getSettings() async {

        Provider.of<GetSettingModel>(context, listen: false).getSettings();

  }

  @override
  void initState() {
    super.initState();
    getCartCount();
    getSettings();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Color(0xffffb300),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Spring.scale(
              delay: Duration(milliseconds: 1200),
              end: 1.0,
              start: 0.0,
              child: Container(
                height: screenHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    Assets.images.splashBG,
                  ),
                  fit: BoxFit.cover,
                )),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      Assets.icons.nohungText,
                      height: screenWidth * 0.5,
                      width: screenWidth * 0.5,
                    ),
                    Spring.translate(
                        delay: Duration(milliseconds: 1700),
                        beginOffset: Offset(00, 0),
                        endOffset: Offset(200, 0),
                        child: Container(
                          height: screenWidth * 0.5,
                          width: screenWidth * 0.5,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
            Spring.translate(
              beginOffset: Offset(00, 0),
              endOffset: Offset(0, -100),
              child: Spring.scale(
                start: 1.0,
                end: 0.4,
                child: Image.asset(
                  Assets.logos.logo,
                  height: screenWidth * 0.5,
                  width: screenWidth * 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
