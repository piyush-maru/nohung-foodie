// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:food_app/utils/constants/app_constants.dart';
//
// import '../model/destination.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int index = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: SafeArea(
//             child: Padding(
//                 padding: EdgeInsets.only(left: 12, right: 12, bottom: 16),
//                 child: BottomNavigationBar(
//                     backgroundColor: Colors.black,
//                     selectedItemColor: const Color(0xFFFFA451),
//                     unselectedItemColor: Colors.white,
//                     currentIndex: index,
//                     onTap: (idx) {
//                       setState(() {
//                         index = idx;
//                       });
//                     },
//                     items: allDestinations
//                         .map(
//                           (Destination destination) => BottomNavigationBarItem(
//                               icon: SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: SvgPicture.asset(destination.iconPath),
//                               ),
//                               label: destination.name),
//                         )
//                         .toList()))),
//         body: SafeArea(
//           top: false,
//           child: Container(
//               height: 500,
//               width: 500,
//               child: IndexedStack(
//                 index: index,
//                 children:
//                     allDestinations.map<Widget>((Destination destination) {
//                   return destination.child ?? SizedBox();
//                 }).toList(),
//               )),
//         ));
//   }
// }
