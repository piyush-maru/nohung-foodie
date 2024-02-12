/*
import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/landing/landing_screen.dart';
import 'package:food_app/presentation/widgets/jumping_dots/dancing_dots.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../providers/address_location_provider.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/pref_manager.dart';
import '../../../utils/size_config.dart';
import '../authentication_screens/login/login_with_mobile_screen.dart';

class AutoLocationDetection extends StatefulWidget {
  const AutoLocationDetection({super.key});

  @override
  State<AutoLocationDetection> createState() => _AutoLocationDetectionState();
}

class _AutoLocationDetectionState extends State<AutoLocationDetection> {
  Logger log = Logger();
  String area = '';
  String address = '';
  getLocation() async {
     final locationAddressProvider =
        Provider.of<AddressLocationProvider>(context, listen: false);
    address = locationAddressProvider.getAddress;
    area = locationAddressProvider.getArea;

    Future.delayed(
        Duration(
          seconds: 2,
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

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/image_blurred_map_bg.png"),
                fit: BoxFit.fitHeight)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lotties/location_searching.json',
                // controller: _animationController,
              ),
              poppinsText(
                  txt: "  DELIVERING TO",
                  fontSize: 18,
                  weight: FontWeight.w600),
              if (area != "")
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_map.png',
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    poppinsText(
                        txt: area ?? "",
                        fontSize: 25,
                        color: Colors.black,
                        weight: FontWeight.w700),
                  ],
                ),
              if (area != "")
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    address ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: kTextPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.7),
                    ),
                  ),
                ),
              if (area == "")
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: JumpingDots(
                    color: kYellowColor,
                  ),
                ),
              SizedBox(
                height: 100,
              ),
            ]),
      ),
    );
  }

  Future getAddressFromLatLng(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${AppConstant.kPlacesApiKey}');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    // setState(() {
    area = resData['results'][0]['address_components'][3]['short_name'];
    address = resData['results'][0]['formatted_address'];
    // });
    await updateLocationAddress(address, area);
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    // log.f(currentPosition.latitude);
    // log.i(currentPosition.longitude);
    await getAddressFromLatLng(
        currentPosition.latitude, currentPosition.longitude)
        .then((_) => Future.delayed(
        Duration(
          seconds: 1,
        ), () async {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          const AutoLocationDetection(),
          transitionDuration: const Duration(milliseconds: 700),
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
    }));
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      debugPrint("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        debugPrint("user denied location permission");
      }
      locationPermission = await Geolocator.requestPermission();
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future getAddressFromLatLng(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${AppConstant.kPlacesApiKey}');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    // setState(() {
    area = resData['results'][0]['address_components'][3]['short_name'];
    address = resData['results'][0]['formatted_address'];
    // });
    await updateLocationAddress(address, area);
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    // log.f(currentPosition.latitude);
    // log.i(currentPosition.longitude);
    await getAddressFromLatLng(
            currentPosition.latitude, currentPosition.longitude)
        .then((_) => Future.delayed(
                Duration(
                  seconds: 1,
                ), () async {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const AutoLocationDetection(),
                  transitionDuration: const Duration(milliseconds: 700),
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
            }));
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      debugPrint("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        debugPrint("user denied location permission");
      }
      locationPermission = await Geolocator.requestPermission();
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

}

*/
