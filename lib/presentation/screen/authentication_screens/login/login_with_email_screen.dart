import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/presentation/widgets/text_field/custom_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../network/login_api/login_api_controller.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/buttons/loading_button.dart';
import '../../../widgets/quarter_circle/quarter_circle.dart';
import '../../../widgets/snack_bar/custom_snackbar.dart';
import '../../landing/landing_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import 'login_with_mobile_screen.dart';

class LoginWithEmailScreen extends StatefulWidget {
  const LoginWithEmailScreen({super.key});

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  final _emailTC = TextEditingController();
  final _passwordTC = TextEditingController();
  @override
  void dispose() {
    _emailTC.dispose();
    _passwordTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginApiController = Provider.of<LoginApiController>(context);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {   Navigator.pop(context);},
                  child: Container(
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kYellowColor, width: 2)),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                ),
                SizedBox(
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
              ],
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
                        txt: "Login", fontSize: 18, weight: FontWeight.w600),
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
                    height: 10,
                  ),
                  InkResponse(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const ForgotPasswordScreen(),
                          transitionDuration: const Duration(milliseconds: 500),
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
                      );
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Color(0xFF123EC4),
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                            if (_emailTC.text.trim().isEmpty ||
                                _passwordTC.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).clearSnackBars();

                              CustomErrorSnackBarMsg(
                                  text:
                                      "Please enter email address and password fields.",
                                  context: context,
                                  time: 2);
                            } else {
                              loginApiController.loginWithEmailPassword(
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
                    height: 20,
                  ),
                  InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Continue with Mobile Number",
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
