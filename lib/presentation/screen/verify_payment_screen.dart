import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/landing/landing_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../model/cart_count_provider/cart_count_provider.dart';
import '../../model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import '../../network/cart_repo/cart_screen_model.dart';
import '../../network/pre_order/pre_order_provider.dart';
import '../../utils/Utils.dart';
import 'add_order/order_placed_successfully_screen.dart';

class VerifyPaymentScreen extends StatefulWidget {
  final PaymentSuccessResponse payment;
  final String transactionID;

  const VerifyPaymentScreen({
    Key? key,
    required this.payment,
    required this.transactionID,
  }) : super(key: key);
  @override
  _VerifyPaymentScreenState createState() => _VerifyPaymentScreenState();
}

class _VerifyPaymentScreenState extends State<VerifyPaymentScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    transactionSuccessful();
  }

  void transactionSuccessful() async {
    final cartModel = Provider.of<CartScreenModel>(context, listen: false);

    await cartModel
        .transactionSuccess(
            txnid: widget.transactionID,
            razorpay_payment_id: widget.payment.paymentId ?? "")
        .then((res) {
      if (res.status!) {
        final cartCountProvider =
            Provider.of<CartCountModel>(context, listen: false);
        final preOrderProvider =
            Provider.of<PreorderProvider>(context, listen: false);
        final menuItemAddToCartProvider =
            Provider.of<MenuItemAddToCartProvider>(context, listen: false);
        menuItemAddToCartProvider.clearMenuItemsWithQuantityList();

        cartCountProvider.checkCartCount(provider: preOrderProvider);
        Timer.periodic(
          const Duration(seconds: 3),
          (Timer t) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LandingScreen(),
              ),
              (route) => false),
        );
      } else {
        Utils.showToast(res.message ?? "");
        Timer.periodic(
          const Duration(seconds: 3),
          (Timer t) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const OrderPlacedSuccessfullyScreen(),
              ),
              (route) => false),
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Verify Payment",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Text(
                  "Please wait",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "System takes near about 1-2 Minutes",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
          const Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(
                  child: Text("Don't back press until process completion.")))
        ],
      ),
    );
  }
}
