import 'package:flutter/material.dart';

import '../../../utils/constants/ui_constants.dart';
import '../../screen/authentication_screens/login/login_with_mobile_screen.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginWithMobileScreen(),
            ),
            (route) => false);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: ShapeDecoration(
          color: kYellowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Text(
          "Login",
          style: AppTextStyles.titleText.copyWith(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
