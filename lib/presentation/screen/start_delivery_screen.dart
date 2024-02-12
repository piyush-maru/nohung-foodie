import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../model/login.dart';
import '../../res.dart';
import '../../utils/constants/app_constants.dart';

const double cameraZoom = 13;
const double cameraTilt = 0;
const double cameraBearing = 30;

class StartDeliveryScreen extends StatefulWidget {
  // final String orderId;

  const StartDeliveryScreen({Key? key}) : super(key: key);

  @override
  StartDeliveryScreenState createState() => StartDeliveryScreenState();
}

class StartDeliveryScreenState extends State<StartDeliveryScreen> {
  double cameraZOOM = 14;
  double cameraTILT = 0;
  double cameraBEARING = 30;

  LatLng sourceLocation = const LatLng(22.3894144, 71.0006658);
  LatLng destLocation = const LatLng(23.022505, 72.5713621);

  // LatLng SOURCE_LOCATION = LatLng(0.0, 0.0);
  // LatLng DEST_LOCATION = LatLng(0.0, 0.0);

  List<LoginModel>? data;

  String? deliveryAddress = "";

/*  LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);*/

  final Set<Marker> _markers = {};

  final Set<Polyline> _polyLines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyBn9ZKmXc-MN12Fap0nUQotO6RKtYJEh8o";
  Completer<GoogleMapController> controller = Completer();
  late CameraPosition cameraPosition;

  var kitchenLat = 0.0;
  var kitchenLong = 0.0;
  var deliveryLat = 0.0;
  var deliveryLong = 0.0;

  // for my custom icons
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

  LatLng? sourceLatLng;
  LatLng? destLatLng;
  late GoogleMapController _mapController;

  Location? _locationTracker;
  StreamSubscription? _locationSubscription;
  Future? future;
  String? userId;
  LocationData? currentLocation;
  final Set<Marker> _markers1 = {};
  bool loadingMap = false;

  @override
  void initState() {
    _locationTracker = Location();
    super.initState();
    Future.delayed(Duration.zero, () {
      _listenLocation();
      setSourceAndDestinationIcons();
    });
    Future.delayed(Duration.zero, () {
      //future = getStartDelivery(context);
    });
  }

  onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (sourceLatLng != null && destLatLng != null) {
      var list = [sourceLatLng, destLatLng];
      CameraUpdate u2 =
          CameraUpdate.newLatLngBounds(boundsFromLatLngList(list), 50);
      _mapController.animateCamera(u2).then((void v) {
        check(u2, _mapController);
      });
    }
    setMapPins();
    setPolylines();
  }

/*  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

  }*/
  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), Res.placeholder);
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5), Res.rider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
          padding: const EdgeInsets.only(left: 16, right: 16),
          children: [
            SizedBox(
              height: 500,
              child: GoogleMap(
                myLocationEnabled: true,
                compassEnabled: false,
                tiltGesturesEnabled: false,
                markers: _markers,
                polylines: _polyLines,
                mapType: MapType.normal,
                buildingsEnabled: true,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController control) {
                  controller.complete(control);
                },
                //initialCameraPosition: cameraPosition

                initialCameraPosition: CameraPosition(
                    zoom: cameraZoom,
                    bearing: cameraBearing,
                    tilt: cameraTilt,
                    target: sourceLocation),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                border:
                    Border.all(color: Colors.black.withOpacity(0.15), width: 2),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Package 1",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontRegular),
                  ),
                  Text(
                    "Veg/NonVeg",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontRegular),
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                border:
                    Border.all(color: Colors.black.withOpacity(0.15), width: 2),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Package 1",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontRegular),
                  ),
                  Text(
                    "Veg/NonVeg",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontRegular),
                  ),
                  Text(
                    "Payment",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ],
              ),
            )
          ]),
    );
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(
        Marker(
            markerId: const MarkerId('sourcePin'),
            position: sourceLocation,
            icon: sourceIcon),
      );
      // destination pin
      _markers.add(
        Marker(
            markerId: const MarkerId('destPin'),
            position: destLocation,
            icon: destinationIcon),
      );
    });
  }

  setPolylines() async {
/*    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPIKey, PointLatLng( SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
        PointLatLng( DEST_LOCATION.latitude, DEST_LOCATION.longitude),

        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    if (result.points.isNotEmpty) {
         result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }*/
    List result = [];
    // (await polylinePoints.getRouteBetweenCoordinates(googleAPIKey,SOURCE_LOCATION.latitude,SOURCE_LOCATION.longitude,DEST_LOCATION.latitude,DEST_LOCATION.longitude));
/*    List<PointLatLng> result = (await polylinePoints.getRouteBetweenCoordinates(googleAPIKey, double.parse(kitchenlat),double.parse(kitchenlong), double.parse(deliverylatitude),double.parse(deliverylongitude),));*/
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      // result.forEach((PointLatLng point) {
      //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      // });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          width: 4,
          polylineId: const PolylineId("poly"),
          color: const Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polyLines.add(polyline);
    });
  }

