import 'package:flutter/material.dart';

import '../../../utils/constants/ui_constants.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onTap,
    required this.title,
  });
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 11),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(42),
        ),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: poppinsText(
              color: Colors.white,
              txt: title,
              weight: FontWeight.w500,
              fontSize: 16),
        ),
      ),
    );
  }
}
