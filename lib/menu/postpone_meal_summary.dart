// import 'dart:convert';
// import 'dart:core';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:food_app/main.dart';
// import 'package:food_app/model/RazorpayOrderResponse.dart';
// import 'package:food_app/model/bean_login.dart';
// import 'package:food_app/model/get_postpone_menu_details.dart';
// import 'package:food_app/model/postponeOrder.dart';
// import 'package:food_app/screen/verify_payment_screen.dart';
// import 'package:http/http.dart' as http;
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/model/get_cart_detail.dart' as cart;
// import 'package:food_app/network/api_provider.dart';
// import 'package:food_app/res.dart';
// import 'package:food_app/utils/constants.dart';
// import 'package:food_app/utils/http_exception.dart';
// import 'package:food_app/utils/utils.dart';
// import 'package:geolocator/geolocator.dart';
//
// class PostponeMenuScreen extends StatefulWidget {
//   final String orderItemId;
//   final String? previousOrderAmount;
//
//   PostponeMenuScreen(
//       {required this.orderItemId, required this.previousOrderAmount});
//
//   @override
//   _PostponeMenuScreenState createState() => _PostponeMenuScreenState();
// }
//
// class _PostponeMenuScreenState extends State<PostponeMenuScreen> {
//   var isSelected = 0;
//   bool isPageLoading = true;
//
//   // PayuMoneyFlutter payuMoneyFlutter = PayuMoneyFlutter();
//
//   late Razorpay _razorpay;
//   Map<String, dynamic>? response;
//
//   Future? future;
//   var distanceKM = "";
//   String? totalAmount = "";
//   String? kitchenId = "";
//   var applyPromoController = TextEditingController();
//   String? taxAmount = "";
//
//   String? deliveryCharge = "";
//   String? couponDiscount = "";
//   var type = "";
//   String? deliveryLat = "";
//   String? deliveryLong = "";
//   String? deliveryAddress = "";
//   Position? position;
//   final int _selectedIndex = 2;
//   bool showDiscount = false;
//   String? address;
//
//   var _character = 1;
//   bool isWalletActive = true;
//   bool? isOrderNow = false;
//   var totalToAmount = 0;
//   String walletBalance = '';
//   bool isWalletAmountAvailable = true;
//   PostponeMenuData? newMenuData;
//   String? txnid = '';
//
//   List<cart.CartItem>? data;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     // _payUWebCheckout.on(
//     //     PayUWebCheckout.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     // _payUWebCheckout.on(
//     //     PayUWebCheckout.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     getPostponeMenu();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }
//
//   Future<GetPostponeMenuDetails?> getPostponeMenu() async {
//     BeanLogin user = await Utils.getUser();
//     FormData from = FormData.fromMap({
//       "token": "123456789",
//       "user_id": userPersonalInfo.id,
//       "order_item_id": widget.orderItemId,
//     });
//     GetPostponeMenuDetails? bean = await ApiProvider().getPostponeMenu(from);
//
//     if (bean?.status == true) {
//       setState(() {
//         newMenuData = bean!.data;
//         isPageLoading = false;
//         //walletBalance = newMenuData!.walletAmount.toString();
//         // totalAmount = (int.parse(newMenuData!.currentItemPrince!) - int.parse(widget.orderItemId)).toString() ;
//         //totalAmount = newMenuData!.currentItemPrince!;
//         // if(int.parse(totalAmount!) > 0){
//         if (isWalletActive == false) {
//           // totalToAmount = totalAmount!;
//         } else {
//           //totalToAmount =
//           //  totalAmount! - walletBalance;
//           if (totalToAmount < 0) {
//             totalToAmount = 0;
//           }
//         }
//         // } else{
//         //   isWalletActive = false;
//         //   totalToAmount = 0;
//         // }
//       });
//
//       return bean;
//     } else {
//       Utils.showToast(bean!.message!);
//     }
//
//     return null;
//   }
//
//   void openCheckout(
//       int finalAmount, String? invoiceId, RazorpayOrderResponse data) async {
//
//     var orderId = data.id;
//     var options = {
//       'key': "rzp_live_Yiq5xQzeTYTZ6z",
//       //RazorpayKey,if test -> rzp_test_lxUciWRieYANWW if live -> rzp_live_Yiq5xQzeTYTZ6z
//       'amount': finalAmount.toInt() * 100,
//       'name': 'Nohung',
//       'description': '',
//       'order_id': '${data.id}',
//       'timeout': 180,
//       //in seconds
//     };
//
//     try {
//       //     ApiProvider().createTransactionApi(orderId!, invoiceId!).then((value) {
//
//       //       if (value!.status == true) {
//       _razorpay.open(options);
//
//       //   }
//       // });
//     } catch (e) {
//       debugPrint('Error: e');
//     }
//   }
//
//   Future<dynamic> createOrder(int finalAmount, String? invoiceId) async {
//
//     var mapHeader = <String, String>{};
//     mapHeader['Authorization'] =
//         "Basic cnpwX2xpdmVfWWlxNXhRemVUWVRaNno6Q3Zrdllja0k3elJOUkRteG1iWk1uRVF2}";
//     mapHeader['Accept'] = "application/json";
//     mapHeader['Content-Type'] = "application/x-www-form-urlencoded";
//     var map = <String, String>{};
//     map['amount'] = "${finalAmount.toInt() * 100}";
//     map['currency'] = "INR";
//     map['receipt'] = "receipt1";
//     var response = await http.post(Uri.https("api.razorpay.com", "/v1/orders"),
//         headers: mapHeader, body: map);
//     if (response.statusCode == 200) {
//       RazorpayOrderResponse data =
//           RazorpayOrderResponse.fromJson(json.decode(response.body));
//
//       openCheckout(finalAmount, invoiceId, data);
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId!,
//         toastLength: Toast.LENGTH_SHORT);
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => VerifyPaymentScreen(
//           //invoiceId: invoiceDetails!.invoiceId.toString(),
//           txnid: '',
//           payment: response,
//         ),
//       ),
//     );
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     /* Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - " + response.message!,
//         toastLength: Toast.LENGTH_SHORT); */
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     /* Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName!,
//         toastLength: Toast.LENGTH_SHORT); */
//   }
//
// //  @override
// //   void dispose() {
// //     _payUWebCheckout.clear();
// //     super.dispose();
// //   }
//
//   void _pay(String amountToPay) {}
//
//   // void _handlePaymentSuccess(Map<String, dynamic> response) {
//   //   setState(() {
//   //     this.response = response;
//   //   });
//   // }
//
//   // void _handlePaymentError(Map<String, dynamic> response) {
//   //   setState(() {
//   //     this.response = response;
//   //   });
//   // }
//   Future<PostponeOrder?> postponeOrder() async {
//     BeanLogin user = await Utils.getUser();
//     FormData from = FormData.fromMap({
//       "token": "123456789",
//       "user_id": userPersonalInfo.id,
//       "order_item_id": widget.orderItemId,
//       "iswalletchecked": isWalletActive ? "1" : "0",
//       "new_order_amount": newMenuData!.currentItemPrice
//     });
//
//     PostponeOrder? bean = await ApiProvider().postponeOrder(from);
//     if (bean?.status == true) {
//       if (totalToAmount != 0) {
//         String? transaction_id = bean!.data!.transactionId;
//         setState(() {
//           txnid = transaction_id;
//         });
//
//         createOrder(totalToAmount, transaction_id);
//       } else {
//         Fluttertoast.showToast(msg: bean!.message ?? "");
//         Navigator.pop(context, {
//           'id': bean.data!.transactionId,
//         });
//       }
//     }
//     return bean;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F6F6),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF6F6F6),
//         elevation: 0,
//         leading: const BackButton(
//           color: Colors.black,
//         ),
//         title: const Text(
//           "Post-pone Meal Summary",
//           style: TextStyle(
//               color: Color(0xffA7A8BC), fontFamily: AppConstant.fontRegular),
//         ),
//       ),
//       body: SafeArea(
//         child: isPageLoading
//             ? const CircularProgressIndicator()
//             : Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24)),
//                     color: Colors.white),
//                 padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
//                 margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
//                 child: ListView(
//                   padding: EdgeInsets.only(bottom: 48),
//                   shrinkWrap: true,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           "${dateTimeFormat(newMenuData!.newDate!.toString(), "E, dd MMM, yyyy")}",
//                           style: const TextStyle(
//                               fontFamily: AppConstant.fontBold,
//                               fontSize: 20,
//                               color: AppConstant.appColor),
//                         ),
//                         // Text(
//                         //     "${dateTimeFormat("${newMenuData!.newDate.toString()} ${newMenuData!.deliveryFromTime}", "EEEE")} - ${dateTimeFormat("${newMenuData!.newDate.toString()} ${newMenuData!.deliveryToTime}", "EEEE")}")
//                       ],
//                     ),
//                     SizedBox(height: 30, width: 30),
//                     Container(
//                       height: 500,
//                       child: ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           itemCount: newMenuData!.newMenuItems!.length,
//                           padding: const EdgeInsets.only(left: 16, right: 16),
//                           itemBuilder: (context, index) {
//                             var menuData = newMenuData!.newMenuItems![index];
//                             return Column(
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.symmetric(
//                                       vertical: 0.0, horizontal: 5.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "${menuData!.itemName}",
//                                         style: TextStyle(
//                                             fontFamily:
//                                                 AppConstant.fontRegular),
//                                       ),
//                                       Text(
//                                         "Quantity: ${menuData.qty}",
//                                         style: TextStyle(
//                                             fontFamily:
//                                                 AppConstant.fontRegular),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 10, width: 10),
//                               ],
//                             );
//                           }),
//                     ),
//                     SizedBox(height: 10, width: 10),
//                     const Divider(
//                       color: Colors.grey,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Wallet ( ${AppConstant.rupee} $walletBalance)",
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontFamily: AppConstant.fontBold,
//                               fontSize: 16),
//                         ),
//                         Transform.scale(
//                           scale: 1.5,
//                           child: Switch(
//                             value: isWalletActive,
//                             onChanged: (value) {
//                               updateWalletStatus(value);
//                             },
//                             // inactiveThumbColor: Colors.red,
//                             // inactiveTrackColor: Colors.red.shade300,
//                             activeColor: AppConstant.appColor,
//                             activeTrackColor:
//                                 const Color.fromARGB(255, 253, 202, 51),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Divider(
//                       color: Colors.grey,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "To Pay",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: AppConstant.fontBold,
//                               fontSize: 16),
//                         ),
//                         Text(
//                           "₹" + totalToAmount.toString(),
//                           style: const TextStyle(
//                               color: Colors.black,
//                               fontFamily: AppConstant.fontBold,
//                               fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     (!isWalletAmountAvailable && int.parse(totalAmount!) >= 0)
//                         ? Column(
//                             children: <Widget>[
//                               ListTile(
//                                 title: const Text('Pay Online'),
//                                 leading: Radio(
//                                   value: 1,
//                                   groupValue: _character,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _character = 1;
//                                     });
//                                   },
//                                 ),
//                               ),
//                               ListTile(
//                                 title: const Text('Cash On Delivery'),
//                                 leading: Radio(
//                                   value: 2,
//                                   groupValue: _character,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _character = 2;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Container(),
//                     const Divider(
//                       color: Colors.grey,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // createOrder(totalToAmount!.toString(),'','12');
//                         //               Fluttertoast.showToast(
//                         // msg: "API not ready working onit");
//                         postponeOrder();
//                         // _pay(totalToAmount.toString());
//                         //  Navigator.pushNamed(context, "/payment");
//                       },
//                       style: ButtonStyle(
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(12),
//                               ),
//                             ),
//                           ),
//                           backgroundColor:
//                               MaterialStateProperty.all(AppConstant.appColor),
//                           fixedSize:
//                               MaterialStateProperty.all(const Size(450, 50))),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         //mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Text(
//                             "PAY NOW",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           const SizedBox(
//                             width: 16,
//                           ),
//                           Image.asset(
//                             Res.nextArrow,
//                             color: Colors.white,
//                             width: 17,
//                             height: 17,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//       ),
//     );
//   }
//
//   Future<cart.GetCartDetail?> getCartDetail() async {
//     try {
//       BeanLogin user = await Utils.getUser();
//
//       FormData from = FormData.fromMap({
//         "token": "123456789",
//         "user_id": userPersonalInfo.id,
//       });
//       cart.GetCartDetail? bean = await ApiProvider().getCartDetail(from);
//       if (bean?.status == true) {
//         totalAmount = bean!.data!.subTotal;
//         taxAmount = bean.data!.taxAmount;
//         deliveryCharge = bean.data!.deliveryCharge;
//         couponDiscount = bean.data!.couponDiscount;
//         data = bean.data!.cartItems;
//         kitchenId = data![0].kitchenId;
//         deliveryLat = bean.data!.myLocation!.latitude;
//         deliveryLong = bean.data!.myLocation!.longitude;
//         // deliveryAddress = bean.data!.myLocation!.address;
//
//         setState(() {
//           walletBalance = bean.data!.walletBalance ?? "0";
//           if (isWalletActive == true) {
//             // totalToAmount =
//             //     double.parse(totalAmount!) - double.parse(walletBalance);
//             if (totalToAmount < 0) {
//               totalToAmount = 0;
//             }
//           }
//           if (totalToAmount > 0) {
//             isWalletAmountAvailable = false;
//           } else {
//             isWalletAmountAvailable = true;
//           }
//           isPageLoading = false;
//         });
//         return bean;
//       } else {
//         Utils.showToast(bean!.message!);
//       }
//
//       return null;
//     } on HttpException {
//       setState(() {
//         data = null;
//       });
//     } catch (exception) {
//       setState(() {
//         data = null;
//       });
//     }
//     return null;
//   }
//
//   void updateWalletStatus(value) {
//     setState(() {
//       isWalletActive = value;
//       isWalletAmountAvailable = value;
//       if (int.parse(totalAmount!) > 0) {
//         if (value == false) {
//           //totalToAmount = double.parse(totalAmount!);
//         } else {
//           //totalToAmount =
//           // double.parse(totalAmount!) - double.parse(walletBalance);
//           if (totalToAmount < 0) {
//             totalToAmount = 0;
//           }
//         }
//       }
//
//     });
//   }
// }