//   Future<BeanStartDelivery?> getStartDelivery(BuildContext context) async {
//     var user = await Utils.getUser();
//     FormData from = FormData.fromMap({
//       "userid": user.data!.userId,
//       "orderid": 8,
//       "token": "123456789",
//     });
//     BeanStartDelivery? bean = await ApiProvider().startDelivery(from);
//     if (bean?.status == true) {
//       var data = bean!.data;
//       deliveryAddress = data![0].deliveryAddress;
//       Utils.showToast(bean.message!);
//
// /*          kitchenlat=double.parse(bean.data[0].kitchenlatitude);
//           kitchenlong=double.parse(bean.data[0].kitchenlongitude);
//           deliverylatitude=double.parse(bean.data[0].deliverylatitude);
//           deliverylongitude=double.parse(bean.data[0].deliverylongitude);*/
//
//       sourceLocation = const LatLng(17.4967,
//               78.5066) /*LatLng(double.parse(bean.data![0].kitchenLatitude!),
//             double.parse(bean.data![0].kitchenLongitude!))*/
//           ;
//       destLocation = const LatLng(17.4486,
//               78.3908) /*LatLng(double.parse(bean.data![0].deliveryLatitude!),
//             double.parse(bean.data![0].deliveryLongitude!))*/
//           ;
//       return bean;
//     } else {
//       Utils.showToast(bean!.message!);
//     }
//
//     return null;
//   }

//   Future<BeanStartDelivery?> getStartDelivery(BuildContext context) async {
//     var user = await Utils.getUser();
//     FormData from = FormData.fromMap({
//       "userid": user.data![0].id,
//       "orderid": 8,
//       "token": "123456789",
//     });
//     StartDelivery? bean = await ApiProvider().startDelivery(from);
//     if (bean?.status == true) {
//       var data = bean!.data;
//       deliveryAddress = data![0].deliveryAddress;
//       Utils.showToast(bean.message!);
//
// /*          kitchenlat=double.parse(bean.data[0].kitchenlatitude);
//           kitchenlong=double.parse(bean.data[0].kitchenlongitude);
//           deliverylatitude=double.parse(bean.data[0].deliverylatitude);
//           deliverylongitude=double.parse(bean.data[0].deliverylongitude);*/
//
//       sourceLocation = const LatLng(17.4967,
//               78.5066) /*LatLng(double.parse(bean.data![0].kitchenLatitude!),
//             double.parse(bean.data![0].kitchenLongitude!))*/
//           ;
//       destLocation = const LatLng(17.4486,
//               78.3908) /*LatLng(double.parse(bean.data![0].deliveryLatitude!),
//             double.parse(bean.data![0].deliveryLongitude!))*/
//           ;
//       return bean;
//     } else {
//       Utils.showToast(bean!.message!);
//     }
//
//     return null;
//   }

  googleMap() {
    if (data != null) {
      return GoogleMap(
          myLocationEnabled: true,
          compassEnabled: false,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polyLines,
          mapType: MapType.normal,
          scrollGesturesEnabled: true,
          buildingsEnabled: true,
          zoomControlsEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: (GoogleMapController control) {
            controller.complete(control);
          },
          initialCameraPosition: cameraPosition

          /*CameraPosition(
             zoom: CAMERA_ZOOM,
             bearing: CAMERA_BEARING,
             tilt: CAMERA_TILT,
             target: SOURCE_LOCATION

         ),*/
          );
    } else {
      return Container();
    }
  }

  updatePinOnMap() async {
/*

     // create a new CameraPosition instance
     // every time the location changes, so the camera
     // follows the pin as it moves with an animation
     CameraPosition cPosition = CameraPosition(
       zoom: CAMERA_ZOOM,
       tilt: CAMERA_TILT,
       bearing: CAMERA_BEARING,
       target: LatLng(currentLocation.latitude, currentLocation.longitude),
     );
     final GoogleMapController controller = await _controller.future;
     controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
     // do this inside the setState() so Flutter gets notified
     // that a widget update is due
     setState(() {
       // updated position
       var pinPosition = LatLng(currentLocation.latitude, currentLocation.longitude);

       sourcePinInfo.location = pinPosition;

       // the trick is to remove the marker (by id)
       // and add it again at the updated location
       _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
       _markers.add(Marker(
           markerId: MarkerId('sourcePin'),
           onTap: () {
             setState(() {
               currentlySelectedPin = sourcePinInfo;
               pinPillPosition = 0;
             });
           },
           position: pinPosition, // updated position
           icon: sourceIcon));
     });*/

    cameraPosition = CameraPosition(
      zoom: cameraZOOM,
      tilt: cameraTILT,
      bearing: cameraBEARING,
      target: const LatLng(22.3894144,
          71.0006658) /*LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude)*/,
    );
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
    setState(() {
      _markers1.removeWhere((m) => m.markerId.value == "sourcePin");
      _markers1.add(
        Marker(
            markerId: const MarkerId("sourcePin"),
            position: const LatLng(22.3894144, 71.0006658),
            /*LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),*/
            flat: true,
            anchor: const Offset(0.5, 0.5),
            infoWindow: const InfoWindow(title: "first"),
            icon: sourceIcon),
      );
    });
  }

  Future _listenLocation() async {
    // _locationSubscription =
    //     _locationTracker.onLocationChanged().handleError((dynamic err) {

    //       setState(() {
    //         _error = err.code;
    //       });
    //       _locationSubscription.cancel();
    //     }).listen((LocationData currentLocation) {
    //       _error = null;
    //       updatePinOnMap();
    //     });
  }

  LatLngBounds boundsFromLatLngList(List<LatLng?> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng? latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng!.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng!.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    // _mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
    super.dispose();
  }
}
