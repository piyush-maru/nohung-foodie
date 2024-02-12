import 'package:flutter/material.dart';
import 'package:food_app/customWidgets/kitchen_details_IconText.dart';

class IncludingMealInWeekend extends StatelessWidget {
  final String includingSaturday;
  final String includingSunday;

  const IncludingMealInWeekend({super.key, 
    required this.includingSunday,
    required this.includingSaturday,
  });

  @override
  Widget build(BuildContext context) {
    switch ("$includingSunday $includingSaturday") {
      case "0 1":
        return const CuisineTypeText(text: "Including Sat");
      case "1 0":
        return const CuisineTypeText(text: "Including Sun");
      case "1 1":
        return const CuisineTypeText(text: "Including Sat/Sun");
      case "0 0":
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }
}
