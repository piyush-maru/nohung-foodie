import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/presentation/widgets/text_field/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../../menu/privacy_policy.dart';
import '../../../../network/login_api/login_api_controller.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../../widgets/quarter_circle/quarter_circle.dart';
import '../../../widgets/snack_bar/custom_snackbar.dart';
import '../../Profile/terms_conditions.dart';
import '../../landing/landing_screen.dart';
import '../login/login_with_mobile_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, this.mobileNumber});
  final String? mobileNumber;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isChecked = false;
  final _emailTC = TextEditingController();

  final _passwordTC = TextEditingController();
  final _nameTC = TextEditingController();
  final _phoneNumberTC = TextEditingController();
  @override
  void initState() {
    super.initState();

    _phoneNumberTC.text = widget.mobileNumber ?? "";
  }

  @override
  void dispose() {
    _emailTC.dispose();
    _passwordTC.dispose();
    _phoneNumberTC.dispose();
    _nameTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginApiController = Provider.of<LoginApiController>(context);
    final safeArea = MediaQuery.paddingOf(context).top;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/image_authentication_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginWithMobileScreen()),
          );
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: false,
          body: Container(
            height: screenHeight,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: screenWidth * 0.3,
                      width: screenWidth * 0.3,
                      child: QuarterCircle(
                        widget: InkResponse(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const LandingScreen(),
                                transitionDuration:
                                    const Duration(milliseconds: 1000),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: Tween(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero)
                                        .animate(animation),
                                    child: child,
                                  );
                                },
                              ),
                              (route) =>
                                  false, // Removes all routes in the stack
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: poppinsText(
                              txt: "Skip   ",
                              weight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        color: Color(0xFFFFB200),
                        circleAlignment: CircleAlignment.topRight,
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/icon_phone.svg',
                    width: screenWidth * 0.4,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: poppinsText(
                              txt: "User Details",
                              fontSize: 18,
                              weight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFieldFloatingLabel(
                          prefixIcon: Icons.face,
                          controller: _nameTC,
                          hint: "Full Name",
                          textInputType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z\s]')),
                            LengthLimitingTextInputFormatter(16),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextFieldFloatingLabel(
                          prefixIcon: Icons.phone_outlined,
                          controller: _phoneNumberTC,
                          hint: "Phone Number",
                          readOnly: true,
                          textInputType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            FilteringTextInputFormatter.deny(
                                new RegExp(r"\s\b|\b\s")),
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextFieldFloatingLabel(
                          prefixIcon: Icons.email_outlined,
                          controller: _emailTC,
                          hint: "Email Address",
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextFieldFloatingLabel(
                          isObscure: true,
                          prefixIcon: Icons.lock_outlined,
                          controller: _passwordTC,
                          hint: "Password",
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        loginApiController.isLoading
                            ? LoadingAnimatedButton(
                                width: screenWidth * 0.6,
                                child: poppinsText(
                                    txt: "Create Account",
                                    weight: FontWeight.w500,
                                    fontSize: 20),
                                onTap: () {},
                              )
                            : InkResponse(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (!_isChecked) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();

                                    CustomErrorSnackBarMsg(
                                        text:
                                            "Please accept our terms and conditions before proceeding.",
                                        context: context,
                                        time: 2);
                                  } else if (_phoneNumberTC.text
                                          .trim()
                                          .isEmpty ||
                                      _passwordTC.text.trim().isEmpty ||
                                      _emailTC.text.trim().isEmpty ||
                                      _nameTC.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();

                                    CustomErrorSnackBarMsg(
                                        text:
                                            "Please enter all the required fields.",
                                        context: context,
                                        time: 2);
                                  } else if (_phoneNumberTC.text
                                          .trim()
                                          .length !=
                                      10) {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();

                                    CustomErrorSnackBarMsg(
                                        text:
                                            "Please enter a valid phone number.",
                                        context: context,
                                        time: 2);
                                  } else {
                                    loginApiController.signup(
                                        number: _phoneNumberTC.text.trim(),
                                        name: _nameTC.text.trim(),
                                        email: _emailTC.text.trim(),
                                        password: _passwordTC.text.trim(),
                                        context: context);
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: screenWidth * 0.6,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x26050522),
                                          blurRadius: 3,
                                          offset: Offset(-1, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment(1.00, 0.01),
                                        end: Alignment(-1, -0.01),
                                        colors: [
                                          Color(0xFFFCC546),
                                          Color(0xffFFB200)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(13)),
                                  child: poppinsText(
                                    txt: "Create Account",
                                    weight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Checkbox(
                              side: BorderSide(color: Colors.black, width: 1.5),
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                              visualDensity: VisualDensity.compact,
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              checkColor: kYellowColor,
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'By continuing, you agree to the ',
                                    style: TextStyle(
                                        fontSize: 14, color: kTextPrimary),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Terms & Conditions',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    const TermsAndConditions(),
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 500),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return SlideTransition(
                                                    position: Tween(
                                                            begin: const Offset(
                                                                0.0, 1.0),
                                                            end: Offset.zero)
                                                        .animate(animation),
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          // fontStyle: FontStyle.italic,
                                          color: Color(0xFF123EC4),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '  and  ',
                                        style: TextStyle(
                                            fontSize: 14, color: kTextPrimary),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    const PrivacyPolicy(),
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 500),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return SlideTransition(
                                                    position: Tween(
                                                            begin: const Offset(
                                                                0.0, 1.0),
                                                            end: Offset.zero)
                                                        .animate(animation),
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          // fontWeight: FontWeight.bold,
                                          color: Color(0xFF123EC4),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
