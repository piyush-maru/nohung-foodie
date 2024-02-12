// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/model/get_archieve_offer.dart';
// import 'package:food_app/model/get_live_offer.dart';
// import 'package:food_app/network/api_provider.dart';
// import 'package:food_app/res.dart';
// import 'package:food_app/utils/constants/app_constants.dart';
// import 'package:food_app/utils/utils.dart';
//
// import '../../model/login.dart';
// import 'add_offer_screen.dart';
//
// class OfferManagementScreen extends StatefulWidget {
//   const OfferManagementScreen({Key? key}) : super(key: key);
//
//   @override
//   _OfferManagementScreenState createState() => _OfferManagementScreenState();
// }
//
// class _OfferManagementScreenState extends State<OfferManagementScreen> {
//   var isSelected = 1;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   Future? _future, futureLive;
//
//   @override
//   void initState() {
//     Future.delayed(Duration.zero, () {
//       _future = getArchiveOffer(context);
//       futureLive = getLiveOffers(context);
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: AppConstant.appColor,
//         body: Column(
//           children: [
//             SizedBox(
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         _scaffoldKey.currentState!.openDrawer();
//                       });
//                     },
//                     child: Image.asset(
//                       Res.menu,
//                       width: 30,
//                       height: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(left: 16, top: 10),
//                     child: Text(
//                       "Offer Management",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontFamily: AppConstant.fontBold),
//                     ),
//                   ),
//                 ],
//               ),
//               height: 150,
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 16, right: 16),
//               height: 55,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   border: Border.all(color: Colors.white)),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             isSelected = 1;
//                           });
//                         },
//                         child: Container(
//                           height: 60,
//                           width: 180,
//                           decoration: BoxDecoration(
//                               color: isSelected == 1
//                                   ? Colors.white
//                                   : const Color(0xffFFA451),
//                               borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(100),
//                                   bottomLeft: Radius.circular(100))),
//                           child: Center(
//                             child: Text(
//                               "Active Promos",
//                               style: TextStyle(
//                                   color: isSelected == 1
//                                       ? Colors.black
//                                       : Colors.white,
//                                   fontFamily: AppConstant.fontBold),
//                             ),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             isSelected = 2;
//                           });
//                         },
//                         child: Container(
//                           height: 60,
//                           width: 180,
//                           decoration: BoxDecoration(
//                               color: isSelected == 2
//                                   ? Colors.white
//                                   : const Color(0xffFFA451),
//                               borderRadius: const BorderRadius.only(
//                                   topRight: Radius.circular(100),
//                                   bottomRight: Radius.circular(100))),
//                           child: Center(
//                             child: Text(
//                               "Archives",
//                               style: TextStyle(
//                                   color: isSelected == 2
//                                       ? Colors.black
//                                       : Colors.white,
//                                   fontFamily: AppConstant.fontBold),
//                             ),
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20)),
//                   ),
//                   margin: const EdgeInsets.only(top: 20),
//                   child: menuSelected()),
//             ),
//           ],
//         ));
//   }
//
//   menuSelected() {
//     if (isSelected == 1) {
//       return Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 FutureBuilder<GetLiveOffer?>(
//                     future: futureLive?.then((value) => value as GetLiveOffer?),
//                     builder: (context, projectSnap) {
//                       if (projectSnap.connectionState == ConnectionState.done) {
//                         var result;
//                         if (projectSnap.data != null) {
//                           result = projectSnap.data!.data;
//                           if (result != null) {
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.vertical,
//                               physics: const BouncingScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 return getLiveOffer(result[index]);
//                               },
//                               itemCount: result.length,
//                             );
//                           }
//                         }
//                       }
//                       return const Center(
//                         child: Text(
//                           "No Live Offer",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 15,
//                               fontFamily: AppConstant.fontBold),
//                         ),
//                       );
//                     }),
//                 Positioned.fill(
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 16, bottom: 16),
//                       child: InkWell(
//                         onTap: () {
//                           addLiveOffer();
//                         },
//                         child: Image.asset(
//                           Res.addRound,
//                           width: 65,
//                           height: 65,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         children: [
//           Expanded(
//               child: Stack(
//             children: [
//               FutureBuilder<GetArchiveOffer?>(
//                   future: _future?.then((value) => value as GetArchiveOffer?),
//                   builder: (context, projectSnap) {
//                     if (projectSnap.connectionState == ConnectionState.done) {
//                       var result;
//                       if (projectSnap.data != null) {
//                         result = projectSnap.data!.data;
//                         if (result != null) {
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             physics: const BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return getArchiveOffers(result[index]);
//                             },
//                             itemCount: result.length,
//                           );
//                         }
//                       }
//                     }
//                     return const Center(
//                       child: Text(
//                         "No Archeive Offer",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontFamily: AppConstant.fontBold),
//                       ),
//                     );
//                   }),
//               Positioned.fill(
//                 child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                         padding: const EdgeInsets.only(right: 16, bottom: 16),
//                         child: InkWell(
//                           onTap: () {
//                             addArchiveOffer();
//                           },
//                           child: Image.asset(
//                             Res.addRound,
//                             width: 65,
//                             height: 65,
//                           ),
//                         ))),
//               )
//             ],
//           )),
//         ],
//       );
//     }
//   }
//
//   getArchiveOffers(result) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
//           width: 65,
//           decoration: BoxDecoration(
//               color: AppConstant.lightGreen,
//               borderRadius: BorderRadius.circular(5)),
//           height: 25,
//           child: const Center(
//             child: Text(
//               "Archieve",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: AppConstant.fontBold,
//                   fontSize: 11),
//             ),
//           ),
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   "Get " +
//                       result.discountValue +
//                       "% off on your first discount",
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontFamily: AppConstant.fontBold,
//                       fontSize: 14),
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(
//                   left: 10, bottom: 10, top: 10, right: 10),
//               width: 65,
//               decoration: BoxDecoration(
//                   color: const Color(0xffBEE8FF),
//                   borderRadius: BorderRadius.circular(5)),
//               height: 25,
//               child: Center(
//                 child: Text(
//                   result.offercode,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontFamily: AppConstant.fontBold,
//                       fontSize: 11),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 10, top: 5),
//           child: Text(
//             result.title,
//             style: const TextStyle(
//                 color: Colors.grey,
//                 fontFamily: AppConstant.fontBold,
//                 fontSize: 12),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 10, top: 5),
//           child: Text(
//             result.startdate.toString() + " " + result.enddate.toString(),
//             style: const TextStyle(
//                 color: Colors.grey,
//                 fontFamily: AppConstant.fontBold,
//                 fontSize: 12),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Divider(
//           thickness: 2,
//           color: Colors.grey.shade200,
//         ),
//       ],
//     );
//   }
//
//   Future<GetArchiveOffer?> getArchiveOffer(BuildContext context) async {
//     UserPersonalInfo userPersonalInfo = await Utils.getUser();
//     FormData from = FormData.fromMap(
//         {"user_id": userPersonalInfo.id, "token": "123456789"});
//     GetArchiveOffer? bean = await ApiProvider().getArchiveOffers(from);
//
//     if (bean?.status == true) {
//       setState(() {});
//
//       return bean;
//     } else {
//       Utils.showToast(bean!.message!);
//     }
//
//     return null;
//   }
//
//   Future<GetLiveOffer?> getLiveOffers(BuildContext context) async {
//     UserPersonalInfo userPersonalInfo = await Utils.getUser();
//     FormData from = FormData.fromMap(
//         {"user_id": userPersonalInfo.id, "token": "123456789"});
//     GetLiveOffer? bean = await ApiProvider().getLiveOffers(from);
//
//     if (bean!.status == true) {
//       setState(() {});
//
//       return bean;
//     } else {
//       Utils.showToast(bean.message!);
//     }
//
//     return null;
//   }
//
//   getLiveOffer(result) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
//           width: 65,
//           decoration: BoxDecoration(
//               color: AppConstant.lightGreen,
//               borderRadius: BorderRadius.circular(5)),
//           height: 25,
//           child: const Center(
//             child: Text(
//               "live",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: AppConstant.fontBold,
//                   fontSize: 11),
//             ),
//           ),
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Text(
//                   "Get " +
//                       result.discountValue +
//                       "% off on your first discount",
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontFamily: AppConstant.fontBold,
//                       fontSize: 14),
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(
//                   left: 10, bottom: 10, top: 10, right: 10),
//               width: 65,
//               decoration: BoxDecoration(
//                   color: const Color(0xffBEE8FF),
//                   borderRadius: BorderRadius.circular(5)),
//               height: 25,
//               child: Center(
//                 child: Text(
//                   result.offercode,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontFamily: AppConstant.fontBold,
//                       fontSize: 11),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 10, top: 5),
//           child: Text(
//             result.title,
//             style: const TextStyle(
//                 color: Colors.grey,
//                 fontFamily: AppConstant.fontBold,
//                 fontSize: 12),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 10, top: 5),
//           child: Text(
//             result.startdate + " " + result.enddate,
//             style: const TextStyle(
//                 color: Colors.grey,
//                 fontFamily: AppConstant.fontBold,
//                 fontSize: 12),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Divider(
//           thickness: 2,
//           color: Colors.grey.shade200,
//         ),
//       ],
//     );
//   }
//
//   addArchiveOffer() async {
//     var data = await Navigator.push(
//         context, MaterialPageRoute(builder: (_) => const AddOfferScreen()));
//     if (data != null) {
//       _future = getArchiveOffer(context);
//     }
//   }
//
//   addLiveOffer() async {
//     var data = await Navigator.push(
//         context, MaterialPageRoute(builder: (_) => const AddOfferScreen()));
//     if (data != null) {
//       futureLive = getLiveOffers(context);
//     }
//   }
// }
