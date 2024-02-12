import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/presentation/screen/landing/landing_screen.dart';
import 'package:food_app/presentation/widgets/text_field/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../menu/privacy_policy.dart';
import '../../../../network/login_api/login_api_controller.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../../widgets/quarter_circle/quarter_circle.dart';
import '../../../widgets/snack_bar/custom_snackbar.dart';
import '../../Profile/terms_conditions.dart';
import 'login_with_email_screen.dart';

class LoginWithMobileScreen extends StatefulWidget {
  const LoginWithMobileScreen({super.key});

  @override
  State<LoginWithMobileScreen> createState() => _LoginWithMobileScreenState();
}

class _LoginWithMobileScreenState extends State<LoginWithMobileScreen> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  final _mobileTC = TextEditingController();
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  void dispose() {
    _mobileTC.dispose();
    super.dispose();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final loginApiController = Provider.of<LoginApiController>(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

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
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween(
                                      begin: const Offset(1.0, 0.0),
                                      end: Offset.zero)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        ),
                        (route) => false, // Removes all routes in the stack
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/welcome_nohung.jpeg",
                    width: screenWidth * 0.45,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: poppinsText(
                        txt: "Login / Sign-up",
                        fontSize: 2 * unitHeightValue,
                        weight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFieldPhone(
                    prefixIcon: Text(
                      "+91   ",
                      style: TextStyle(color: kTextPrimary, fontSize: 18),
                    ),
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
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       '    We will recognise existing customer.',
                  //       style: TextStyle(
                  //           color: Colors.blueGrey,
                  //           fontSize: 1.5 * unitHeightValue,
                  //           fontStyle: FontStyle.italic),
                  //     )),
                  SizedBox(
                    height: 25,
                  ),
                  loginApiController.isLoading
                      ? LoadingAnimatedButton(
                          width: screenWidth * 0.6,
                          child: poppinsText(
                              txt: "Continue",
                              weight: FontWeight.w500,
                              fontSize: 20),
                          onTap: () {},
                        )
                      : InkResponse(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_mobileTC.text.trim().length != 10) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              CustomErrorSnackBarMsg(
                                  text: "Oops! Enter a valid phone number.",
                                  context: context,
                                  time: 2);
                            } else {
                              loginApiController.loginWithMobile(
                                  number: _mobileTC.text.trim(),
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
                              txt: "Continue",
                              weight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 25,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By continuing, you agree to the ',
                      style: TextStyle(fontSize: 14, color: kTextPrimary),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Terms & Conditions',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const TermsAndConditions(),
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween(
                                              begin: const Offset(0.0, 1.0),
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
                          style: TextStyle(fontSize: 14, color: kTextPrimary),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const PrivacyPolicy(),
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: Tween(
                                              begin: const Offset(0.0, 1.0),
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
                  SizedBox(
                    height: 20,
                  ),
                  InkResponse(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const LoginWithEmailScreen(),
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return SlideTransition(
                              position: Tween(
                                      begin: const Offset(0.0, 1.0),
                                      end: Offset.zero)
                                  .animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Continue with Email",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
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
