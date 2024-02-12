// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:food_app/network/location_screen/location_api_controller.dart';
// import 'package:food_app/network/location_screen/location_repo.dart';
// import 'package:food_app/network/user/user_address_model.dart';
// import 'package:food_app/utils/constants/app_constants.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_place/google_place.dart';
// import 'package:provider/provider.dart';
//
// import '../../../model/orders/get_order_history_detail.dart';
// import '../../../model/user/user_address_list.dart';
// import '../../../network/home_screen_repo/home_screen_api_controller.dart';
// import '../../../utils/Utils.dart';
// import '../orders_tab/active_order_customize_preview.dart';
// import 'location_picker.dart';
//
// class LocationDetailsScreen extends StatefulWidget {
//   final Function refreshCallBack;
//   final OrderDetailsModel orderData;
//
//   const LocationDetailsScreen(
//       {required this.refreshCallBack, required this.orderData, Key? key})
//       : super(key: key);
//
//   @override
//   State<LocationDetailsScreen> createState() => _LocationDetailsScreenState();
// }
//
// class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
//   String? deliveryAddress = "";
//   Position? position;
//   late GooglePlace googlePlace;
//   bool isEdit = false;
//   Future? future;
//
//   Future<void> getAddressFromLatLong(Position position) async {
//     deliveryAddress = "";
//     List<Placemark> placeMarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//
//     Placemark place = placeMarks[0];
//     deliveryAddress =
//         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//   }
//
//   getCurrentLocation() async {
//     LocationPermission permission;
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       Utils.showToast('permission denied- please enable it from app settings');
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     position = await Geolocator.getCurrentPosition();
//     getAddressFromLatLong(position!);
//   }
//
//   Future initialize() async {
//     await getUserAddress();
//   }
//
//   getUserAddress() async {
//     String error;
//
//     try {
//       await getCurrentLocation();
//       setState(() {});
//       //myLocation = await location.getLocation();
//     } on PlatformException catch (e) {
//       if (kDebugMode) {}
//       if (e.code == 'PERMISSION_DENIED') {
//         error = 'please grant permission';
//         await getCurrentLocation();
//       }
//       if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
//         error = 'permission denied- please enable it from app settings';
//         await getCurrentLocation();
//       }
//     }
//   }
//
//   Future<void> checkLocationStatus() async {
//     bool serviceEnabled;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are disabled, show a permission request dialog
//       await Geolocator.openLocationSettings();
//     }
//   }
//
//   Future<void> _handlePressButton() async {
//     void onError(PlacesAutocompleteResponse response) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(response.errorMessage ?? 'Unknown error'),
//         ),
//       );
//     }
//
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     final p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: 'AIzaSyCYwdySyPeWE0Mc0iV6tedJOULAHvk6u4s',
//       onError: onError,
//       //mode: _mode,
//       language: 'fr',
//       //components: [Component(Component.country, 'fr')],
//       // TODO: Since we supports Flutter >= 2.8.0
//       // ignore: deprecated_member_use
//       resultTextStyle: Theme.of(context).textTheme.subtitle1,
//     );
//
//     await displayPrediction(p, ScaffoldMessenger.of(context));
//   }
//
//   Future<void> displayPrediction(
//       Prediction? p, ScaffoldMessengerState messengerState) async {
//     if (p == null) {
//       return;
//     }
//
//     // get detail (lat/lng)
//     final places = GoogleMapsPlaces(
//       apiKey: 'AIzaSyCYwdySyPeWE0Mc0iV6tedJOULAHvk6u4s',
//       apiHeaders: await const GoogleApiHeaders().getHeaders(),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     initialize();
//     //String apiKey = DotEnv().f2y
//     //getAddressUserAddress();
//
//     //Provider.of<LocationApiController>(context, listen: false).homeLocationData.clear();
//
//     // Provider.of<LocationApiController>(context, listen: false).googlePlace =
//     //     GooglePlace(
//     //         Provider.of<LocationApiController>(context, listen: false).apiKey);
//     // Provider.of<LocationApiController>(context, listen: false).getLocation();
//
//     // Provider.of<LocationApiController>(context, listen: false)
//     //     .getAddressUserAddress();
//     // Provider.of<LocationApiController>(context, listen: false)
//     //     .confirmLocation(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var homeApiController =
//         Provider.of<HomeScreenProvider>(context, listen: false);
//     var locationModel =
//         Provider.of<FoodieLocationsModel>(context, listen: false);
//     final addressProvider =
//         Provider.of<UserAddressModel>(context, listen: false);
//     final addressModel = Provider.of<UserLocations>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackButton(
//           color: Colors.black,
//         ),
//         backgroundColor: const Color(0xFFF6F6F6),
//         elevation: 0,
//       ),
//       backgroundColor: const Color(0xFFF6F6F6),
//       body: SingleChildScrollView(
//           child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: /* Consumer<FoodieLocationsModel>(
//                   builder: (context, , child) {
//                 return*/
//                   FutureBuilder<UserAddressList?>(
//                       future: addressProvider.getUserAddress(),
//                       builder: (context, snapshot) {
//                         return snapshot.connectionState ==
//                                     ConnectionState.done &&
//                                 snapshot.data != null
//                             ? Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const Text(
//                                           "Your locations",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontFamily:
//                                                   AppConstant.fontRegular,
//                                               fontSize: 18),
//                                         ),
//                                         IconButton(
//                                           onPressed: () async {
//                                             Navigator.of(context).pop();
//                                             locationModel.homeLocationData
//                                                 .clear();
//                                             checkLocationStatus();
//                                             await Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) {
//                                                   return PlacePicker(
//                                                     apiKey:
//                                                         'AIzaSyCYwdySyPeWE0Mc0iV6tedJOULAHvk6u4s',
//                                                     hintText:
//                                                         "Find a place ...",
//                                                     searchingText:
//                                                         "Please wait ...",
//                                                     selectText: "Select place",
//                                                     outsideOfPickAreaText:
//                                                         "Place not in area",
//                                                     initialPosition:
//                                                         const LatLng(17.4431103,
//                                                             78.3869877),
//                                                     useCurrentLocation: true,
//                                                     selectInitialPosition: true,
//                                                     usePinPointingSearch: true,
//                                                     usePlaceDetailSearch: true,
//                                                     zoomGesturesEnabled: true,
//                                                     zoomControlsEnabled: true,
//                                                     onPlacePicked:
//                                                         (PickResult result) {
//                                                       locationModel
//                                                           .updateSelectedPlace(
//                                                               result);
//                                                       locationSheet(
//                                                         context: context,
//                                                         selectedPlace: result,
//                                                       );
//                                                       // Navigator.pushReplacement(
//                                                       //   context,
//                                                       //   MaterialPageRoute(
//                                                       //     builder: (context) => SetLocationScreen(
//                                                       //         pickResult:
//                                                       //             locationModel.selectedPlace!),
//                                                       //   ),
//                                                       // ).then((value) {
//                                                       //   locationModel.getAddress();
//                                                       // });
//                                                     },
//                                                     onMapTypeChanged:
//                                                         (MapType mapType) {},
//                                                   );
//                                                 },
//                                               ),
//                                             );
//                                           },
//                                           icon: const CircleAvatar(
//                                             backgroundColor: Colors.white,
//                                             child: Icon(
//                                               Icons.add,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     SingleChildScrollView(
//                                       child: SizedBox(
//                                         child: ListView.builder(
//                                           scrollDirection: Axis.vertical,
//                                           physics:
//                                               const BouncingScrollPhysics(),
//                                           shrinkWrap: true,
//                                           itemCount: snapshot
//                                                   .data!.data.home.length +
//                                               snapshot
//                                                   .data!.data.office.length +
//                                               snapshot.data!.data.other.length,
//                                           itemBuilder: (context, index) {
//                                             List<UserLocationTypes?> addresses =
//                                                 [];
//                                             addresses.addAll(
//                                                 snapshot.data!.data.home);
//                                             addresses.addAll(
//                                                 snapshot.data!.data.office);
//                                             addresses.addAll(
//                                                 snapshot.data!.data.other);
//                                             return InkWell(
//                                               onTap: () {
//                                                 homeApiController.updateAddress(
//                                                     addresses[index]!.address);
//
//                                                 // homeApiController.homeKitchenAccordingToAddress(
//                                                 //     value.homeLocationData[index]
//                                                 //         .longitude,
//                                                 //     value.homeLocationData[index]
//                                                 //         .latitude
//                                                 // );
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 12,
//                                                     top: 6,
//                                                     bottom: 12),
//                                                 margin: const EdgeInsets.only(
//                                                     bottom: 6),
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             12),
//                                                     border: Border.all(
//                                                         color: AppConstant
//                                                             .appColor)),
//                                                 child: Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .only(top: 14),
//                                                         child: CircleAvatar(
//                                                           backgroundColor:
//                                                               AppConstant
//                                                                   .appColor,
//                                                           child:
//                                                               SvgPicture.asset(
//                                                             "assets/images/awesome-home.svg",
//                                                             height: 15,
//                                                             width: 15,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(width: 4),
//                                                       Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceBetween,
//                                                                 children: [
//                                                                   Text(
//                                                                     addresses[
//                                                                             index]!
//                                                                         .addressType
//                                                                         .toString(),
//                                                                     style: const TextStyle(
//                                                                         fontFamily:
//                                                                             AppConstant.fontBold),
//                                                                   ),
//                                                                   TextButton(
//                                                                     onPressed:
//                                                                         () async {
//                                                                       Navigator.of(
//                                                                               context)
//                                                                           .pop();
//                                                                       locationModel
//                                                                           .homeLocationData
//                                                                           .clear();
//                                                                       await Navigator
//                                                                           .push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                           builder:
//                                                                               (context) {
//                                                                             return PlacePicker(
//                                                                               apiKey: 'AIzaSyCYwdySyPeWE0Mc0iV6tedJOULAHvk6u4s',
//                                                                               hintText: "Find a place ...",
//                                                                               searchingText: "Please wait ...",
//                                                                               selectText: "Select place",
//                                                                               outsideOfPickAreaText: "Place not in area",
//                                                                               initialPosition: const LatLng(17.4431103, 78.3869877),
//                                                                               useCurrentLocation: true,
//                                                                               selectInitialPosition: true,
//                                                                               usePinPointingSearch: true,
//                                                                               usePlaceDetailSearch: true,
//                                                                               zoomGesturesEnabled: true,
//                                                                               zoomControlsEnabled: true,
//                                                                               onPlacePicked: (PickResult result) {
//                                                                                 locationModel.updateSelectedPlace(result);
//                                                                                 print(result.formattedAddress);
//                                                                                 print(result.name);
//                                                                                 locationSheet(context: context, selectedPlace: result, addressId: snapshot.data!.data.home[index].id.toString(), isToEdit: true);
//                                                                               },
//                                                                               onMapTypeChanged: (MapType mapType) {},
//                                                                             );
//                                                                           },
//                                                                         ),
//                                                                       );
//                                                                     },
//                                                                     child:
//                                                                         const Text(
//                                                                       "EDIT",
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontFamily:
//                                                                             AppConstant.fontRegular,
//                                                                         color: AppConstant
//                                                                             .appColor,
//                                                                         decoration:
//                                                                             TextDecoration.underline,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   TextButton(
//                                                                     onPressed:
//                                                                         () {
//                                                                       showDialog(
//                                                                           barrierDismissible:
//                                                                               true,
//                                                                           context:
//                                                                               context,
//                                                                           builder:
//                                                                               (context) {
//                                                                             return Dialog(
//                                                                               child: Container(
//                                                                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
//                                                                                 height: 300,
//                                                                                 padding: const EdgeInsets.all(28.0),
//                                                                                 child: Column(
//                                                                                   children: [
//                                                                                     SvgPicture.asset("assets/images/delete_address.svg"),
//                                                                                     const SizedBox(
//                                                                                       height: 6,
//                                                                                     ),
//                                                                                     const Text(
//                                                                                       "  Are you sure you       \nwant to delete address",
//                                                                                       style: TextStyle(fontFamily: AppConstant.fontRegular, fontSize: 16),
//                                                                                     ),
//                                                                                     const SizedBox(
//                                                                                       height: 6,
//                                                                                     ),
//                                                                                     Row(
//                                                                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                                       children: [
//                                                                                         ElevatedButton(
//                                                                                           onPressed: () {
//                                                                                             Navigator.pop(context);
//                                                                                           },
//                                                                                           style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
//                                                                                           child: const Text(
//                                                                                             "NO",
//                                                                                             style: TextStyle(fontFamily: AppConstant.fontRegular),
//                                                                                           ),
//                                                                                         ),
//                                                                                         ElevatedButton(
//                                                                                             onPressed: () {
//                                                                                               addressModel.deleteAddress(addresses[index]!.id).then((value) {
//                                                                                                 Navigator.pop(context);
//                                                                                                 addressModel.getUserAddressList();
//                                                                                               });
//                                                                                             },
//                                                                                             style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppConstant.appColor)),
//                                                                                             child: const Text(
//                                                                                               "YES",
//                                                                                               style: TextStyle(fontFamily: AppConstant.fontRegular),
//                                                                                             ))
//                                                                                       ],
//                                                                                     )
//                                                                                   ],
//                                                                                 ),
//                                                                               ),
//                                                                             );
//                                                                           });
//                                                                     },
//                                                                     child:
//                                                                         const Text(
//                                                                       "DELETE",
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontFamily:
//                                                                             AppConstant.fontRegular,
//                                                                         color: AppConstant
//                                                                             .appColor,
//                                                                         decoration:
//                                                                             TextDecoration.underline,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   const Text(
//                                                                     "Make Default",
//                                                                     style: TextStyle(
//                                                                         fontFamily:
//                                                                             AppConstant.fontRegular),
//                                                                   ),
//                                                                   Switch(
//                                                                     value: addresses[index]!
//                                                                             .isDefault ==
//                                                                         "y",
//                                                                     onChanged:
//                                                                         (value) {
//                                                                       print(addresses[
//                                                                               index]!
//                                                                           .isDefault);
//                                                                       // setState(() {
//                                                                       addresses[index]!.isDefault ==
//                                                                               "n"
//                                                                           ? addressProvider
//                                                                               .makeAddressDefault(addresses[index]!.id)
//                                                                               .then((response) {
//                                                                               if (response.statusCode == 200) {
//                                                                                 // addresses[index]!.id;
//                                                                                 Navigator.of(context).push(PageRouteBuilder(
//                                                                                   opaque: false,
//                                                                                   pageBuilder: (BuildContext context, _, __) => ActiveOrderCustomizeScreen(
//                                                                                     orderData: widget.orderData,
//                                                                                   ),
//                                                                                 ));
//                                                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                                                   const SnackBar(
//                                                                                     content: Text(
//                                                                                       "Address added as default",
//                                                                                       style: TextStyle(fontFamily: AppConstant.fontRegular),
//                                                                                     ),
//                                                                                   ),
//                                                                                 );
//                                                                               } else {
//                                                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                                                   const SnackBar(
//                                                                                     content: Text(
//                                                                                       "Something went wrong",
//                                                                                       style: TextStyle(fontFamily: AppConstant.fontRegular),
//                                                                                     ),
//                                                                                   ),
//                                                                                 );
//                                                                               }
//                                                                             })
//                                                                           : "";
//                                                                       //  });
//
//                                                                       //Navigator.pop(context);
//                                                                     },
//                                                                     activeTrackColor:
//                                                                         AppConstant
//                                                                             .appColor,
//                                                                     activeColor:
//                                                                         Colors
//                                                                             .white,
//                                                                   ),
//                                                                 ]),
//                                                             Container(
//                                                               constraints:
//                                                                   const BoxConstraints(
//                                                                       maxWidth:
//                                                                           250,
//                                                                       maxHeight:
//                                                                           50),
//                                                               child: Text(
//                                                                 addresses[
//                                                                         index]!
//                                                                     .address
//                                                                     .toString(),
//                                                                 style: const TextStyle(
//                                                                     fontFamily:
//                                                                         AppConstant
//                                                                             .fontRegular,
//                                                                     fontSize:
//                                                                         12),
//                                                               ),
//                                                             )
//                                                           ])
//                                                     ]),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     )
//                                   ])
//                             : const Center(
//                                 child: CircularProgressIndicator(
//                                   color: AppConstant.appColor,
//                                 ),
//                               );
//                       })
//               // Text(
//               //   locationApiController.address ?? "",
//               //   style: const TextStyle(color: Colors.black),
//               // ),
//               // Visibility(
//               //   visible: locationApiController.visible,
//               //   child: Padding(
//               //     padding: EdgeInsets.only(
//               //       top: 120,
//               //     ),
//               //     child: Container(
//               //       height: MediaQuery.of(context).size.height / 2,
//               //       width: MediaQuery.of(context).size.width,
//               //       decoration: BoxDecoration(
//               //           color: Colors.white,
//               //           borderRadius: BorderRadius.all(
//               //             Radius.circular(10),
//               //           ),
//               //           boxShadow: [
//               //             BoxShadow(
//               //               color: Colors.grey,
//               //               blurRadius: 10.0,
//               //               spreadRadius: 2.0,
//               //             ), //BoxShadow
//               //             //BoxShadow
//               //           ]),
//               //       child: Positioned(
//               //         top: 110,
//               //         bottom: 20,
//               //         child: SizedBox(
//               //           height: 500,
//               //           child: ListView.builder(
//               //             physics: BouncingScrollPhysics(),
//               //             itemCount:
//               //                 locationApiController.predictions.length,
//               //             itemBuilder: (context, index) {
//               //               return ListTile(
//               //                 leading: const CircleAvatar(
//               //                   backgroundColor: Colors.transparent,
//               //                   child: Icon(
//               //                     Icons.location_on_outlined,
//               //                     color: Colors.black,
//               //                   ),
//               //                 ),
//               //                 title: Text(
//               //                   locationApiController
//               //                       .predictions[index].description
//               //                       .toString(),
//               //                 ),
//               //                 onTap: () {
//               //                   homeApiController.updateAddress(
//               //                       locationApiController
//               //                           .predictions[index].description
//               //                           .toString());
//               //                   value.clear();
//               //                   Navigator.pop(context);
//               //                 },
//               //               );
//               //             },
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               )),
//     );
//   }
// }
//
// class DetailsPage extends StatefulWidget {
//   final String placeId;
//   final GooglePlace googlePlace;
//
//   const DetailsPage(
//       {Key? key, required this.googlePlace, required this.placeId})
//       : super(key: key);
//
//   @override
//   State<DetailsPage> createState() => _DetailsPageState();
// }
//
// class _DetailsPageState extends State<DetailsPage> {
//   late DetailsResult detailsResult;
//
//   List<Uint8List> images = [];
//
//   @override
//   void initState() {
//     getDetils(widget.placeId);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Details"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueAccent,
//         onPressed: () {
//           getDetils(widget.placeId);
//         },
//         child: const Icon(Icons.refresh),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               SizedBox(
//                 height: 200,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     return SizedBox(
//                       width: 250,
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Image.memory(
//                             images[index],
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: ListView(
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: const Text(
//                           "Details",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       detailsResult.types != null
//                           ? Container(
//                               margin: const EdgeInsets.only(left: 15, top: 10),
//                               height: 50,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: detailsResult.types!.length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: const EdgeInsets.only(right: 10),
//                                     child: Chip(
//                                       label: Text(
//                                         detailsResult.types![index],
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       backgroundColor: Colors.blueAccent,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           : Container(),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.location_on),
//                           ),
//                           title: Text(
//                             detailsResult.formattedAddress != null
//                                 ? 'Address: ${detailsResult.formattedAddress}'
//                                 : "Address: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.location_searching),
//                           ),
//                           title: Text(
//                             detailsResult.geometry != null &&
//                                     detailsResult.geometry!.location != null
//                                 ? 'Geometry: ${detailsResult.geometry!.location!.lat.toString()},${detailsResult.geometry!.location!.lng.toString()}'
//                                 : "Geometry: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.timelapse),
//                           ),
//                           title: Text(
//                             detailsResult.utcOffset != null
//                                 ? 'UTC offset: ${detailsResult.utcOffset.toString()} min'
//                                 : "UTC offset: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.rate_review),
//                           ),
//                           title: Text(
//                             detailsResult.rating != null
//                                 ? 'Rating: ${detailsResult.rating.toString()}'
//                                 : "Rating: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: const CircleAvatar(
//                             child: Icon(Icons.attach_money),
//                           ),
//                           title: Text(
//                             detailsResult.priceLevel != null
//                                 ? 'Price level: ${detailsResult.priceLevel.toString()}'
//                                 : "Price level: null",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void getDetils(String placeId) async {
//     var result = await widget.googlePlace.details.get(placeId);
//     if (result != null && result.result != null && mounted) {
//       setState(() {
//         detailsResult = result.result!;
//         images = [];
//       });
//     }
//   }
// }
