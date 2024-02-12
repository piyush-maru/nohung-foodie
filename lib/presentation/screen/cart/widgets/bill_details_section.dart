import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../../model/cart_screen_class/cart_screen_model_class.dart';
import '../../../../model/login.dart';
import '../../../../model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import '../../../../model/razorpay_order_response.dart';
import '../../../../network/cart_repo/cart_screen_model.dart';
import '../../../../network/pre_order/pre_order_provider.dart';
import '../../../../providers/cart_providers/cart_bill_details_provider.dart';
import '../../../../providers/wallet_provider.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../widgets/shimmer_container.dart';
import '../../Profile/refer_friend.dart';
import '../../add_order/add_order_failed_screen.dart';
import '../../add_order/order_placed_successfully_screen.dart';
import '../../verify_payment_screen.dart';

class BillDetailsSection extends StatefulWidget {
  const BillDetailsSection({
    super.key,
    required this.name,
    required this.number,
    required this.cartProvider,
    required this.subTotal,
    required this.walletBalance,
  });
  final CartScreenModel cartProvider;
  final String name;
  final String number;
  final String subTotal;
  final String walletBalance;

  @override
  State<BillDetailsSection> createState() => _BillDetailsSectionState();
}

class _BillDetailsSectionState extends State<BillDetailsSection> {
  final _razorpay = Razorpay();
  late Future<UserPersonalInfo> getUserFuture;
  String transactionID = '';
  bool isLoading = false;
  bool isWalletOn = false;
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyPaymentScreen(
          payment: response,
          transactionID: transactionID,
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed", toastLength: Toast.LENGTH_SHORT);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddOrderFailedScreen(
          response: response,
          transactionID: transactionID,
        ),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
    print('Payment error');
  }

  void openCheckout({
    required RazorpayOrderResponse razorPayOrderResponse,
    required String name,
    required String phoneNumber,
  }) async {
    var options = {
      'amount': razorPayOrderResponse.amount!.toInt() * 100,
      'name': name,
      'description': '',
      'order_id': '${razorPayOrderResponse.id}',
      'timeout': 180, //in seconds
      'key': AppConstant.razorpay_key_id,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': phoneNumber,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> createOrderID(
      {required double finalAmount,
      required String orderId,
      required String name,
      required String phoneNumber}) async {
    Map<String, dynamic> toJson = {
      "amount": int.tryParse(finalAmount.floor().toString())! * 100,
      "currency": "INR",
      "receipt": orderId,
    };

    var response = await http.post(Uri.https("api.razorpay.com", "v1/orders"),
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('${AppConstant.razorpay_key_id}:${AppConstant.razorpay_secret}'))}',
          'Content-Type': 'application/json',
        },
        body: json.encode(toJson));
    if (response.statusCode == 200) {
      RazorpayOrderResponse data =
          RazorpayOrderResponse.fromJson(json.decode(response.body));

      openCheckout(
          name: name, phoneNumber: phoneNumber, razorPayOrderResponse: data);
    }
  }

  _checkWalletCanBeUsed(
      {required String walletBalance, required String subTotal}) async {
    double doubleWallet = double.parse(walletBalance);
    double doubleSubTotal = double.parse(subTotal);
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    if (doubleWallet > doubleSubTotal) {
      walletProvider.updateWhetherWalletActive(value: true);
      print("doubleWallet is larger");
    } else if (doubleWallet < doubleSubTotal) {
      isWalletOn = false;

      print("doubleSubTotal is larger");
    } else {
      print("Both values are equal");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserFuture = Utils.getUser();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(Duration.zero, () {
      _checkWalletCanBeUsed(
          subTotal: widget.subTotal, walletBalance: widget.walletBalance);
    });
  }

  Future<void> _openAlertDialog() async {
    await showDialog<void>(
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.2),
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
          return Dialog(
            backgroundColor: Colors.transparent,
            insetAnimationDuration: const Duration(seconds: 1),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              // Set rounded corners
            ),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                padding: const EdgeInsets.only(left: 20,bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Image.asset("assets/images/cross_outline.png",
                              height: 23),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    poppinsText(
                        txt: 'Select a time for delivery',
                        maxLines: 2,
                        fontSize: 16)
                  ],
                )),
          );
        });
  }

  Future<void> _locationErrorDialog() async {
    await showDialog<void>(
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.2),
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetAnimationDuration: const Duration(seconds: 1),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
              // Set rounded corners
            ),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(width: 2),
                      color: Colors.white),
                  padding:
                      EdgeInsets.only(bottom: 20, right: 5, top: 5, left: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close),
                          )),
                      Image.asset(
                        'assets/icons/icon_location_outside.png',
                        height: 130,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      poppinsText(
                          txt:
                              'Your current location is outside Kitchen’s delivery area',
                          maxLines: 2,
                          color: Colors.redAccent,
                          textAlign: TextAlign.center,
                          fontSize: 16),
                      SizedBox(
                        height: 7,
                      ),
                      poppinsText(
                          txt: 'Please check the selected delivery address.',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          fontSize: 13)
                    ],
                  )),
            ),
          );
        });
  }

  @override
  void dispose() {
    _razorpay.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final preOrderProvider =
        Provider.of<PreorderProvider>(context, listen: false);

    final walletProvider = Provider.of<WalletProvider>(context, listen: true);
    final cartBillDetailsProvider =
        Provider.of<CartBillDetailsProvider>(context, listen: true);
    String calculateAmountToPay(
        {required String subTotal, required String walletBalance}) {
      num subTotalAmount = (num.tryParse(subTotal))!;
      num walletBalanceAmount = (num.tryParse(walletBalance))!;

      num amount = subTotalAmount - walletBalanceAmount;

      if (amount.isNegative) {
        return "0";
      } else {
        return amount.toStringAsFixed(2);
      }
    }

    return FutureBuilder<GetCartDetailsModel>(
        future: cartBillDetailsProvider.getCartBillDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: const Color(0xf7fcf7e1),
              child: const ShimmerContainer(
                height: 400,
                width: double.infinity,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.data!.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bill Details",
                  style: AppTextStyles.normalText.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Item Total",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                    Text(
                      "₹ ${data.cartTotal}",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Taxes",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                    Text(
                      "₹ ${data.taxAmount}",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Delivery Charges",
                      style: AppTextStyles.normalText.copyWith(fontSize: 14),
                    ),
                    if (!data.cartItems.first.isTrial)
                      Text(
                        " (${data.cart_count} Days)" ?? "",
                        style: AppTextStyles.normalText.copyWith(fontSize: 12),
                      ),
                    Spacer(),
                    Text(
                      "₹ ${data.actualDeliveryCharge}  ",
                      style: AppTextStyles.normalText.copyWith(
                          color: Colors.red,
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text(
                      "₹ ${data.deliveryCharge}",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Packaging Charges",
                      style: AppTextStyles.normalText.copyWith(fontSize: 14),
                    ),
                    if (!data.cartItems.first.isTrial)
                      Text(
                        " (${data.cart_count} Days)" ?? "",
                        style: AppTextStyles.normalText.copyWith(fontSize: 12),
                      ),
                    Spacer(),
                    Text(
                      "₹ ${data.actualPackagingCharges}  ",
                      style: AppTextStyles.normalText.copyWith(
                          color: Colors.red,
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text(
                      "₹ ${data.packagingCharges}",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Coupon",
                      style: AppTextStyles.normalText.copyWith(fontSize: 14),
                    ),
                    Text(
                      "- ₹ ${data.couponDiscount}",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub Total",
                      style: AppTextStyles.normalText.copyWith(fontSize: 14),
                    ),
                    Text(
                      "₹ ${data.subTotal}",
                      style: AppTextStyles.normalText.copyWith(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Wallet",
                      style: AppTextStyles.normalText.copyWith(fontSize: 14),
                    ),
                    Switch(
                      activeThumbImage: const AssetImage(
                        "assets/images/switch_on.png",
                      ),
                      inactiveThumbImage: const AssetImage(
                        "assets/images/switch_of.png",
                      ),
                      activeColor: AppConstant.appColor,
                      thumbColor: MaterialStateProperty.all(Colors.white),
                      value: walletProvider.isWalletActive,
                      onChanged: (value) {
                        walletProvider.updateWhetherWalletActive();
                      },
                    ),
                   /* Switch(
                      activeColor: AppConstant.appColor,
                      thumbColor: MaterialStateProperty.all(Colors.white),
                      value: walletProvider.isWalletActive,
                      onChanged: (value) {
                        walletProvider.updateWhetherWalletActive();
                      },
                    ),*/
                    const Spacer(),
                    Text(
                      "₹ ${data.walletBalance}",
                      style: AppTextStyles.normalText.copyWith(
                          fontSize: 15,
                          color: walletProvider.isWalletActive
                              ? Colors.black
                              : Colors.black26),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To Pay",
                      style: AppTextStyles.boldText.copyWith(fontSize: 18),
                    ),
                    Text(
                      walletProvider.isWalletActive
                          ? "₹ ${calculateAmountToPay(walletBalance: data.walletBalance, subTotal: data.subTotal)}"
                          : "₹ ${data.subTotal}",
                      style: AppTextStyles.boldText.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // (calculateAmountToPay(
                //                 walletBalance: data.walletBalance,
                //                 subTotal: data.subTotal) ==
                //             "0" &&
                //         (walletProvider.isWalletActive))
                //     ? const SizedBox()
                //     : Material(
                //         elevation: 2,
                //         child: Container(
                //           width: MediaQuery.of(context).size.width,
                //           height: 60,
                //           decoration: const BoxDecoration(),
                //           child: Row(
                //             children: [
                //               Radio(
                //                   toggleable: true,
                //                   activeColor: AppConstant.appColor,
                //                   value: true,
                //                   groupValue: true,
                //                   onChanged: (v) {}),
                //               const Text(
                //                 'Pay Online',
                //                 style: TextStyle(
                //                   fontSize: 18,
                //                   fontFamily: AppConstant.fontBold,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<UserPersonalInfo>(
                    future: getUserFuture,
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppConstant.appColor,
                          ),
                        );
                      }
                      if (userSnapshot.hasError) {
                        return Center(
                          child: Text(
                            userSnapshot.error.toString(),
                          ),
                        );
                      }
                      if (userSnapshot.connectionState ==
                              ConnectionState.done &&
                          userSnapshot.hasData) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReferAFriend(
                                  referralCode:
                                      userSnapshot.data!.referalCode ?? "",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 7),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xffaf06f7),
                                  Color(0xffe27657),
                                  Color(0xfffbae05),
                                ], // Your gradient colors
                                begin: Alignment
                                    .centerLeft, // Alignment for the gradient start point
                                end: Alignment
                                    .centerRight, // Alignment for the gradient end point
                              ),
                              borderRadius: BorderRadius.circular(
                                  5.0), // Optional: Add border radius
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                poppinsText(
                                    txt:
                                        'REFER YOUR FRIEND - ${AppConstant.rupee}50',
                                    fontSize: 16,
                                    color: Colors.white,
                                    textAlign: TextAlign.center,
                                    weight: FontWeight.w500),
                                const SizedBox(
                                  width: 15,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/icon_refer_earn.svg',
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppConstant.appColor,
                        ),
                      );
                    }),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {

                      if ((preOrderProvider.finalTime.isEmpty || preOrderProvider.finalTime == "Select Time") && snapshot.data!.data.cartItems.first.isTrial) {
                        _openAlertDialog();
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        final res = await widget.cartProvider.placeOrder(
                            name: widget.name,
                            number: widget.number,
                            couponCode: widget.cartProvider.couponCode,
                            instructions: widget.cartProvider.deliveryInstruction,
                            addressId: data.myLocation.addressId,
                            // isPaymentOnline: calculateAmountToPay,
                            isWalletActive: walletProvider.isWalletActive,
                            kitchenId: data.kitchenDetailData.kitchenId!);

                        if (res.status!) {
                          transactionID = res.data!.transactionId ?? "";
                          final cartCountModel = Provider.of<CartCountModel>(context, listen: false);
                          final menuItemAddToCartProvider = Provider.of<MenuItemAddToCartProvider>(context, listen: false);

                          if (walletProvider.isWalletActive) {
                            if (calculateAmountToPay(walletBalance: data.walletBalance, subTotal: data.subTotal) == "0") {
                              cartCountModel.checkCartCount(provider: preOrderProvider);
                              menuItemAddToCartProvider.clearMenuItemsWithQuantityList();
                              Fluttertoast.showToast(
                                  msg: "Order placed successfully",
                                  toastLength: Toast.LENGTH_SHORT);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OrderPlacedSuccessfullyScreen(),
                                ),
                              );
                            } else {
                              createOrderID(
                                  finalAmount: double.parse(
                                    calculateAmountToPay(
                                        walletBalance: data.walletBalance,
                                        subTotal: data.subTotal),
                                  ),
                                  orderId: res.data!.transactionId!,
                                  phoneNumber: widget.number,
                                  name: widget.name);
                            }
                          } else {
                            createOrderID(
                                finalAmount: double.parse(data.subTotal),
                                orderId: res.data!.transactionId!,
                                phoneNumber: widget.number,
                                name: widget.name);
                          }

                          print(res.message);
                        } else {
                          setState(() {
                            isLoading = false;
                          });

                          // Utils.showToast(res.message!);

                          Fluttertoast.showToast(
                            msg: res.message!,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red, // Set the background color to red
                            textColor: Colors.white, // Set the text color to white
                            fontSize: 16.0,
                          );
                          if (res.message! == "Your current location is outside the Kitchen's delivery area !") {
                            _locationErrorDialog();
                          }
                          // Navigator.pop(context);
                        }
                      }
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppConstant.appColor,
                            ),
                          )
                        : Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppConstant.appColor,
                            ),
                            child: const Center(
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            );
          }

          return Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: const Color(0xf7fcf7e1),
            child: const ShimmerContainer(
              height: 400,
              width: double.infinity,
            ),
          );
        });
  }
}
