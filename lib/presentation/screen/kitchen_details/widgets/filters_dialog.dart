// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../utils/constants/app_constants.dart';
// import '../../../../utils/constants/ui_constants.dart';
//
// class PreorderFilterDialog extends StatefulWidget {
//   const PreorderFilterDialog({super.key});
//
//   @override
//   State<PreorderFilterDialog> createState() => _PreorderFilterDialogState();
// }
//
// class _PreorderFilterDialogState extends State<PreorderFilterDialog> {
//   int selectedCompanionIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.sizeOf(context).width;
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: AppConstant.appColor, // Set the border color
//               width: 1.0, // Set the border width
//             ),
//             borderRadius: BorderRadius.circular(36.0),
//             color: Colors.white,
//           ),
//           child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       "Filters",
//                       style: AppTextStyles.boldText
//                           .copyWith(color: Colors.black, fontSize: 19),
//                     ),
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Image.asset(
//                         "assets/images/xcircle.png",
//                         width: 45,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   "Meal Type",
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.semiBoldText
//                       .copyWith(color: Colors.black, fontSize: 18),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 FittedBox(
//                   child: Row(
//                     children: mealTypeList
//                         .map(
//                           (e) => InkResponse(
//                             onTap: () {
//                               provider.updateMealType(e.name);
//                               setState(() {});
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 7),
//                               decoration: BoxDecoration(
//                                   color: provider.mealTypeFilter == e.name
//                                       ? AppConstant.appColor
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(color: Colors.black54)),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 8),
//                               child: Row(
//                                 children: [
//                                   SvgPicture.asset(
//                                     e.icon,
//                                   ),
//                                   Text(e.name),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Text(
//                   "Cuisine Type",
//                   textAlign: TextAlign.center,
//                   style: AppTextStyles.semiBoldText
//                       .copyWith(color: Colors.black, fontSize: 18),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 Row(
//                   children: cuisineTypeList
//                       .map(
//                         (e) => Expanded(
//                           child: InkResponse(
//                             onTap: () {
//                               provider.updateCuisineTypeList(e);
//                               setState(() {});
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 3),
//                               decoration: BoxDecoration(
//                                   color: provider.cuisineTypeFilters.contains(e)
//                                       ? AppConstant.appColor
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(color: Colors.black54)),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 8),
//                               child: FittedBox(
//                                   fit: BoxFit.scaleDown, child: Text(e)),
//                             ),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//                 const SizedBox(
//                   height: 18,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 11,
//                       ),
//                       //width: double.infinity,
//                       alignment: Alignment.center,
//                       child: const Padding(
//                         padding: EdgeInsets.only(
//                             left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
//                         child: Text(
//                           "Reset Filters",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: kYellowColor,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 11,
//                       ),
//                       //width: double.infinity,
//                       alignment: Alignment.center,
//                       child: const Padding(
//                         padding: EdgeInsets.only(
//                             left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
//                         child: Text(
//                           "Apply Filters",
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ]),
//         ),
//       ),
//     );
//   }
// }
