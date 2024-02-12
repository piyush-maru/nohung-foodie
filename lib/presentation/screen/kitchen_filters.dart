// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:food_app/network/home_screen_repo/home_screen_api_controller.dart';
// import 'package:food_app/presentation/screen/home_screen/kitchen_categories.dart';
// import 'package:food_app/utils/constants/app_constants.dart';
// import 'package:food_app/utils/constants/ui_constants.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
//
// class KitchenFilters extends StatefulWidget {
//   const KitchenFilters({Key? key}) : super(key: key);
//
//   @override
//   _KitchenFiltersState createState() => _KitchenFiltersState();
// }
// class _KitchenFiltersState extends State<KitchenFilters> {
//   var rating = 2.5;
//   String mealFor = '';
//   String cuisine = '';
//   String mealType = '';
//   String mealPlan = '';
//   double ratings = 2.5;
//   var mealForTemp = [];
//   var cuisineTemp = [];
//   var mealTypeTemp = [];
//   var mealPlanTemp = [];
//   Set<String> selectedCuisine = Set<String>();
//   final List<String> cuisine1 = [
//     'Protein meals',
//     'Muscle gain',
//     'Weight gain meal',
//     'Low carb',
//     'Healthy meals',
//     'North Indian meals',
//     'South Indian meals',
//     'Jain Food',
//     'Weight loss',
//     'Diabetic meals',
//     'Vegan Diet',
//     'Keto meals',
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
//     Provider.of<HomeScreenProvider>(context, listen: false);
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
//                         mealForTemp.clear();
//                         cuisineTemp.clear();
//                         mealTypeTemp.clear();
//                         mealPlanTemp.clear();
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
//                   child: Row(children: [
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           mealType = '0';
//                         });
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             mealType,
//                             value.mealPlanFilter,
//                             value.minFilter,
//                             value.maxFilter);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 7),
//                         decoration: BoxDecoration(
//                             color: mealType == '0'
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(26),
//                             border:mealType == '0'
//                                 ? Border.all(color: AppConstant.appColor)
//                                 : Border.all(color: Colors.black54)),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 12),
//                         child: Row(
//                           children: [
//                             SvgPicture.asset('assets/images/leaf.svg',width: 20,height: 20),
//                             poppinsText(
//                                 maxLines: 3,
//                                 txt: "Veg",
//                                 color: mealType == '0'
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 13,
//                                 textAlign: TextAlign.center,
//                                 weight: FontWeight.w400),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           mealType = '1';
//                         });
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             mealType,
//                             value.mealPlanFilter,
//                             value.minFilter,
//                             value.maxFilter);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 7),
//                         decoration: BoxDecoration(
//                             color: mealType == '1'
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(26),
//                             border:mealType == '1'
//                                 ? Border.all(color: AppConstant.appColor)
//                                 : Border.all(color: Colors.black54)),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 12),
//                         child: Row(
//                           children: [
//                             SvgPicture.asset("assets/images/chicken.svg",width: 20,height: 20),
//                             poppinsText(
//                                 maxLines: 3,
//                                 txt: "Non-Veg",
//                                 color: mealType == '1'
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 15,
//                                 textAlign: TextAlign.center,
//                                 weight: FontWeight.w400),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           mealType = '2';
//                         });
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             mealType,
//                             value.mealPlanFilter,
//                             value.minFilter,
//                             value.maxFilter);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 7),
//                         decoration: BoxDecoration(
//                             color: mealType == '2'
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(26),
//                             border:  mealType == '2'
//                                 ? Border.all(color: AppConstant.appColor)
//                                 :Border.all(color: Colors.black54)),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 14, vertical: 12),
//                         child: Row(
//                           children: [
//                             SvgPicture.asset("assets/images/both.svg",width: 20,height: 20),
//                             poppinsText(
//                                 maxLines: 3,
//                                 txt: "Veg/ Non-Veg",
//                                 color: mealType == '2'
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontSize: 15,
//                                 textAlign: TextAlign.center,
//                                 weight: FontWeight.w400),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],),
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
//                     Container(
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         border: mealForTemp.contains('0')
//                             ? Border.all(color: AppConstant.appColor)
//                             : Border.all(color: HexColor('#2f3443').withOpacity(0.5),),
//                         borderRadius: BorderRadius.circular(12), // Border radius
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {});
//                           mealFor = "Breakfast";
//                           if (mealForTemp.contains("0")) {
//                             mealForTemp.remove('0');
//                             homeKitchenData.filtersUpdate(
//                                 mealForTemp.join(','),
//                                 value.cuisineFilter,
//                                 value.mealTypeFilter,
//                                 value.mealPlanFilter,
//                                 value.minFilter,
//                                 value.maxFilter);
//                           }
//                           else {
//                             mealForTemp.add('0');
//                             homeKitchenData.filtersUpdate(
//                                 mealForTemp.join(','),
//                                 value.cuisineFilter,
//                                 value.mealTypeFilter,
//                                 value.mealPlanFilter,
//                                 value.minFilter,
//                                 value.maxFilter);
//                           }
//                         },
//                         style: ButtonStyle(
//                           fixedSize: MaterialStateProperty.all(
//                             const Size(100, 30),
//                           ),
//                           shape: MaterialStateProperty.all(
//                             const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(12),
//                               ),
//                             ),
//                           ),
//                           backgroundColor: MaterialStateProperty.all(
//                             mealForTemp.contains('0')
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                           ),
//                         ),
//                         child: FittedBox(
//                           child: poppinsText(
//                               maxLines: 3,
//                               txt: "Breakfast",
//                               color: mealForTemp.contains('0')
//                                   ? Colors.white
//                                   : Colors.black,
//                               fontSize: 15,
//                               textAlign: TextAlign.center,
//                               weight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Container(
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         border: mealForTemp.contains('1')
//                             ? Border.all(color: AppConstant.appColor)
//                             : Border.all(
//                           color: Colors.grey,
//                           width: 1.0,
//                         ),
//                         borderRadius:
//                         BorderRadius.circular(12.0), // Border radius
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {});
//                           mealFor = "Lunch";
//                           if (mealForTemp.contains("1")) {
//                             mealForTemp.remove('1');
//                             homeKitchenData.filtersUpdate(
//                                 mealForTemp.join(','),
//                                 value.cuisineFilter,
//                                 value.mealTypeFilter,
//                                 value.mealPlanFilter,
//                                 value.minFilter,
//                                 value.maxFilter);
//                           } else {
//                             mealForTemp.add('1');
//
//                             homeKitchenData.filtersUpdate(
//                                 mealForTemp.join(','),
//                                 value.cuisineFilter,
//                                 value.mealTypeFilter,
//                                 value.mealPlanFilter,
//                                 value.minFilter,
//                                 value.maxFilter);
//                           }
//                         },
//                         style: ButtonStyle(
//                           fixedSize: MaterialStateProperty.all(
//                             const Size(90, 30),
//                           ),
//                           shape: MaterialStateProperty.all(
//                             const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(12),
//                               ),
//                             ),
//                           ),
//                           backgroundColor: MaterialStateProperty.all(
//                             mealForTemp.contains('1')
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                           ),
//                         ),
//                         child: poppinsText(
//                             maxLines: 3,
//                             txt: "Lunch",
//                             color: mealForTemp.contains('1')
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 15,
//                             textAlign: TextAlign.center,
//                             weight: FontWeight.w400),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Container(
//                       height: 40,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         border: mealForTemp.contains('2')
//                             ? Border.all(color: AppConstant.appColor)
//                             : Border.all(
//                           color: Colors.grey,
//                           width: 1.0,
//                         ),
//                         borderRadius:
//                         BorderRadius.circular(12.0), // Border radius
//                       ),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             mealFor = "Dinner";
//                             if (mealForTemp.contains("2")) {
//                               mealForTemp.remove('2');
//                               homeKitchenData.filtersUpdate(
//                                   mealForTemp.join(','),
//                                   value.cuisineFilter,
//                                   value.mealTypeFilter,
//                                   value.mealPlanFilter,
//                                   value.minFilter,
//                                   value.maxFilter);
//                             } else {
//                               mealForTemp.add('2');
//
//                               homeKitchenData.filtersUpdate(
//                                   mealForTemp.join(','),
//                                   value.cuisineFilter,
//                                   value.mealTypeFilter,
//                                   value.mealPlanFilter,
//                                   value.minFilter,
//                                   value.maxFilter);
//                             }
//                           });
//                         },
//                         style: ButtonStyle(
//                           fixedSize: MaterialStateProperty.all(
//                             const Size(100, 30),
//                           ),
//                           shape: MaterialStateProperty.all(
//                             const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(12),
//                               ),
//                             ),
//                           ),
//                           backgroundColor: MaterialStateProperty.all(
//                             mealForTemp.contains('2')
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                           ),
//                         ),
//                         child: FittedBox(
//                           child: poppinsText(
//                               maxLines: 3,
//                               txt: "Dinner",
//                               color: mealForTemp.contains('2')
//                                   ? Colors.white
//                                   : Colors.black,
//                               fontSize: 15,
//                               textAlign: TextAlign.center,
//                               weight: FontWeight.w400),
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
//                   children: cuisine1.map((String cuisineItem) {
//                     final isSelected = selectedCuisine.contains(cuisineItem);
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           if (isSelected) {
//                             selectedCuisine.remove(cuisineItem);
//                           } else {
//                             selectedCuisine.add(cuisineItem);
//                           }
//                         });
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: isSelected
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: isSelected
//                                 ? Border.all(color: AppConstant.appColor)
//                                 : Border.all(color: Colors.grey)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: poppinsText(
//                             maxLines: 3,
//                             txt: cuisineItem,
//                             color: isSelected ? Colors.white : Colors.black,
//                             fontSize: 12,
//                             textAlign: TextAlign.center,
//                             weight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
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
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           border: mealPlanTemp.contains('0')
//                               ? Border.all(color: AppConstant.appColor)
//                               : Border.all(
//                             color: Colors.grey,
//                             width: 1.0,
//                           ),
//                           borderRadius:
//                           BorderRadius.circular(12.0), // Border radius
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               mealPlan = "Weekly";
//                             });
//
//                             if (mealPlanTemp.contains("0")) {
//                               mealPlanTemp.remove('0');
//                               homeKitchenData.filtersUpdate(
//                                   value.mealForFilter,
//                                   value.cuisineFilter,
//                                   value.mealTypeFilter,
//                                   mealPlanTemp.join(','),
//                                   value.minFilter,
//                                   value.maxFilter);
//                             } else {
//                               mealPlanTemp.add('0');
//
//                               homeKitchenData.filtersUpdate(
//                                   value.mealForFilter,
//                                   value.cuisineFilter,
//                                   mealPlanTemp.join(','),
//                                   value.mealPlanFilter,
//                                   value.minFilter,
//                                   value.maxFilter);
//                             }
//                           },
//                           style: ButtonStyle(
//                             fixedSize: MaterialStateProperty.all(
//                               const Size(100, 30),
//                             ),
//                             shape: MaterialStateProperty.all(
//                               const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(12),
//                                 ),
//                               ),
//                             ),
//                             backgroundColor: MaterialStateProperty.all(
//                               mealPlanTemp.contains('0')
//                                   ? AppConstant.appColor
//                                   : Colors.white,
//                             ),
//                           ),
//                           child: FittedBox(
//                             child: poppinsText(
//                                 maxLines: 3,
//                                 txt: "Weekly",
//                                 color: mealPlanTemp.contains('0')
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
//                     Expanded(
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           border: mealPlanTemp.contains('1')
//                               ? Border.all(color: AppConstant.appColor)
//                               : Border.all(
//                             color: Colors.grey,
//                             width: 1.0,
//                           ),
//                           borderRadius:
//                           BorderRadius.circular(12.0), // Border radius
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               mealPlan = "Monthly";
//                             });
//
//                             if (mealPlanTemp.contains("1")) {
//                               mealPlanTemp.remove('1');
//
//                               homeKitchenData.filtersUpdate(
//                                   value.mealForFilter,
//                                   value.cuisineFilter,
//                                   value.mealTypeFilter,
//                                   mealPlanTemp.join(','),
//                                   value.minFilter,
//                                   value.maxFilter);
//                             } else {
//                               mealPlanTemp.add('1');
//
//                               homeKitchenData.filtersUpdate(
//                                   value.mealForFilter,
//                                   value.cuisineFilter,
//                                   mealPlanTemp.join(','),
//                                   value.mealPlanFilter,
//                                   value.minFilter,
//                                   value.maxFilter);
//                             }
//                           },
//                           style: ButtonStyle(
//                             fixedSize: MaterialStateProperty.all(
//                               const Size(90, 30),
//                             ),
//                             shape: MaterialStateProperty.all(
//                               const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(12),
//                                 ),
//                               ),
//                             ),
//                             backgroundColor: MaterialStateProperty.all(
//                               mealPlanTemp.contains('1')
//                                   ? AppConstant.appColor
//                                   : Colors.white,
//                             ),
//                           ),
//                           child: poppinsText(
//                               maxLines: 3,
//                               txt: "Monthly",
//                               color: mealPlanTemp.contains('1')
//                                   ? Colors.white
//                                   : Colors.black,
//                               fontSize: 15,
//                               textAlign: TextAlign.center,
//                               weight: FontWeight.w400),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           border: mealPlanTemp.contains('2')
//                               ? Border.all(color: AppConstant.appColor)
//                               : Border.all(
//                             color: Colors.grey,
//                             width: 1.0,
//                           ),
//                           borderRadius:
//                           BorderRadius.circular(12.0), // Border radius
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               mealPlan = "Trial Meal";
//                             });
//
//                             if (mealPlanTemp.contains("2")) {
//                               mealPlanTemp.remove('2');
//
//                               homeKitchenData.filtersUpdate(
//                                   value.mealForFilter,
//                                   value.cuisineFilter,
//                                   value.mealTypeFilter,
//                                   mealPlanTemp.join(','),
//                                   value.minFilter,
//                                   value.maxFilter);
//                             } else {
//                               mealPlanTemp.add('2');
//
//                               homeKitchenData.filtersUpdate(
//                                   value.mealForFilter,
//                                   value.cuisineFilter,
//                                   mealPlanTemp.join(','),
//                                   value.mealPlanFilter,
//                                   value.minFilter,
//                                   value.maxFilter);
//                             }
//                           },
//                           style: ButtonStyle(
//                             fixedSize: MaterialStateProperty.all(
//                               const Size(90, 30),
//                             ),
//                             shape: MaterialStateProperty.all(
//                               const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(12),
//                                 ),
//                               ),
//                             ),
//                             backgroundColor: MaterialStateProperty.all(
//                               mealPlanTemp.contains('2')
//                                   ? AppConstant.appColor
//                                   : Colors.white,
//                             ),
//                           ),
//                           child: FittedBox(
//                             child: poppinsText(
//                                 maxLines: 3,
//                                 txt: "Pre Order",
//                                 color: mealPlanTemp.contains('2')
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
//                       initialRating: value.ratingFilter,
//                       minRating: 1,
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
//                       onRatingUpdate: (rating) {
//                         value.updateRating(rating);
//                       },
//                     ),
//                     /* Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             value.decrease();
//                           },
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               color: AppConstant.appColor,
//                             ),
//                             child: const Icon(Icons.remove),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             right: 8.0,
//                             left: 8.0,
//                           ),
//                           child: Text(
//                             '${value.ratingFilter}',
//                             style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: AppConstant.fontRegular),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             value.increase();
//                           },
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: const BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                               color: AppConstant.appColor,
//                             ),
//                             child: const Icon(Icons.add),
//                           ),
//                         ),
//                       ],
//                     ),*/
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 InkWell(
//                   onTap: () {
//                     sendData();
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
//
// ////+++++++++++++++++NEW+++++++++++++++++++++
//   void sendData() {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => KitchenCategories(
//           mealFor: "",
//           mealFors:  "",
//           apply: "",
//           cuisinesFilter: "",
//           mealPlanFilter: "",
//           mealTypeFilter: "",
//           min: currentRangeValues.start,
//           max: currentRangeValues.end,
//
//         ),
//       ),
//     );
//   }
// }
// /*class _KitchenFiltersState extends State<KitchenFilters> {
//   var rating = 2.5;
//   var mealForTemp = [];
//   var cuisineTemp = [];
//   var mealTypeTemp = [];
//   var mealPlanTemp = [];
//
//   RangeValues currentRangeValues = const RangeValues(0, 1000);
//   String isMealType = "";
//   String isCuisine = "";
//
//   @override
//   void initState() {
//     super.initState();
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var homeKitchenData =
//         Provider.of<HomeScreenProvider>(context, listen: false);
//
//     return Scaffold(body: SafeArea(
//       child: Consumer<HomeScreenProvider>(builder: (context, value, child) {
//         return Padding(
//           padding: const EdgeInsets.all(14.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: SvgPicture.asset('assets/images/arrow_left.svg',
//                           height: 24)),
//                   const SizedBox(width: 6),
//                   const Text(
//                     "Filters",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 18),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       isMealType = "veg";
//                       setState(() {});
//                     },
//                     child: FilterImageAndText1(
//                         color:
//                             isMealType == "veg" ? Colors.amber : Colors.white,
//                         image: 'assets/images/leaf.svg',
//                         text: 'Veg'),
//                   ),
//                   const SizedBox(width: 10),
//                   InkWell(
//                     onTap: () {
//                       isMealType = "nonveg";
//                       setState(() {});
//                     },
//                     child: FilterImageAndText1(
//                         color: isMealType == "nonveg"
//                             ? Colors.amber
//                             : Colors.white,
//                         image: 'assets/images/chicken.svg',
//                         text: 'Non-Veg'),
//                   ),
//                   const SizedBox(width: 10),
//                   InkWell(
//                     onTap: () {
//                       isMealType = "both";
//                       setState(() {});
//                     },
//                     child: FilterImageAndText1(
//                         color:
//                             isMealType == "both" ? Colors.amber : Colors.white,
//                         image: 'assets/images/both.svg',
//                         text: 'Veg/Non-Veg'),
//                   ),
//                 ],
//               ),
//               const Text(
//                 "Cuisine",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 17),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {});
//                         if (cuisineTemp.contains("0")) {
//                           cuisineTemp.remove('0');
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         } else {
//                           cuisineTemp.add('0');
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         }
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   SizeConfig.defaultSize! * Dimens.size4),
//                             ),
//                             child: Container(
//                               height: 60,
//                               width: 60,
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   //shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(
//                                         SizeConfig.defaultSize! * Dimens.size4),
//                                   ),
//                                   color: cuisineTemp.contains('0')
//                                       ? AppConstant.appColor
//                                       : Colors.white),
//                               child: Image.asset(
//                                 Res.northMeals,
//                                 width: 25,
//                                 height: 25,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "South Indian\nmeals",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontFamily: AppConstant.fontRegular,
//                                   color: cuisineTemp.contains('0')
//                                       ? AppConstant.appColor
//                                       : Colors.black,
//                                   fontSize: 13),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {});
//                         if (cuisineTemp.contains("1")) {
//                           cuisineTemp.remove('1');
//
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         } else {
//                           cuisineTemp.add('1');
//
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         }
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   SizeConfig.defaultSize! * Dimens.size4),
//                             ),
//                             child: Container(
//                               height: 60,
//                               width: 60,
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(
//                                         SizeConfig.defaultSize! * Dimens.size4),
//                                   ),
//                                   color: cuisineTemp.contains('1')
//                                       ? AppConstant.appColor
//                                       : Colors.white),
//                               child: Image.asset(
//                                 "assets/images/masaladosa.png",
//                                 width: 20,
//                                 height: 20,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "North Indian\nmeals",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontFamily: AppConstant.fontRegular,
//                                   color: cuisineTemp.contains('1')
//                                       ? AppConstant.appColor
//                                       : Colors.black,
//                                   fontSize: 13),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {});
//                         if (cuisineTemp.contains("2")) {
//                           cuisineTemp.remove('2');
//
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         } else {
//                           cuisineTemp.add('2');
//
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         }
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   SizeConfig.defaultSize! * Dimens.size4),
//                             ),
//                             child: Container(
//                               height: 60,
//                               width: 60,
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(
//                                         SizeConfig.defaultSize! * Dimens.size4),
//                                   ),
//                                   color: cuisineTemp.contains('2')
//                                       ? AppConstant.appColor
//                                       : Colors.white),
//                               child: Image.asset(
//                                 Res.otherMeals,
//                                 width: 20,
//                                 height: 20,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Weight loss\nmeals",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: cuisineTemp.contains('2')
//                                       ? AppConstant.appColor
//                                       : Colors.black,
//                                   fontFamily: AppConstant.fontRegular,
//                                   fontSize: 13),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     child: InkWell(
//                       onTap: () {
//                         setState(() {});
//                         if (cuisineTemp.contains("3")) {
//                           cuisineTemp.remove('3');
//
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         } else {
//                           cuisineTemp.add('3');
//
//                           homeKitchenData.filtersUpdate(
//                               value.mealForFilter,
//                               cuisineTemp.join(','),
//                               value.mealTypeFilter,
//                               value.mealPlanFilter,
//                               value.minFilter,
//                               value.maxFilter);
//                         }
//                       },
//                       child: Column(
//                         children: [
//                           Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   SizeConfig.defaultSize! * Dimens.size4),
//                             ),
//                             child: Container(
//                               height: 60,
//                               width: 60,
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(
//                                         SizeConfig.defaultSize! * Dimens.size4),
//                                   ),
//                                   color: cuisineTemp.contains('3')
//                                       ? AppConstant.appColor
//                                       : Colors.white),
//                               child: Image.asset(
//                                 Res.otherMeals,
//                                 width: 20,
//                                 height: 20,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               "Healthy\nmeals",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: cuisineTemp.contains('3')
//                                       ? AppConstant.appColor
//                                       : Colors.black,
//                                   fontFamily: AppConstant.fontRegular,
//                                   fontSize: 13),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const Text(
//                 "Meal Plan",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 17),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Card(
//                       elevation: 0.05,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {});
//
//                           if (mealPlanTemp.contains("0")) {
//                             mealPlanTemp.remove('0');
//                             homeKitchenData.filtersUpdate(
//                                 value.mealForFilter,
//                                 value.cuisineFilter,
//                                 value.mealTypeFilter,
//                                 mealPlanTemp.join(','),
//                                 value.minFilter,
//                                 value.maxFilter);
//                           } else {
//                             mealPlanTemp.add('0');
//
//                             homeKitchenData.filtersUpdate(
//                                 value.mealForFilter,
//                                 value.cuisineFilter,
//                                 mealPlanTemp.join(','),
//                                 value.mealPlanFilter,
//                                 value.minFilter,
//                                 value.maxFilter);
//                           }
//                         },
//                         child: Container(
//                           height: 45,
//                           decoration: BoxDecoration(
//                             color: mealPlanTemp.contains('0')
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Weekly",
//                               style: TextStyle(
//                                   fontFamily: AppConstant.fontRegular,
//                                   color: mealPlanTemp.contains('0')
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 15),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Card(
//                       elevation: 0.05,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {});
//
//                           if (mealPlanTemp.contains("1")) {
//                             mealPlanTemp.remove('1');
//
//                             homeKitchenData.filtersUpdate(
//                                 value.mealForFilter,
//                                 value.cuisineFilter,
//                                 value.mealTypeFilter,
//                                 mealPlanTemp.join(','),
//                                 value.minFilter,
//                                 value.maxFilter);
//                           } else {
//                             mealPlanTemp.add('1');
//
//                             homeKitchenData.filtersUpdate(
//                                 value.mealForFilter,
//                                 value.cuisineFilter,
//                                 mealPlanTemp.join(','),
//                                 value.mealPlanFilter,
//                                 value.minFilter,
//                                 value.maxFilter);
//                           }
//                         },
//                         child: Container(
//                           height: 45,
//                           decoration: BoxDecoration(
//                             color: mealPlanTemp.contains('1')
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Monthly",
//                               style: TextStyle(
//                                   fontFamily: AppConstant.fontRegular,
//                                   color: mealPlanTemp.contains('1')
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 15),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Card(
//                       elevation: 0.05,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {});
//
//                           if (mealPlanTemp.contains("2")) {
//                             mealPlanTemp.remove('2');
//
//                             homeKitchenData.filtersUpdate(
//                                 value.mealForFilter,
//                                 value.cuisineFilter,
//                                 value.mealTypeFilter,
//                                 mealPlanTemp.join(','),
//                                 value.minFilter,
//                                 value.maxFilter);
//                           } else {
//                             mealPlanTemp.add('2');
//
//                             homeKitchenData.filtersUpdate(
//                                 value.mealForFilter,
//                                 value.cuisineFilter,
//                                 mealPlanTemp.join(','),
//                                 value.mealPlanFilter,
//                                 value.minFilter,
//                                 value.maxFilter);
//                           }
//                         },
//                         child: Container(
//                           height: 45,
//                           decoration: BoxDecoration(
//                             color: mealPlanTemp.contains('2')
//                                 ? AppConstant.appColor
//                                 : Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Trial Meal",
//                               style: TextStyle(
//                                   fontFamily: AppConstant.fontRegular,
//                                   color: mealPlanTemp.contains('2')
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 15),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//  ElevatedButton(
//                     onPressed: () {
//                       setState(() {});
//
//                       if (mealPlanTemp.contains("0")) {
//                         mealPlanTemp.remove('0');
//
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             value.mealTypeFilter,
//                             mealPlanTemp.join(','),
//                             value.minFilter,
//                             value.maxFilter);
//                       } else {
//                         mealPlanTemp.add('0');
//
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             mealPlanTemp.join(','),
//                             value.mealPlanFilter,
//                             value.minFilter,
//                             value.maxFilter);
//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                           mealPlanTemp.contains('0')
//                               ? AppConstant.appColor
//                               : Colors.white),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       fixedSize: MaterialStateProperty.all(
//                         const Size(100, 50),
//                       ),
//                     ),
//                     child: Text(
//                       "Weekly",
//                       style: TextStyle(
//                           fontFamily: AppConstant.fontRegular,
//                           color: mealPlanTemp.contains('0')
//                               ? Colors.white
//                               : Colors.black,
//                           fontSize: 15),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {});
//
//                       if (mealPlanTemp.contains("1")) {
//                         mealPlanTemp.remove('1');
//
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             value.mealTypeFilter,
//                             mealPlanTemp.join(','),
//                             value.minFilter,
//                             value.maxFilter);
//                       } else {
//                         mealPlanTemp.add('1');
//
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             mealPlanTemp.join(','),
//                             value.mealPlanFilter,
//                             value.minFilter,
//                             value.maxFilter);
//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                           mealPlanTemp.contains('1')
//                               ? AppConstant.appColor
//                               : Colors.white),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       fixedSize: MaterialStateProperty.all(
//                         const Size(120, 50),
//                       ),
//                     ),
//                     child: Text(
//                       "Month Plan",
//                       style: TextStyle(
//                           fontFamily: AppConstant.fontRegular,
//                           color: mealPlanTemp.contains('1')
//                               ? Colors.white
//                               : Colors.black,
//                           fontSize: 15),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {});
//
//                       if (mealPlanTemp.contains("2")) {
//                         mealPlanTemp.remove('2');
//
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             value.mealTypeFilter,
//                             mealPlanTemp.join(','),
//                             value.minFilter,
//                             value.maxFilter);
//                       } else {
//                         mealPlanTemp.add('2');
//
//                         homeKitchenData.filtersUpdate(
//                             value.mealForFilter,
//                             value.cuisineFilter,
//                             mealPlanTemp.join(','),
//                             value.mealPlanFilter,
//                             value.minFilter,
//                             value.maxFilter);
//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                           mealPlanTemp.contains('2')
//                               ? AppConstant.appColor
//                               : Colors.white),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       fixedSize: MaterialStateProperty.all(
//                         const Size(100, 50),
//                       ),
//                     ),
//                     child: Text(
//                       "Trial Meal",
//                       style: TextStyle(
//                           fontFamily: AppConstant.fontRegular,
//                           color: mealPlanTemp.contains('2')
//                               ? Colors.white
//                               : Colors.black,
//                           fontSize: 15),
//                     ),
//                   ),
//
//                 ],
//               ),
//               const Text(
//                 "Price",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 17),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "₹${currentRangeValues.start.round()}",
//                   ),
//                   Text(
//                     "₹${currentRangeValues.end.round()}",
//                   ),
//                 ],
//               ),
//               RangeSlider(
//                 activeColor: Colors.teal,
//                 values: currentRangeValues,
//                 min: 0,
//                 max: 1000,
//                 //divisions: 2,
//
//                 labels: RangeLabels(
//                   "₹${currentRangeValues.start.round()}",
//                   "₹${currentRangeValues.end.round()}",
//                 ),
//                 onChanged: (RangeValues values) {
//                   setState(() {
//                     currentRangeValues = values;
//                   });
//
//                   value.minFilter = currentRangeValues.start;
//                   value.maxFilter = currentRangeValues.end;
//                 },
//               ),
//               const Text(
//                 "Rating",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 17),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const SizedBox(width: 1),
//                   RatingBar.builder(
//                     initialRating: value.ratingFilter,
//                     minRating: 1,
//                     itemSize: 45.0, //30.0
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: const EdgeInsets.only(right: 18),
//                     itemBuilder: (context, _) => const Icon(
//                       Icons.star,
//                       color: AppConstant.appColor,
//                     ),
//                     onRatingUpdate: (rating) {
//                       value.updateRating(rating);
//                     },
//                   ),
//  Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           value.decrease();
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             color: AppConstant.appColor,
//                           ),
//                           child: Icon(Icons.remove),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           right: 8.0,
//                           left: 8.0,
//                         ),
//                         child: Text(
//                           '${value.ratingFilter}',
//                           style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: AppConstant.fontRegular),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           value.increase();
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             color: AppConstant.appColor,
//                           ),
//                           child: Icon(Icons.add),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                 ],
//               ),
//               InkWell(
//                 onTap: () {
//                   sendData(
//                       isMealType == "veg"
//                           ? "0"
//                           : isMealType == "nonveg"
//                               ? "1"
//                               : "2",
//                       true,
//                       cuisineTemp.contains("0") &&
//                               cuisineTemp.contains("1") &&
//                               cuisineTemp.contains("2") &&
//                               cuisineTemp.contains("3")
//                           ? "0,1,2,3"
//                           : cuisineTemp.contains("0")
//                               ? "0"
//                               : cuisineTemp.contains("1")
//                                   ? "1"
//                                   : cuisineTemp.contains("2")
//                                       ? "2"
//                                       : cuisineTemp.contains("3")
//                                           ? "3"
//                                           : "",
//                       mealPlanTemp.contains("0")
//                           ? "0"
//                           : mealPlanTemp.contains("1")
//                               ? "1"
//                               : mealPlanTemp.contains("2")
//                                   ? "2"
//                                   : "");
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black54,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   height: 50,
//                   child: const Center(
//                     child: Text(
//                       "APPLY FILTERS",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 17),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       }),
//     ));
//   }
//
//   void sendData(mealtypesFilter, apply, cuisine, mealPlan) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => KitchenCategories(
//             mealTypeFilter: mealtypesFilter,
//             apply: true,
//             cuisinesFilter: cuisine,
//             mealPlanFilter: mealPlan,
//             min: currentRangeValues.start,
//             max: currentRangeValues.end),
//       ),
//     );
//   }
// }*/
//
