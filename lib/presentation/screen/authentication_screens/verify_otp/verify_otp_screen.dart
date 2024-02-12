import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../network/login_api/login_api_controller.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/buttons/loading_button.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({
    super.key,
    required this.mobileNumber,
    required this.userID,
    required this.type,
    this.forForgotPassword = false,
    this.forUpdateProfile = false,
  });
  final String mobileNumber;
  final String userID;
  final String type;
  final bool forForgotPassword;
  final bool forUpdateProfile;
  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final _otpController = TextEditingController();
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginApiController = Provider.of<LoginApiController>(context);

    final screenWidth = MediaQuery.sizeOf(context).width;
    final safeArea = MediaQuery.paddingOf(context).top;
    return WillPopScope(
      onWillPop: () async {
        loginApiController.updateWrongOTP(false);
        return true;
      },
      child: Scaffold(
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
                    loginApiController.updateWrongOTP(false);

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
                    SizedBox(
                      height: safeArea,
                    ),
                    SvgPicture.asset(
                      'assets/icons/icon_verify_otp.svg',
                      width: screenWidth * 0.4,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: poppinsText(
                          txt: "Verify Details",
                          fontSize: 18,
                          weight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: poppinsText(
                          txt: "We have sent OTP to your number",
                          fontSize: 16,
                          weight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Pinput(
                      autofocus: true,
                      controller: _otpController,
                      length: 4,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment(1.00, 0.01),
                            begin: Alignment(-1, -0.01),
                            colors: loginApiController.wrongOTP
                                ? [Color(0xFFFFCCCC), Color(0xFFFFCCCC)]
                                : [Color(0xFFFCC546), Color(0xffFFB200)],
                          ),
                          border: Border.all(
                              color: loginApiController.wrongOTP
                                  ? Color(0xFFEA0000)
                                  : kYellowColor,
                              width: 2),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        textStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: kTextPrimary,
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      onCompleted: (value) {
                        loginApiController.updateWrongOTP(false);

                        if (widget.forForgotPassword) {
                          loginApiController.verifyMobileOTPResetPassword(
                              userID: widget.userID,
                              number: widget.mobileNumber,
                              otp: _otpController.text.trim(),
                              context: context);
                        } else if (widget.forUpdateProfile) {
                          loginApiController.verifyMobileOTPUpdateProfile(
                              number: widget.mobileNumber,
                              otp: _otpController.text.trim(),
                              context: context);
                        } else {
                          loginApiController.verifyMobileOTP(
                              type: widget.type,
                              userID: widget.userID,
                              number: widget.mobileNumber,
                              otp: _otpController.text.trim(),
                              context: context);
                        }
                      },
                      focusedPinTheme: PinTheme(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(color: kYellowColor, width: 2),
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                        ),
                        textStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: kTextPrimary,
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (loginApiController.wrongOTP)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Color(0xFFEA0000),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          poppinsText(
                            txt:
                                'The OTP you entered is invalid\n Please enter the correct OTP',
                            fontSize: 14,
                            maxLines: 2,
                            color: Color(0xFFEA0000),
                            weight: FontWeight.w500,
                          ),
                        ],
                      ),
                    SizedBox(
                      height: loginApiController.wrongOTP ? 10 : 40,
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
                              loginApiController.updateWrongOTP(false);
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (_otpController.text.trim().length != 4) {
                                loginApiController.updateWrongOTP(true);
                              } else {
                                if (widget.forForgotPassword) {
                                  loginApiController
                                      .verifyMobileOTPResetPassword(
                                          userID: widget.userID,
                                          number: widget.mobileNumber,
                                          otp: _otpController.text.trim(),
                                          context: context);
                                } else if (widget.forUpdateProfile) {
                                  loginApiController
                                      .verifyMobileOTPUpdateProfile(
                                          number: widget.mobileNumber,
                                          otp: _otpController.text.trim(),
                                          context: context);
                                } else {
                                  loginApiController.verifyMobileOTP(
                                      type: widget.type,
                                      userID: widget.userID,
                                      number: widget.mobileNumber,
                                      otp: _otpController.text.trim(),
                                      context: context);
                                }
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
                    SizedBox(
                      height: 25,
                    ),
                    if (!widget.forForgotPassword && !widget.forUpdateProfile)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: !loginApiController.canResend,
                            child: Countdown(
                              controller: _controller,
                              seconds: 2 * 60,
                              build: (BuildContext context, double time) =>
                                  poppinsText(
                                txt:
                                    "${time ~/ 60} min ${(time % 60) > 9 ? (time % 60).toInt() : '0${(time % 60).toInt()}'} secs",
                                fontSize: 16,
                                weight: FontWeight.w500,
                              ),
                              interval: Duration(milliseconds: 100),
                              onFinished: () {
                                loginApiController.updateCanResendOTP(true);
                                print('Timer is done!');
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          InkResponse(
                            onTap: () async {
                              if (loginApiController.canResend) {
                                _otpController.clear();
                                _controller.restart();
                                loginApiController.resendOTP(
                                    number: widget.mobileNumber,
                                    context: context);
                              }
                            },
                            child: Text(
                              "Resend OTP",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: (loginApiController.canResend)
                                      ? Color(0xff3F6CA5)
                                      : Color(0xC34770EC),
                                  fontSize: 17,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
