import 'package:flutter/material.dart';
import 'package:food_app/customWidgets/kitchen_details_IconText.dart';

class MealsInAWeek extends StatelessWidget {
  final String includingSaturday;
  final String includingSunday;

  const MealsInAWeek({super.key, 
    required this.includingSunday,
    required this.includingSaturday,
  });

  @override
  Widget build(BuildContext context) {
    switch ("$includingSunday $includingSaturday") {
      case "0 1":
        return const CuisineTypeText(text: "6 Meals/Week");
      case "1 0":
        return const CuisineTypeText(text: "6 Meals/Week");
      case "1 1":
        return const CuisineTypeText(text: "7 Meals/Week");
      case "0 0":
        return const CuisineTypeText(text: "5 Meals/Week");
      default:
        return const CuisineTypeText(text: "5 Meals/Week");
    }
  }
}

