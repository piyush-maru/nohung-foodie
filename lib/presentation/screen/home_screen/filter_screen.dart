// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:food_app/presentation/screen/kitchen_filter/kitchen_filter_screen.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
//
// import '../../../model/kitchen_filter_model/kitchen_filter_model.dart';
// import '../../../network/home_screen_repo/home_screen_api_controller.dart';
// import '../../../utils/constants/app_constants.dart';
// import '../../../utils/constants/ui_constants.dart';
//
// class FilterScreen extends StatefulWidget {
//   const FilterScreen({Key? key}) : super(key: key);
//
//   @override
//   _FilterScreenState createState() => _FilterScreenState();
// }
//
// class _FilterScreenState extends State<FilterScreen> {
//   String mealFor = '';
//   String cuisine = '';
//   String mealType = '';
//   String mealPlan = '';
//   double ratingsTemp = 0;
//   String rating = '';
//   var cuisineTemp = [];
//   // var mealTypeTemp = [];
//   // var mealPlanTemp = [];
//   Set<String> selectedCuisine = Set<String>();
//   final List<String> cuisine1 = [
//     // 'Protein meals',
//     // 'Muscle gain',
//     // 'Weight gain meal',
//     // 'Low carb',
//     // 'Healthy meals',
//     'North Indian meals',
//     'South Indian meals',
//     'Other meals',
//     // 'Jain Food',
//     // 'Weight loss',
//     // 'Diabetic meals',
//     // 'Vegan Diet',
//     // 'Keto meals',
//   ];
//
//   RangeValues currentRangeValues = const RangeValues(0, 1000);
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var homeKitchenData =
//         Provider.of<HomeScreenProvider>(context, listen: false);
//
//     return Scaffold(body: SafeArea(
//       child: Consumer<HomeScreenProvider>(builder: (context, value, child) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         InkWell(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Image.asset(
//                                 "assets/images/backyellowbutton.png",
//                                 height: 28)),
//                         const SizedBox(width: 8),
//                         poppinsText(
//                             maxLines: 3,
//                             txt: "Filters",
//                             fontSize: 18,
//                             textAlign: TextAlign.center,
//                             weight: FontWeight.w500),
//                       ],
//                     ),
//                     InkWell(
//                       onTap: () {
//                         mealFor = '';
//                         cuisine = '';
//                         mealType = '';
//                         mealPlan = '';
//                         cuisineTemp.clear();
//                         // mealTypeTemp.clear();
//                         // mealPlanTemp.clear();
//                         selectedCuisine.clear();
//                         setState(() {});
//                       },
//                       child: poppinsText(
//                         maxLines: 3,
//                         txt: "RESET",
//                         fontSize: 18,
//                         textAlign: TextAlign.center,
//                         weight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 FittedBox(
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             mealType = '0';
//                           });
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               value.cuisineFilter,
//                               mealType,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(26),
//                           elevation: 2,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0x26000000),
//                                     blurRadius: 8,
//                                     offset: Offset(0, 1),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                                 color: mealType == '0'
//                                     ? AppConstant.appColor
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(26),
//                                 border: mealType == '0'
//                                     ? Border.all(color: AppConstant.appColor)
//                                     : Border.all(color: Colors.black54)),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 14, vertical: 12),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset('assets/images/leaf.svg',
//                                     width: 20, height: 20),
//                                 poppinsText(
//                                     maxLines: 3,
//                                     txt: "Veg",
//                                     color: mealType == '0'
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: 13,
//                                     textAlign: TextAlign.center,
//                                     weight: FontWeight.w400),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             mealType = '1';
//                           });
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               value.cuisineFilter,
//                               mealType,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(26),
//                           elevation: 2,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0x26000000),
//                                     blurRadius: 8,
//                                     offset: Offset(0, 1),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                                 color: mealType == '1'
//                                     ? AppConstant.appColor
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(26),
//                                 border: mealType == '1'
//                                     ? Border.all(color: AppConstant.appColor)
//                                     : Border.all(color: Colors.black54)),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 14, vertical: 12),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset("assets/images/chicken.svg",
//                                     width: 20, height: 20),
//                                 poppinsText(
//                                     maxLines: 3,
//                                     txt: "Non-Veg",
//                                     color: mealType == '1'
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: 15,
//                                     textAlign: TextAlign.center,
//                                     weight: FontWeight.w400),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           setState(() {
//                             mealType = '2';
//                           });
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               value.cuisineFilter,
//                               mealType,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(26),
//                           elevation: 2,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0x26000000),
//                                     blurRadius: 8,
//                                     offset: Offset(0, 1),
//                                     spreadRadius: 0,
//                                   )
//                                 ],
//                                 color: mealType == '2'
//                                     ? AppConstant.appColor
//                                     : Colors.white,
//                                 borderRadius: BorderRadius.circular(26),
//                                 border: mealType == '2'
//                                     ? Border.all(color: AppConstant.appColor)
//                                     : Border.all(color: Colors.black54)),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 14, vertical: 12),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset("assets/images/both.svg",
//                                     width: 20, height: 20),
//                                 poppinsText(
//                                     maxLines: 3,
//                                     txt: "Veg/ Non-Veg",
//                                     color: mealType == '2'
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: 15,
//                                     textAlign: TextAlign.center,
//                                     weight: FontWeight.w400),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 poppinsText(
//                     txt: "Meal type",
//                     maxLines: 3,
//                     fontSize: 16,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w500),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Material(
//                       borderRadius: BorderRadius.circular(12),
//                       elevation: 2,
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: mealFor == "0"
//                               ? AppConstant.appColor
//                               : Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0x26000000),
//                               blurRadius: 8,
//                               offset: Offset(0, 1),
//                               spreadRadius: 0,
//                             )
//                           ],
//                           border: mealFor == "0"
//                               ? Border.all(color: AppConstant.appColor)
//                               : Border.all(
//                                   color: HexColor('#2f3443').withOpacity(0.5),
//                                 ),
//                           borderRadius:
//                               BorderRadius.circular(12), // Border radius
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {});
//                             mealFor = "0";
//                           },
//                           child: Center(
//                             child: poppinsText(
//                                 txt: "Breakfast",
//                                 color: mealFor == "0"
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 15,
//                                 textAlign: TextAlign.center,
//                                 weight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Material(
//                       borderRadius: BorderRadius.circular(12),
//                       elevation: 2,
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: mealFor == "1"
//                               ? AppConstant.appColor
//                               : Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0x26000000),
//                               blurRadius: 8,
//                               offset: Offset(0, 1),
//                               spreadRadius: 0,
//                             )
//                           ],
//                           border: mealFor == "1"
//                               ? Border.all(color: AppConstant.appColor)
//                               : Border.all(
//                                   color: Colors.grey,
//                                   width: 1.0,
//                                 ),
//                           borderRadius:
//                               BorderRadius.circular(12.0), // Border radius
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {});
//                             mealFor = "1";
//                           },
//                           child: Center(
//                             child: poppinsText(
//                                 txt: "Lunch",
//                                 color: mealFor == "1"
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 15,
//                                 textAlign: TextAlign.center,
//                                 weight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Material(
//                       borderRadius: BorderRadius.circular(12),
//                       elevation: 2,
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: mealFor == "2"
//                               ? AppConstant.appColor
//                               : Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0x26000000),
//                               blurRadius: 8,
//                               offset: Offset(0, 1),
//                               spreadRadius: 0,
//                             )
//                           ],
//                           border: mealFor == "2"
//                               ? Border.all(color: AppConstant.appColor)
//                               : Border.all(
//                                   color: Colors.grey,
//                                   width: 1.0,
//                                 ),
//                           borderRadius:
//                               BorderRadius.circular(12.0), // Border radius
//                         ),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               mealFor = "2";
//                             });
//                           },
//                           child: Center(
//                             child: poppinsText(
//                                 txt: "Dinner",
//                                 color: mealFor == "2"
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 15,
//                                 textAlign: TextAlign.center,
//                                 weight: FontWeight.w400),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 poppinsText(
//                   maxLines: 3,
//                   txt: "Cuisine",
//                   fontSize: 16,
//                   textAlign: TextAlign.center,
//                   weight: FontWeight.w500,
//                 ),
//                 const SizedBox(height: 10),
//                 Wrap(
//                   spacing: 8.0,
//                   runSpacing: 8.0,
//                   children: List.generate(
//                       cuisine1.length,
//                       (index) => GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 cuisine = "$index";
//                               });
//                             },
//                             child: Material(
//                               borderRadius: BorderRadius.circular(26),
//                               elevation: 2,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Color(0x26000000),
//                                         blurRadius: 8,
//                                         offset: Offset(0, 1),
//                                         spreadRadius: 0,
//                                       )
//                                     ],
//                                     color: cuisine == "$index"
//                                         ? AppConstant.appColor
//                                         : Colors.white,
//                                     borderRadius: BorderRadius.circular(8),
//                                     border: cuisine == "$index"
//                                         ? Border.all(
//                                             color: AppConstant.appColor)
//                                         : Border.all(color: Colors.grey)),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: poppinsText(
//                                     maxLines: 3,
//                                     txt: cuisine1[index],
//                                     color: cuisine == "$index"
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontSize: 12,
//                                     textAlign: TextAlign.center,
//                                     weight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )),
//                 ),
//                 const SizedBox(height: 14),
//                 poppinsText(
//                     maxLines: 3,
//                     txt: "Meal Plan",
//                     fontSize: 16,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w500),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             mealPlan = "0";
//                           });
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(12),
//                           elevation: 2,
//                           child: Container(
//                             height: 40,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: mealPlan == "0"
//                                   ? AppConstant.appColor
//                                   : Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color(0x26000000),
//                                   blurRadius: 8,
//                                   offset: Offset(0, 1),
//                                   spreadRadius: 0,
//                                 )
//                               ],
//                               border: mealPlan == "0"
//                                   ? Border.all(color: AppConstant.appColor)
//                                   : Border.all(
//                                       color: Colors.grey,
//                                       width: 1.0,
//                                     ),
//                               borderRadius:
//                                   BorderRadius.circular(12.0), // Border radius
//                             ),
//                             child: Center(
//                               child: poppinsText(
//                                   maxLines: 3,
//                                   txt: "Weekly",
//                                   color: mealPlan == "0"
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 15,
//                                   textAlign: TextAlign.center,
//                                   weight: FontWeight.w400),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             mealPlan = "1";
//                           });
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(12),
//                           elevation: 2,
//                           child: Container(
//                             height: 40,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: mealPlan == "1"
//                                   ? AppConstant.appColor
//                                   : Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color(0x26000000),
//                                   blurRadius: 8,
//                                   offset: Offset(0, 1),
//                                   spreadRadius: 0,
//                                 )
//                               ],
//                               border: mealPlan == "1"
//                                   ? Border.all(color: AppConstant.appColor)
//                                   : Border.all(
//                                       color: Colors.grey,
//                                       width: 1.0,
//                                     ),
//                               borderRadius:
//                                   BorderRadius.circular(12.0), // Border radius
//                             ),
//                             child: Center(
//                               child: poppinsText(
//                                   txt: "Monthly",
//                                   color: mealPlan == "1"
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 15,
//                                   textAlign: TextAlign.center,
//                                   weight: FontWeight.w400),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             mealPlan = "2";
//                           });
//                         },
//                         child: Material(
//                           borderRadius: BorderRadius.circular(26),
//                           elevation: 2,
//                           child: Container(
//                             height: 40,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               color: mealPlan == "2"
//                                   ? AppConstant.appColor
//                                   : Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color(0x26000000),
//                                   blurRadius: 8,
//                                   offset: Offset(0, 1),
//                                   spreadRadius: 0,
//                                 )
//                               ],
//                               border: mealPlan == "2"
//                                   ? Border.all(color: AppConstant.appColor)
//                                   : Border.all(
//                                       color: Colors.grey,
//                                       width: 1.0,
//                                     ),
//                               borderRadius:
//                                   BorderRadius.circular(12.0), // Border radius
//                             ),
//                             child: Center(
//                               child: poppinsText(
//                                   maxLines: 3,
//                                   txt: "Pre Order",
//                                   color: mealPlan == "2"
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 15,
//                                   textAlign: TextAlign.center,
//                                   weight: FontWeight.w400),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 poppinsText(
//                     maxLines: 3,
//                     txt: "Price",
//                     fontSize: 16,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w500),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "₹${currentRangeValues.start.round()}",
//                     ),
//                     Text(
//                       "₹${currentRangeValues.end.round()}",
//                     ),
//                   ],
//                 ),
//                 RangeSlider(
//                   activeColor: Colors.teal,
//                   values: currentRangeValues,
//                   min: 0,
//                   max: 1500,
//                   //divisions: 2,
//                   labels: RangeLabels(
//                     "₹${currentRangeValues.start.round()}",
//                     "₹${currentRangeValues.end.round()}",
//                   ),
//                   onChanged: (RangeValues values) {
//                     setState(() {
//                       currentRangeValues = values;
//                     });
//                     value.minFilter = currentRangeValues.start;
//                     value.maxFilter = currentRangeValues.end;
//                   },
//                 ),
//                 poppinsText(
//                     maxLines: 3,
//                     txt: "Ratings",
//                     fontSize: 16,
//                     textAlign: TextAlign.center,
//                     weight: FontWeight.w500),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(width: 10),
//                     RatingBar.builder(
//                       initialRating: ratingsTemp,
//                       minRating: 0,
//                       itemSize: 30.0,
//                       allowHalfRating: true,
//                       itemCount: 5,
//                       itemPadding: const EdgeInsets.only(right: 34),
//                       itemBuilder: (context, _) => const Image(
//                         image: AssetImage("assets/images/Icon_s.png"),
//                         height: 35,
//                         width: 35,
//                       ),
//                       /*Icon(
//                         Icons.star,
//                         color: AppConstant.appColor,
//                       ),*/
//                       onRatingUpdate: (newRating) {
//                         setState(() {
//                           ratingsTemp = newRating;
//                           rating = newRating.round().toString();
//                         });
//                         // value.updateRating(rating);
//                       },
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FilteredKitchensScreen(
//                           kitchenFilters: KitchenFilters(
//                             rating: rating,
//                             minPrice:
//                                 currentRangeValues.start.round().toString(),
//                             mealplan: mealPlan,
//                             mealfor: mealFor,
//                             maxPrice: currentRangeValues.end.round().toString(),
//                             cuisinetype: cuisine,
//                             mealtype: mealType,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xff2F3443),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     height: 50,
//                     child: Center(
//                       child: poppinsText(
//                           maxLines: 3,
//                           txt: "APPLY FILTERS",
//                           color: Colors.white,
//                           fontSize: 16,
//                           textAlign: TextAlign.center,
//                           weight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     ));
//   }
// }
