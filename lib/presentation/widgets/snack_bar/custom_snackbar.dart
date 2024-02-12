import 'package:flutter/material.dart';
import 'package:food_app/utils/constants/ui_constants.dart';

ScaffoldFeatureController CustomSnackBarMsg(
    {required BuildContext context,
    required String text,
    required int time,
    w}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: double.infinity,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: Duration(seconds: time),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kYellowColor,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.info, color: Colors.white),
          poppinsText(
              txt: '   Note :  ',
              color: Colors.white,
              fontSize: 15,
              weight: FontWeight.w700),
          Expanded(
            child: poppinsText(
                txt: text,
                fontSize: 14,
                color: Colors.white,
                weight: FontWeight.w500,
                maxLines: 5),
          ),
        ]),
      ),
    ),
  );
}

ScaffoldFeatureController CustomErrorSnackBarMsg({
  required BuildContext context,
  required String text,
  required int time,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: double.infinity,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: Duration(seconds: time),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.red,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(
            Icons.warning,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: poppinsText(
                txt: text,
                fontSize: 14,
                color: Colors.white,
                maxLines: 5,
                weight: FontWeight.w600),
          ),
        ]),
      ),
    ),
  );
}
