import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/presentation/widgets/text_field/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../../network/login_api/login_api_controller.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../../widgets/snack_bar/custom_snackbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailTC = TextEditingController();
  final _mobileTC = TextEditingController();
  @override
  void dispose() {
    _emailTC.dispose();
    _mobileTC.dispose();
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
                  Navigator.pop(context);
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
                        txt: "Forgot Password",
                        fontSize: 18,
                        weight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldFloatingLabel(
                    prefixIcon: Icons.email_outlined,
                    controller: _emailTC,
                    hint: "Email Address",
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomTextFieldFloatingLabel(
                    prefixIcon: Icons.phone,
                    controller: _mobileTC,
                    hint: "Mobile Number",
                    textInputType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      FilteringTextInputFormatter.deny(
                          new RegExp(r"\s\b|\b\s")),
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  loginApiController.isLoading
                      ? LoadingAnimatedButton(
                          width: screenWidth * 0.6,
                          child: poppinsText(
                              txt: "Send OTP",
                              weight: FontWeight.w500,
                              fontSize: 20),
                          onTap: () {},
                        )
                      : InkResponse(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_emailTC.text.trim().isEmpty ||
                                _mobileTC.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              CustomErrorSnackBarMsg(
                                  text: "Please enter all the required fields.",
                                  context: context,
                                  time: 2);
                            } else if (_mobileTC.text.trim().length != 10) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              CustomErrorSnackBarMsg(
                                  text: "Please enter a valid phone number.",
                                  context: context,
                                  time: 2);
                            } else {
                              loginApiController.forgotPassword(
                                  email: _emailTC.text.trim(),
                                  phone: _mobileTC.text.trim(),
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
                              txt: "Send OTP",
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
