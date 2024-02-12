import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/presentation/widgets/text_field/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../../network/login_api/login_api_controller.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../../widgets/snack_bar/custom_snackbar.dart';
import '../login/login_with_mobile_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen(
      {super.key, required this.code, required this.userID});
  final String code;
  final String userID;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordTC = TextEditingController();
  final _confirmPasswordTC = TextEditingController();
  @override
  void dispose() {
    _passwordTC.dispose();
    _confirmPasswordTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginApiController = Provider.of<LoginApiController>(context);
    final safeArea = MediaQuery.paddingOf(context).top;

    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image_authentication_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: safeArea,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginWithMobileScreen()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: kYellowColor, width: 2)),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: poppinsText(
                        txt: "Back",
                        weight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset(
                    'assets/icons/icon_phone.svg',
                    width: screenWidth * 0.4,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: poppinsText(
                        txt: "Change Password",
                        fontSize: 18,
                        weight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldFloatingLabel(
                    prefixIcon: Icons.lock_outline,
                    controller: _passwordTC,
                    hint: "New Password",
                    textInputType: TextInputType.text,
                    isObscure: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomTextFieldFloatingLabel(
                    prefixIcon: Icons.lock_outline,
                    controller: _confirmPasswordTC,
                    hint: "Confirm Password",
                    textInputType: TextInputType.text,
                    isObscure: false,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  loginApiController.isLoading
                      ? LoadingAnimatedButton(
                          width: screenWidth * 0.6,
                          child: poppinsText(
                              txt: "Confirm",
                              weight: FontWeight.w500,
                              fontSize: 20),
                          onTap: () {},
                        )
                      : InkResponse(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());

                            if (_passwordTC.text.trim().isEmpty ||
                                _confirmPasswordTC.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              CustomErrorSnackBarMsg(
                                  text: "Please enter all the required fields.",
                                  context: context,
                                  time: 2);
                            } else if (_passwordTC.text.trim() !=
                                _confirmPasswordTC.text.trim()) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              CustomErrorSnackBarMsg(
                                  text: "Both password fields don't match.",
                                  context: context,
                                  time: 2);
                            } else {
                              loginApiController.resetPassword(
                                  userID: widget.userID,
                                  code: widget.code,
                                  password: _passwordTC.text.trim(),
                                  context: context);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: screenWidth * 0.6,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x26050522),
                                    blurRadius: 10,
                                    offset: Offset(-1, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment(1.00, 0.01),
                                  end: Alignment(-1, -0.01),
                                  colors: [
                                    Color(0xFFFCC546),
                                    Color(0xAEFFB200)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(13)),
                            child: poppinsText(
                              txt: "Confirm",
                              weight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
