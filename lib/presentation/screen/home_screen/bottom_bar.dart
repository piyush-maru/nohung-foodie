// import 'dart:async';
// import 'package:easy_debounce/easy_debounce.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:food_app/controller/bottomBarController.dart';
// import 'package:food_app/utils/constants/app_constants.dart';
// import 'package:provider/provider.dart';
//
// class Bottom extends StatefulWidget {
//   final int selectedIndex;
//
//   Bottom({Key? key, required this.selectedIndex}) : super(key: key);
//
//   @override
//   State<Bottom> createState() => _BottomState();
// }
//
// class _BottomState extends State<Bottom> {
//   Timer? _timer;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Consumer<BottomBarController>(
//               builder: (context, v, child) {
//                 return Container(
//                   margin:
//                       const EdgeInsets.only(left: 12, bottom: 12, right: 12),
//                   height: 65,
//                   padding: const EdgeInsets.only(top: 12),
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(24),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           v.update(0);
//                           EasyDebounce.debounce(
//                               'my-debouncer',
//                               const Duration(milliseconds: 1000),
//                               () => Navigator.pushNamed(context, '/home'));
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               "assets/images/home.svg",
//                               color: v.selectedIndex == 0
//                                   ? Color(0xFFFFA451)
//                                   : Colors.white,
//                             ),
//                             Text(
//                               'Home',
//                               style: TextStyle(
//                                   color: v.selectedIndex == 0
//                                       ? Color(0xFFFFA451)
//                                       : Colors.white,
//                                   fontFamily: AppConstant.fontRegular),
//                             ),
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           v.update(1);
//                           EasyDebounce.debounce(
//                             'my-debouncer',
//                             const Duration(milliseconds: 1000),
//                             () => Navigator.pushNamed(context, '/orderScreen'),
//                           );
//                         },
//                         child: Column(children: [
//                           Image.asset(
//                             'assets/images/ic_order_history.png',
//                             color: v.selectedIndex == 1
//                                 ? Color(0xFFFFA451)
//                                 : Colors.white,
//                             height: 25,
//                           ),
//                           Text(
//                             'Orders ',
//                             style: TextStyle(
//                                 fontFamily: AppConstant.fontRegular,
//                                 color: v.selectedIndex == 1
//                                     ? const Color(0xFFFFA451)
//                                     : Colors.white),
//                           ),
//                         ]),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           v.update(2);
//
//                           EasyDebounce.debounce(
//                             'my-debouncer',
//                             const Duration(milliseconds: 1000),
//                             () => Navigator.pushNamed(context, '/cart'),
//                           );
//                         },
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.add_shopping_cart,
//                               color: v.selectedIndex == 2
//                                   ? Color(0xFFFFA451)
//                                   : Colors.white,
//                               size: 30,
//                             ),
//                             Text(
//                               "Cart",
//                               style: TextStyle(
//                                   color: v.selectedIndex == 2
//                                       ? Color(0xFFFFA451)
//                                       : Colors.white,
//                                   fontFamily: AppConstant.fontRegular),
//                             )
//                           ],
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           v.update(3);
//
//                           EasyDebounce.debounce(
//                             'my-debouncer',
//                             const Duration(milliseconds: 1000),
//                             () => Navigator.pushNamed(context, "/profile"),
//                           );
//                         },
//                         child: Column(children: [
//                           Image.asset(
//                             'assets/images/ic_profile.png',
//                             color: v.selectedIndex == 3
//                                 ? Color(0xFFFFA451)
//                                 : Colors.white,
//                             height: 30,
//                           ),
//                           Text(
//                             'Profile',
//                             style: TextStyle(
//                                 color: v.selectedIndex == 3
//                                     ? const Color(0xFFFFA451)
//                                     : Colors.white,
//                                 fontFamily: AppConstant.fontRegular),
//                           ),
//                         ]),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//   }
// }
