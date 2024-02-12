import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../network/cart_repo/cart_screen_model.dart';
import '../../../utils/Utils.dart';
import '../../../utils/constants/ui_constants.dart';
import '../landing/landing_screen.dart';

class AddOrderFailedScreen extends StatefulWidget {
  const AddOrderFailedScreen({
    super.key,
    required this.response,
    required this.transactionID,
  });
  final PaymentFailureResponse response;
  final String transactionID;

  @override
  State<AddOrderFailedScreen> createState() => _AddOrderFailedScreenState();
}

class _AddOrderFailedScreenState extends State<AddOrderFailedScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    transactionUnsuccessful();
  }

  void transactionUnsuccessful() async {
    final cartModel = Provider.of<CartScreenModel>(context, listen: false);

    await cartModel.transactionFailed(
            txnid: widget.transactionID,
            razorpay_payment_id: widget.response.code.toString())
        .then((res) {
      if (res.status!) {
       // Timer.periodic(
       //   const Duration(seconds: 3),
       //   (Timer t) => Navigator.pushAndRemoveUntil(
       //       context,
       //       MaterialPageRoute(
       //         builder: (context) => const LandingScreen(),
       //       ),
       //       (route) => false),
       // );
      } else {
        Utils.showToast(res.message ?? "");
       // Timer.periodic(
       //   const Duration(seconds: 3),
       //   (Timer t) => Navigator.pushAndRemoveUntil(
       //       context,
       //       MaterialPageRoute(
       //         builder: (context) => const LandingScreen(),
       //       ),
       //       (route) => false),
       // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image_authentication_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          poppinsText(
              maxLines: 3,
              txt: "Payment failed.",
              fontSize: 25,
              textAlign: TextAlign.center,
              weight: FontWeight.w500),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 25,
          ),
          InkResponse(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                  const LandingScreen(),
                  transitionDuration:
                  const Duration(milliseconds: 500),
                  transitionsBuilder: (context, animation,
                      secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
                    (route) => false, // Removes all routes in the stack
              );
            },
            child: Container(
              alignment: Alignment.center,
              width: screenWidth * 0.6,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x26050522),
                      blurRadius: 10,
                      offset: Offset(-1, 1),
                      spreadRadius: 0,
                    )
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.01),
                    end: Alignment(-1, -0.01),
                    colors: [Color(0xFFFCC546), Color(0xAEFFB200)],
                  ),
                  borderRadius: BorderRadius.circular(13)),
              child: poppinsText(
                txt: "Go Back",
                weight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),),
    );
  }
}


/*Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          poppinsText(
              maxLines: 3,
              txt: "Payment failed.",
              fontSize: 25,
              textAlign: TextAlign.center,
              weight: FontWeight.w500),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(
            height: 25,
          ),
          InkResponse(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const LandingScreen(),
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
                (route) => false, // Removes all routes in the stack
              );
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
                    colors: [Color(0xFFFCC546), Color(0xAEFFB200)],
                  ),
                  borderRadius: BorderRadius.circular(13)),
              child: poppinsText(
                txt: "Go Back",
                weight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),*/