import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  SearchLocationScreenState createState() => SearchLocationScreenState();
}

class SearchLocationScreenState extends State<SearchLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(26.9124, 75.7873),
                    zoom: 11.0,
                  ),
                  mapType: MapType.normal,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 16),
                    child: Image.asset(
                      Res.back,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      color: Colors.black,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              "Search location",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16, top: 16),
                            child: Text(
                              "Your location",
                              style: TextStyle(
                                  color: AppConstant.appColor, fontSize: 15),
                            ),
                          ),
                           const Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, top: 16),
                              child: Text(
                                "To 89 Palmspring Way Roseville, CA\n39847",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/orderdispatched');
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              decoration: BoxDecoration(
                                color: AppConstant.appColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 50,
                              child: const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Center(
                                      child: Text(
                                        "CONFIRM LOCATION",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
