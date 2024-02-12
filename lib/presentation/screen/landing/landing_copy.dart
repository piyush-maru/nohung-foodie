// import 'package:flutter/material.dart';
// import 'package:food_app/utils/constants/ui_constants.dart';
//
// import '../../../utils/constants/asset_constants.dart';
// import '../Cart/cart_screen.dart';
// import '../Profile/profile.dart';
// import '../home_screen/home_screen.dart';
// import '../orders_tab/order_history_screen.dart';
//
// class LandingScreen extends StatefulWidget {
//   const LandingScreen({Key? key}) : super(key: key);
//
//   @override
//   _LandingScreenState createState() => _LandingScreenState();
// }
//
// class _LandingScreenState extends State<LandingScreen> {
//   final PageController _pageController = PageController(initialPage: 0);
//   final PageController _pageController1 = PageController(initialPage: 0);
//   int _currentIndex = 0;
//   int maxCount = 4;
//   final List<Widget> _children = [
//     const HomeScreen(mealFor: "mealFor", fromHome: true),
//     const CartScreen(),
//     const OrderHistoryScreen(),
//     const Profile()
//   ];
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//       _pageController.animateToPage(
//         index,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           color: Colors.white,
//           child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 10),
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: _children.length,
//               itemBuilder: (context, index) {
//                 return _children[index];
//               },
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               },
//               pageSnapping: true,
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: Stack(
//         children: [
//           Container(
//             height: 65,
//             padding: const EdgeInsets.only(top: 15),
//             decoration: BoxDecoration(
//               color: Colors.white, //botmColor,
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//               border: Border.all(
//                 color: Colors.black45,
//                 width: 0.5,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: InkWell(
//                       onTap: () {
//                         _currentIndex = 0;
//                         onTabTapped(_currentIndex);
//                       },
//                       child: Column(
//                         children: [
//                           _currentIndex == 0
//                               ? Image.asset(
//                                   Assets.icons.homeSelected,
//                                   height: 100,
//                                   width: 100,
//                                 )
//                               : Image.asset(
//                                   Assets.icons.home,
//                                   height: 30,
//                                 ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           poppinsText(
//                             txt: 'Home',
//                             fontSize: 11,
//                             weight: FontWeight.w500,
//                             color: kTextPrimary,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: InkWell(
//                       onTap: () {
//                         _currentIndex = 1;
//                         onTabTapped(_currentIndex);
//                       },
//                       child: Column(
//                         children: [
//                           _currentIndex == 1
//                               ? Image.asset(
//                                   Assets.icons.cartSelected,
//                                   height: 30,
//                                 )
//                               : Image.asset(
//                                   Assets.icons.cart,
//                                   height: 30,
//                                 ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           poppinsText(
//                             txt: 'Cart',
//                             fontSize: 11,
//                             weight: FontWeight.w500,
//                             color: kTextPrimary,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: InkWell(
//                       onTap: () {
//                         _currentIndex = 2;
//
//                         onTabTapped(_currentIndex);
//                       },
//                       child: Column(
//                         children: [
//                           _currentIndex == 2
//                               ? Image.asset(Assets.icons.ordersSelected,
//                                   height: 30)
//                               : Image.asset(Assets.icons.orders, height: 30),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           poppinsText(
//                             txt: 'Orders',
//                             fontSize: 11,
//                             weight: FontWeight.w500,
//                             color: kTextPrimary,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: InkWell(
//                       onTap: () {
//                         _currentIndex = 3;
//                         onTabTapped(_currentIndex);
//                       },
//                       child: Column(
//                         children: [
//                           _currentIndex == 3
//                               ? Image.asset(
//                                   Assets.icons.profileSelected,
//                                   height: 30,
//                                 )
//                               : Image.asset(
//                                   Assets.icons.profile,
//                                   height: 30,
//                                 ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           poppinsText(
//                             txt: 'Profile',
//                             fontSize: 11,
//                             weight: FontWeight.w500,
//                             color: kTextPrimary,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /*bottomNavigationBar:AnimatedNotchBottomBar(
//           notchBottomBarController: _controller,
//           color: Colors.white,
//           showLabel: false,
//           notchColor: Colors.black87,
//           removeMargins: false,
//           bottomBarWidth: 500,
//           durationInMilliSeconds: 300,
//           bottomBarItems: [
//              BottomBarItem(
//               inActiveItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 0;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: Icon(
//                   Icons.home_filled,
//                   color: Colors.blueGrey,
//                 ),
//               ),
//               activeItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 0;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: Icon(
//                   Icons.home_filled,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               itemLabel: 'Page 1',
//             ),
//              BottomBarItem(
//               inActiveItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 1;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: Icon(
//                   Icons.star,
//                   color: Colors.blueGrey,
//                 ),
//               ),
//               activeItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 1;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: Icon(
//                   Icons.star,
//                   color: Colors.blueAccent,
//                 ),
//               ),
//               itemLabel: 'Page 2',
//             ),
//             BottomBarItem(
//               inActiveItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 2;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: SvgPicture.asset(
//                   'assets/search_icon.svg',
//                   color: Colors.blueGrey,
//                 ),
//               ),
//               activeItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 2;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: SvgPicture.asset(
//                   'assets/search_icon.svg',
//                   color: Colors.white,
//                 ),
//               ),
//               itemLabel: 'Page 3',
//             ),
//              BottomBarItem(
//               inActiveItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 3;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: Icon(
//                   Icons.settings,
//                   color: Colors.blueGrey,
//                 ),
//               ),
//               activeItem: InkWell(
//                 onTap: () {
//                   _currentIndex = 3;
//                   onTabTapped(_currentIndex);
//                 },
//                 child: Icon(
//                   Icons.settings,
//                   color: Colors.pink,
//                 ),
//               ),
//               itemLabel: 'Page 4',
//             ),
//           ],
//           onTap: (index) {
//             log('current selected index $index');
//             _pageController.jumpToPage(index);
//           },
//         )*/
