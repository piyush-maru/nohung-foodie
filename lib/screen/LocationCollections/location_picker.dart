// import 'package:flutter/material.dart';
// import 'package:food_app/utils/constants/app_constants.dart';
// import 'package:food_app/utils/constants/ui_constants.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../../../network/location_screen/location_repo.dart';
//
// Future<void> locationSheet(
//     {required BuildContext context,
//       required PickResult selectedPlace,
//       bool isToEdit = false,
//       String? addressId}) {
//   final locationController = TextEditingController();
//   final streetController = TextEditingController();
//   final landMarkController = TextEditingController();
//   locationController.text = selectedPlace.formattedAddress ?? "";
//   bool showValue1 = true;
//   bool showValue2 = false;
//   bool showValue3 = false;
//   final addressProvider = Provider.of<UserLocations>(context, listen: false);
//
//   return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         // locationController.text = selectedPlace.name!;
//         return  Scaffold(
//           body: SizedBox(
//             height: 700,
//             child: ListView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.all(8.0),
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black45),
//                   ),
//                   child: Text(
//                     locationController.text,
//                     style: AppTextStyles.normalText.copyWith(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 // TextFormField(
//                 //   enabled: false,
//                 //   cursorColor: Colors.black,
//                 //   keyboardType: TextInputType.multiline,
//                 //   decoration: InputDecoration(
//                 //     hintText: "House No",
//                 //     prefixIcon: Icon(Icons.my_location_outlined),
//                 //     hintStyle:
//                 //         const TextStyle(fontFamily: AppConstant.fontRegular),
//                 //     border: OutlineInputBorder(
//                 //       borderRadius: BorderRadius.circular(8),
//                 //       borderSide: const BorderSide(
//                 //         width: 3,
//                 //         style: BorderStyle.none,
//                 //       ),
//                 //     ),
//                 //     fillColor: Colors.black,
//                 //     focusedBorder: const OutlineInputBorder(
//                 //       borderSide: BorderSide(color: Colors.black),
//                 //     ),
//                 //   ),
//                 //   onChanged: (value) {
//                 //     print(value);
//                 //   },
//                 //   controller: locationController,
//                 // ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 TextFormField(
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     hintText: "Type door/ Flat No",
//                     hintStyle:
//                     const TextStyle(fontFamily: AppConstant.fontRegular),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         width: 3,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     fillColor: Colors.black,
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                   ),
//                   controller: streetController,
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 TextFormField(
//                   cursorColor: Colors.black,
//                   decoration: InputDecoration(
//                     hintText: "LandMark",
//                     hintStyle:
//                     const TextStyle(fontFamily: AppConstant.fontRegular),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: const BorderSide(
//                         width: 3,
//                         style: BorderStyle.none,
//                       ),
//                     ),
//                     fillColor: Colors.black,
//                     focusedBorder: const OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                   ),
//                   controller: landMarkController,
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Checkbox(
//                         checkColor: Colors.white,
//                         splashRadius: 12,
//                         side: const BorderSide(
//                             style: BorderStyle.solid,
//                             width: 1,
//                             color: Colors.black),
//                         fillColor: MaterialStateProperty.all(Colors.black),
//                         value: showValue1,
//                         onChanged: (value) {
//                           // setState(() {
//                           showValue1 = true;
//                           showValue2 = false;
//                           showValue3 = false;
//                           // });
//                         }),
//                     const Text(
//                       "Home",
//                       style: TextStyle(fontFamily: AppConstant.fontRegular),
//                     ),
//                     const SizedBox(
//                       width: 36,
//                     ),
//                     Checkbox(
//                         checkColor: Colors.white,
//                         splashRadius: 12,
//                         side: const BorderSide(
//                             style: BorderStyle.solid,
//                             width: 1,
//                             color: Colors.black),
//                         fillColor: MaterialStateProperty.all(Colors.black),
//                         value: showValue2,
//                         onChanged: (value) {
//                           //setState(() {
//                           showValue2 = true;
//                           showValue1 = false;
//                           showValue3 = false;
//                           //});
//                         }),
//                     const Text(
//                       "Office",
//                       style: TextStyle(fontFamily: AppConstant.fontRegular),
//                     ),
//                     const SizedBox(
//                       width: 36,
//                     ),
//                     Checkbox(
//                         checkColor: Colors.white,
//                         splashRadius: 12,
//                         side: const BorderSide(
//                             style: BorderStyle.solid,
//                             width: 1,
//                             color: Colors.black),
//                         fillColor: MaterialStateProperty.all(Colors.black),
//                         value: showValue3,
//                         onChanged: (value) {
//                           //setState(() {
//                           showValue3 = true;
//                           showValue2 = false;
//                           showValue1 = false;
//                           // });
//                         }),
//                     const Text(
//                       "Others",
//                       style: TextStyle(fontFamily: AppConstant.fontRegular),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     fixedSize: MaterialStateProperty.all(
//                       const Size(200, 50),
//                     ),
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                     ),
//                     backgroundColor: MaterialStateProperty.all(Colors.black),
//                   ),
//                   onPressed: () {
//                     if (showValue1 == false &&
//                         showValue2 == false &&
//                         showValue3 == false) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text(
//                             'Please Select Home or Office or Others',
//                             style: TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       if (isToEdit) {
//                         print("to edit");
//                         addressProvider
//                             .editLocation(
//                             addressId: addressId!,
//                             location: locationController.text,
//                             longitude: selectedPlace.geometry!.location.lng
//                                 .toString(),
//                             latitude: selectedPlace.geometry!.location.lat
//                                 .toString(),
//                             street: streetController.text,
//                             landmark: landMarkController.text,
//                             addressType: showValue1 == true
//                                 ? "Home"
//                                 : showValue2 == true
//                                 ? "Office"
//                                 : "Others")
//                             .then((value) {
//                           print(value);
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                           addressProvider.getUserAddressList();
//
//                           //addressProvider.getUserAddressList().then((value) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text(
//                                 'Location Saved',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                       } else {
//                         print("to save");
//                         addressProvider
//                             .addNewAddress(
//                             location: locationController.text,
//                             longitude: selectedPlace.geometry!.location.lng
//                                 .toString(),
//                             latitude: selectedPlace.geometry!.location.lat
//                                 .toString(),
//                             street: streetController.text,
//                             landmark: landMarkController.text,
//                             addressType: showValue1 == true
//                                 ? "Home"
//                                 : showValue2 == true
//                                 ? "Office"
//                                 : "Other")
//                             .then((value) {
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                           addressProvider.getUserAddressList();
//
//                           //addressProvider.getUserAddressList().then((value) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text(
//                                 'Location Saved',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           );
//                         });
//                       }
//                     }
//                   },
//                   child: const Text(
//                     'Save',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: AppConstant.fontRegular),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       });
// }
//
//
