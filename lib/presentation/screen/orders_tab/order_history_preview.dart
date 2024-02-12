import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/orders/get_order_history_detail.dart';
import 'package:food_app/network/get_setting_repo.dart';
import 'package:food_app/network/orders_repo/cancel_order_model.dart';
import 'package:food_app/network/orders_repo/postponse_order.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../main.dart';
import '../../../model/get_postpone_menu_details.dart';
import '../../../model/get_settings_model.dart';
import '../../../network/location_screen/get_default_address.dart';
import '../../../network/orders_repo/active_order_customization_model.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/helper_class.dart';
import 'active_order_customize_preview.dart';

class OrderHistoryPreview extends StatefulWidget {
  final String orderId;
  final String? orderItemId;
  final String? kitchenName;

  const OrderHistoryPreview(
      {Key? key, required this.orderId, this.orderItemId, this.kitchenName})
      : super(key: key);

  @override
  State<OrderHistoryPreview> createState() => _OrderHistoryPreviewState();
}

class _OrderHistoryPreviewState extends State<OrderHistoryPreview> {
  Future<GetOrderHistoryDetail?>? future;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    final order =
        Provider.of<ActiveOrderCustomizationModel>(context, listen: false);
    final getDefault =
        Provider.of<GetDefaultAddressModel>(context, listen: false);

    future = order.gettingOrderHistoryDetail(widget.orderId);
    //orderModel.gettingOrderHistoryDetail(widget.orderId);
  }

  Future<void> _pullRefresh() async {
    setState(() {
      future =
          Provider.of<ActiveOrderCustomizationModel>(context, listen: false)
              .gettingOrderHistoryDetail(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final settingModel = Provider.of<GetSettingModel>(context, listen: false);
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          leadingWidth: 40,
          backgroundColor: Colors.white, //AppConstant.appColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SvgPicture.asset(
                'assets/images/Xback.svg',
                height: 20,
                width: 20,
              ),
            ),
          ),
          title: Text(
            widget.kitchenName ?? "", //Order Customization
            style: const TextStyle(
                fontFamily: AppConstant.fontRegular, color: Colors.black),
          ),
        ),
        backgroundColor: AppConstant.appColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 12, right: 12, top: 24),
          child: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: FutureBuilder<GetOrderHistoryDetail?>(
                future: future,
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.done && snapshot.data != null
                      ? SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: RefreshIndicator(
                            onRefresh: _pullRefresh,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                     // Text(
                                     //   " From  ${snapshot.data!.data[0].orderDate!.startDate.toString()} to ${snapshot.data!.data[0].orderDate!.endDate}",
                                     //   //" From  ${snapshot.data!.data[0].orderDate!.startDate.toString()} to ${snapshot.data!.data[0].orderDate!.endDate}",
                                     //   style: const TextStyle(
                                     //       fontFamily: AppConstant.fontBold),
                                     // ),
                                      /* Text(
                                        snapshot.data!.data[0].kitchenName!,
                                        style: const TextStyle(
                                            fontFamily: AppConstant.fontBold),
                                      ),*/
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  FittedBox(
                                    child: DottedBorder(
                                      color: Colors.black,
                                      strokeWidth: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0, vertical: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Package:  ",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                            Text(
                                              "${snapshot.data!.data?.items?.first.items!.toString()}",
                                              //snapshot.data!.data[0].itemName!,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w300,
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  /* const Divider(color: Colors.black),
                                  const SizedBox(
                                    height: 12,
                                  ),*/
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.data!.items?.length,
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0, bottom: 84),
                                      itemBuilder: (context, index) {
                                        bool isDelivered = snapshot.data!.data?.items?.first.status == 2;//snapshot.data!.data[index].status == 2
                                       // bool isEditable = snapshot.data!.data[index].date!.isAfter(DateTime.now()) ||
                                      //     snapshot.data!.data[index].date!
                                      //             .isAtSameMomentAs(
                                      //                 DateTime.now()) &&
                                      //         DateFormat('H:i:s')
                                      //             .parse(
                                      //               DateFormat('H:i:s')
                                      //                   .format(
                                      //                 DateTime.now()
                                      //                     .add(Duration(
                                      //                   hours: int.parse(
                                      //                       settingModel
                                      //                           .getSetting!
                                      //                           .data
                                      //                           .priorTimeToCancelEditOrder),
                                      //                 )),
                                      //               ),
                                      //             )
                                      //             .isBefore(DateFormat(
                                      //                     'H:i:s')
                                      //                 .parse(snapshot
                                      //                     .data!
                                      //                     .data[index]
                                      //                     .deliveryFromTime!));
                                      final itemStatus = Helper.getItemStatus(
                                          itemStatus: snapshot.data!.data!  .items?.first.status ?? ""
                                          //itemStatus: snapshot.data!.data[index].itemStatus ?? ""
                                      );

                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("",
                                                       // "${dateTimeFormat(snapshot.data!.data[index].date.toString(), "E, dd MMM, yyyy")} ",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                AppConstant
                                                                    .fontBold,
                                                            color: AppConstant
                                                                .appColor,
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Container(
                                                        width: 190,
                                                        // color:Colors.red,
                                                        child: Text(
                                                        //snapshot
                                                        //        .data!
                                                        //        .data[index]
                                                        //        .dishItem ??
                                                              "",
                                                          maxLines: 6,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        "${snapshot.data!.data?.items?.first.deliveryFromtime!} -  ${snapshot.data!.data?.items?.first.deliveryTotime!} ",
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Helper.getItemStatusButton(
                                                      itemStatus: snapshot.data!.data?.items?.first.status ??
                                                      //itemStatus: snapshot.data!.data[index].itemStatus ??
                                                          ""),
                                                  if (itemStatus == ItemStatusEnum.pending)
                                                    Column(
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            print(
                                                                "Order ${snapshot.data!.data?.orderId}");
                                                            //if (snapshot.data!.data[index].date!.isBefore(DateTime.now())) {// if (snapshot.data!.data[index].date!.isBefore(DateTime.now()))
                                                            //  return;
                                                            //}
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ActiveOrderCustomizeScreen(
                                                                            orderData:
                                                                                snapshot.data!.data!,
                                                                          )),
                                                            );
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Colors
                                                                        .black),
                                                          ),
                                                          child: const Text(
                                                            'Edit',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    AppConstant
                                                                        .fontRegular,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                           // print(snapshot
                                                           //     .data!
                                                           //     .data[index]
                                                           //     .orderItemsId);
                                                            postponeCancelDialogue(
                                                                snapshot.data!.data!);
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                              const Color
                                                                  .fromRGBO(234,
                                                                  0, 0, 0.7),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Cancel`", // Postpon
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  AppConstant
                                                                      .fontRegular,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      47,
                                                                      52,
                                                                      67,
                                                                      0.8),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                ],
                                              ),

                                              const SizedBox(
                                                height: 12,
                                              ),

                                              //const Spacer(),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.end,
                                              //   children: [
                                              //   /*  Helper.getItemStatusButton(
                                              //         itemStatus: snapshot
                                              //                 .data!
                                              //                 .data[index]
                                              //                 .itemStatus ??
                                              //             ""),*/
                                              //
                                              //     if (itemStatus == ItemStatusEnum.pending)
                                              //       Column(
                                              //         children: [
                                              //           ElevatedButton(
                                              //             onPressed: () {
                                              //               print(
                                              //                   "Order ${snapshot.data!.data[index].orderId}");
                                              //               if (snapshot.data!.data[index].date!.isBefore(DateTime.now())) {
                                              //                 return;
                                              //               }
                                              //               Navigator.push(
                                              //                 context,
                                              //                 MaterialPageRoute(
                                              //                     builder:
                                              //                         (context) =>
                                              //                             ActiveOrderCustomizeScreen(
                                              //                               orderData: snapshot
                                              //                                   .data!
                                              //                                   .data[index],
                                              //                             )),
                                              //               );
                                              //
                                              //               //Navigator.pushNamed(context, '/customization');
                                              //             },
                                              //             style: ButtonStyle(
                                              //               backgroundColor: MaterialStateProperty.all(Colors.black),
                                              //              //shape: MaterialStateProperty.all(
                                              //              //  RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),
                                              //              //  ),
                                              //              //),
                                              //             ),
                                              //             child: const Text(
                                              //               'Edit',
                                              //               style: TextStyle(fontFamily: AppConstant.fontRegular,
                                              //                   color: Colors.white),
                                              //             ),
                                              //           ),
                                              //           const SizedBox(
                                              //             height: 6,
                                              //           ),
                                              //           ElevatedButton(
                                              //             onPressed: () {
                                              //               print(snapshot.data!.data[index].orderItemsId);
                                              //               postponeCancelDialogue(snapshot.data!.data[index]);
                                              //             },
                                              //             style: ButtonStyle(
                                              //               backgroundColor:
                                              //                   MaterialStateProperty.all(const Color.fromRGBO(234, 0, 0, 0.7),),
                                              //             ),
                                              //             child: const Text(
                                              //               "Cancel",// Postpon
                                              //               style: TextStyle(
                                              //                   fontFamily:
                                              //                       AppConstant
                                              //                           .fontRegular,
                                              //                   color:
                                              //                   Color.fromRGBO(47, 52, 67, 0.8),),
                                              //             ),
                                              //           )
                                              //         ],
                                              //       ),
                                              //
                                              //   ],
                                              // ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const Divider(
                                                height: 1,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ]);
                                      })
                                ]),
                          ),
                        )
                      : const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "LOADING",
                                style: TextStyle(
                                    fontFamily: AppConstant.fontBold,
                                    color: AppConstant.appColor),
                              ),
                              CircularProgressIndicator(
                                color: AppConstant.appColor,
                              )
                            ],
                          ),
                        );
                }),
          ),
        ),
      ),
    );
  }

  Future<void> cancelDialogue(OrderDetailsModel orderDetails) {
    final orderModel =
        Provider.of<ActiveOrderCustomizationModel>(context, listen: false);
    final cancelModel = Provider.of<CancelOrderModel>(context, listen: false);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(12),
              height: 200,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel),
                    ),
                  ),
                  const Text(
                    "Are you sure you want \n to cancel the order ?",
                    style: TextStyle(
                        fontFamily: AppConstant.fontRegular, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        onPressed: () {
                          cancelModel.cancelOrder(orderDetails.items!.first.orderItemId.toString())//orderDetails.orderItemsId!
                              .then((response) {
                            if (response.statusCode == 200) {
                              orderModel.gettingOrderHistoryDetail(
                                  orderDetails.orderId.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Order cancelled successfully",
                                    style: TextStyle(
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                ),
                              );
                              setState(() {
                                future = context
                                    .read<ActiveOrderCustomizationModel>()
                                    .gettingOrderHistoryDetail(widget.orderId);
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } else {
                              throw Exception("Something went wrong");
                            }
                          });
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            const Size(80, 30),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          // orderMenuDetailApi(
                          //     snapshot.data!.data[idx]!.orderItemsId ?? '');
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future postponeCancelDialogue(OrderDetailsModel orderDetails) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Adjust the radius as needed
              ),
              child: Container(
                padding:
                    const EdgeInsets.only(bottom: 8, top: 4, right: 4, left: 4),
                height: 302,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Image(
                            image:
                                AssetImage("assets/images/cross_outline.png"),
                            height: 24,
                            width: 24,
                          )),
                    ), //const Icon(Icons.cancel))
                    const SizedBox(
                      height: 12,
                    ),
                    SvgPicture.asset("assets/images/Character.svg"),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "How would you like to cancel the Meal?",
                      style: TextStyle(fontFamily: AppConstant.fontRegular),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder:
                                        (BuildContext context, _, __) =>
                                            PostPoneDialog(
                                      orderDetails: orderDetails,
                                      refreshOrdersCallback: () {
                                        setState(() {
                                          future = context
                                              .read<
                                                  ActiveOrderCustomizationModel>()
                                              .gettingOrderHistoryDetail(
                                                  orderDetails.orderId!);
                                        });
                                      },
                                    ),
                                  ),
                                )
                                .then((value) => Navigator.pop(context));
                            /*showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => */
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Postpone Meal',
                            style: TextStyle(
                                fontSize: 10.5,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              cancelDialogue(orderDetails);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Cancel/Refund Amount",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.5,
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    )
                  ],
                ),

                // Map<String, dynamic>
                //     newData =
                //     await Navigator.of(context).push(
                //   PageRouteBuilder(
                //     opaque: false,
                //     pageBuilder: (BuildContext context, _, __) => PostponeMenuScreen(
                //       orderItemId: snapshot.data!.data[idx]!.orderItemsId!,
                //       previousOrderAmount: snapshot.data!.data[idx]!.totalAmount,
                //     ),
                //   ),
                // );
                // setState(() {
                //   var address = newData['id'];
                //   if (address != '') {
                //     snapshot.data!.data[idx]!.itemStatus = '8';
                //     // Navigator.of(context).pop();
                //   }
                //   OrderHistoryPreview(orderId: snapshot.data!.data[idx]!.orderId!);
                // });
              ));
        });
  }
}

class PostPoneDialog extends StatefulWidget {
  final OrderDetailsModel orderDetails;
  final Function refreshOrdersCallback;

  const PostPoneDialog(
      {required this.orderDetails,
      required this.refreshOrdersCallback,
      Key? key})
      : super(key: key);

  @override
  State<PostPoneDialog> createState() => _PostPoneDialogState();
}

class _PostPoneDialogState extends State<PostPoneDialog> {
  bool isWalletActive = false;
  late Razorpay _razorpay;
  double todayPrice = 0.0;
  double postponePrice = 0.0;
  Future? future;
  var totalToAmount;
  var finalAmount;
  var taxPercent;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    final postponeModel =
        Provider.of<PostPoneOrderModel>(context, listen: false);
    final getSetting = Provider.of<GetSettingModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        leadingWidth: 40,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SvgPicture.asset(
              'assets/images/Xback.svg',
              height: 20,
              width: 20,
            ),
          ),
        ),
        title: const Text(
          "Post-Pone Meal",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              FutureBuilder<GetPostponeMenuDetails>(
                  future: postponeModel.getPostPoneMenu(
                      widget.orderDetails.items!.first.orderItemId.toString()),
                      //widget.orderDetails.orderItemsId.toString()),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null
                        ? Column(children: [
                            Row(
                              children: [
                                Text(
                                  dateTimeFormat(
                                      snapshot.data!.data.currentOrderItem.date
                                          .toString(),
                                      "E, dd MMM, yyyy"),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppConstant.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                const Spacer(),
                                Text(
                                  DateFormat.jm().format(DateFormat("hh:mm")
                                      .parse(snapshot.data!.data
                                          .currentOrderItem.fromTime)),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppConstant.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                const Text(
                                  "-",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppConstant.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                Text(
                                  DateFormat.jm().format(DateFormat("hh:mm")
                                      .parse(snapshot
                                          .data!.data.currentOrderItem.toTime)),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppConstant.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.fontRegular),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    /*  boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 20.0,
                                          offset: Offset(0.0, 0.75))
                                    ],
                                    border: Border.all(color: Colors.black),*/
                                    color: Colors.white),
                                child: ExpansionTile(
                                  iconColor: Colors.black,
                                  textColor: Colors.black,
                                  title: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Items : ${snapshot.data!.data.currentOrderItem.items.length}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 36,
                                      ),
                                      Text(
                                        "Total amount : ${AppConstant.rupee} ${snapshot.data!.data.currentOrderItem.totalAmount}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.black,
                                  ),
                                  children: <Widget>[
                                    ListView.builder(
                                        itemCount: snapshot.data!.data
                                            .currentOrderItem.items.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        //color:Colors.red,
                                                        width: 200,
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .data
                                                              .currentOrderItem
                                                              .items[index]
                                                              .itemName
                                                              .toString(),
                                                          maxLines: 7,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Quantity: ${snapshot.data!.data.currentOrderItem.items[index].qty.toString()}",
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    ]),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Divider(
                                                  height: 2,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Row(
                              children: [
                                Text(
                                  snapshot.data!.data.newOrderDay.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppConstant.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "${snapshot.data!.data.newDate.day.toString()}-${snapshot.data!.data.newDate.month.toString()}-${snapshot.data!.data.newDate.year.toString()}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppConstant.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                const Spacer(),
                                Text(
                                  "${DateFormat.jm().format(DateFormat("hh:mm").parse(snapshot.data!.data.deliveryFromTime.toString()))} -${DateFormat.jm().format(DateFormat("hh:mm").parse(snapshot.data!.data.deliveryToTime.toString()))}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: AppConstant.appColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.fontRegular),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 2, right: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    /* boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          color: Colors.black54,
                                          blurRadius: 20.0,
                                          offset: Offset(0.0, 0.75))
                                    ],
                                    border: Border.all(color: Colors.black),*/
                                    color: Colors.white),
                                child: ExpansionTile(
                                  iconColor: Colors.black,
                                  textColor: Colors.black,
                                  title: Row(
                                    children: [
                                      Text(
                                        "Items : ${snapshot.data!.data.noOfItems}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Total amount : ${AppConstant.rupee} ${snapshot.data!.data.currentItemPrice}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.black,
                                  ),
                                  children: <Widget>[
                                    ListView.builder(
                                        itemCount: snapshot
                                            .data!.data.newMenuItems.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 220,
                                                        //color:Colors.red,
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .data
                                                              .newMenuItems[
                                                                  index]
                                                              .itemName
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Quantity: ${snapshot.data!.data.newMenuItems[index].qty.toString()}",
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    ]),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Divider(
                                                  height: 2,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            double.parse(snapshot.data!.data.currentItemPrice) <
                                    double.parse(
                                        snapshot.data!.data.postponeItemPrice)
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              DateFormat.E().format(snapshot
                                                  .data!
                                                  .data
                                                  .currentOrderItem
                                                  .date),
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      47, 52, 67, 1.0),
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "(${snapshot.data!.data.currentOrderItem.totalAmount}) - ",
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      47, 52, 67, 1.0),
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              DateFormat.E().format(
                                                  snapshot.data!.data.newDate),
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      47, 52, 67, 1.0),
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "(${snapshot.data!.data.currentItemPrice})",
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      47, 52, 67, 1.0),
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              //${AppConstant.rupee}
                                              " = ${double.parse(snapshot.data!.data.postponeItemPrice) - double.parse(snapshot.data!.data.currentItemPrice)}", //.substring(0, 10)
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      47, 52, 67, 1.0),
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.center,
                                          child: poppinsText(
                                              txt:
                                                  "Your wallet will be credited with : ${AppConstant.rupee}${double.parse(snapshot.data!.data.currentItemPrice) - double.parse(snapshot.data!.data.postponeItemPrice)}"
                                                      .replaceAll("-", " ")
                                                      .substring(0, 41),
                                              maxLines: 3,
                                              fontSize: 16,
                                              textAlign: TextAlign.center,
                                              weight: FontWeight.w600),
                                        )
                                      ])
                                : const SizedBox(),
                            const SizedBox(
                              height: 12,
                            ),
                            double.parse(
                                        snapshot.data!.data.currentItemPrice) >=
                                    double.parse(
                                        snapshot.data!.data.postponeItemPrice)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                        Text(
                                          "${DateFormat.E().format(snapshot.data!.data.currentOrderItem.date)} (${snapshot.data!.data.postponeItemPrice}) - ${DateFormat.E().format(snapshot.data!.data.newDate)} (${snapshot.data!.data.currentItemPrice})",
                                          style: const TextStyle(
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                        Text(
                                          " = ${AppConstant.rupee} ${double.parse(snapshot.data!.data.postponeItemPrice).toPrecision(2) - double.parse(snapshot.data!.data.currentItemPrice).toPrecision(2)}"
                                              .replaceAll("-", "")
                                              .trimRight(),
                                          style: const TextStyle(
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        )
                                      ])
                                : const SizedBox(),
                            snapshot.data!.data.taxAmount == "0.00"
                                ? Container()
                                : FutureBuilder<GetSetting>(
                                    future: getSetting.getSettings(),
                                    builder: (context, snapshott) {
                                      return snapshott.connectionState ==
                                                  ConnectionState.done &&
                                              snapshott.data != null
                                          ? SizedBox(
                                              height: 20,
                                              child: Text(
                                                "Tax Amount (${snapshott.data!.data.taxOnOrder} %) : ${snapshot.data!.data.taxAmount}",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                                textAlign: TextAlign.end,
                                              ),
                                            )
                                          : Container();
                                    }),
                            const SizedBox(
                              height: 12,
                            ),
                            double.parse(snapshot.data!.data.payAmount) > 0
                                ? Column(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Pay amount from",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  47, 52, 67, 1.0),
                                              fontSize: 14.5,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Wallet ",
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      47, 52, 67, 0.7),
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            FlutterSwitch(
                                              activeColor: AppConstant.appColor,
                                              width: 33.0,
                                              height: 17.0,
                                              //valueFontSize: 25.0,
                                              toggleSize: 15.0,
                                              value: isWalletActive,
                                              borderRadius: 30.0,
                                              padding: 3.0,
                                              //showOnOff: true,
                                              onToggle: (value) {
                                                isWalletActive = value;
                                                updateWalletStatus(value);
                                              },
                                            ),
                                            /*   Switch(
                                            value: isWalletActive,
                                            onChanged: (value) {
                                              // setState(() {
                                              isWalletActive = value;

                                              print(value);
                                              updateWalletStatus(value);
                                              // totalToAmount = snapshot
                                              //     .data!.data.payAmount;
                                              // print("totl$totalToAmount");
                                              // if (double.parse(snapshot
                                              //         .data!
                                              //         .data
                                              //         .payAmount) >
                                              //     0) {
                                              //   if (value == false) {
                                              //     //totalToAmount = double.parse(snapshot.data.data.a);
                                              //   } else {
                                              //     var ttotalToAmount = double
                                              //             .parse(snapshot
                                              //                 .data!
                                              //                 .data
                                              //                 .foodieWalletAmount
                                              //                 .toString()) -
                                              //         double.parse(
                                              //             totalToAmount
                                              //                 .toString());
                                              //     if (ttotalToAmount < 0) {
                                              //       ttotalToAmount = 0;
                                              //     }
                                              //   }
                                              // }
                                              //  });
                                            },
                                            // inactiveThumbColor: Colors.red,
                                            // inactiveTrackColor: Colors.red.shade300,
                                            activeColor:
                                            AppConstant.appColor,
                                            activeTrackColor:
                                            const Color.fromARGB(
                                                255, 253, 202, 51),
                                          ),*/
                                            Text(
                                              " ( ${AppConstant.rupee} ${snapshot.data!.data.foodieWalletAmount})",
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      47, 52, 67, 0.7),
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // const Divider(
                                    //   color: Colors.grey,
                                    // ),
                                    // isWalletActive == false
                                    //     ? Row(
                                    //         mainAxisAlignment:
                                    //             MainAxisAlignment
                                    //                 .spaceBetween,
                                    //         children: [
                                    //           const Text(
                                    //             "To Pay",
                                    //             style: TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontFamily: AppConstant
                                    //                     .fontBold,
                                    //                 fontSize: 16),
                                    //           ),
                                    //           Text(
                                    //             "₹" +
                                    //                 "${snapshot.data!.data.payAmount}",
                                    //             style: const TextStyle(
                                    //                 color: Colors.black,
                                    //                 fontFamily: AppConstant
                                    //                     .fontBold,
                                    //                 fontSize: 16),
                                    //           ),
                                    //         ],
                                    //       )
                                    //     : SizedBox(),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    /*("!isWalletAmountAvailable" && int.parse(totalAmount!) >= 0)
                                  ?*/
                                    // isWalletActive == false
                                    //     ? Column(
                                    //         children: <Widget>[
                                    //           ListTile(
                                    //             title: const Text(
                                    //                 'Pay Online'),
                                    //             leading: Radio(
                                    //               value: 1,
                                    //               groupValue: _character,
                                    //               onChanged: (value) {
                                    //                 setState(() {
                                    //                   _character = 1;
                                    //                 });
                                    //               },
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       )
                                    //     : SizedBox(),
                                    const SizedBox(height: 12),

                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        " Total Amount: ${AppConstant.rupee}${double.parse(snapshot.data!.data.payAmount).toPrecision(2) + double.parse(snapshot.data!.data.taxAmount).toPrecision(2)}",
                                        style: const TextStyle(
                                            color:
                                                Color.fromRGBO(47, 52, 67, 0.7),
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ])
                                : const SizedBox(),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Refunding Amount To Your Wallet : ${AppConstant.rupee}${double.parse(snapshot.data!.data.currentItemPrice) - double.parse(snapshot.data!.data.postponeItemPrice)}"
                                    .replaceAll("-", " "), //.substring(0, 41)
                                style: const TextStyle(
                                    color: Color.fromRGBO(47, 52, 67, 0.7),
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                 // print("==============================orderItemsId>${widget.orderDetails.orderItemsId!}");
                                  print("==============================orderItemsId>${isWalletActive == true ? "1" : "0"}");
                                  postponeModel
                                      .postponeOrder(
                                      widget.orderDetails.items!.first.orderItemId.toString(),
                                        //  widget.orderDetails.orderItemsId!,
                                          isWalletActive == true ? "1" : "0")
                                      .then((response) async {
                                    if (response.statusCode == 200) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Postpone Successful",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          ),
                                        ),
                                      );
                                      Navigator.pop(context);
                                      widget.refreshOrdersCallback();
                                    } else {
                                      print(
                                          "==============================else>${response.body}");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Something went wrong",
                                            style: TextStyle(
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          ),
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(47, 52, 67, 1)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  todayPrice >= postponePrice
                                      ? "Submit"
                                      : "PAY Now",
                                  style: const TextStyle(
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ),
                            ),
                          ])
                        : const Center(
                            child: CircularProgressIndicator(
                              color: AppConstant.appColor,
                            ),
                          );
                  }),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateWalletStatus(value) {
    setState(() {
      isWalletActive = value;
      if (value == true) {
        totalToAmount;
      } else {
        totalToAmount;

        //double.parse(totalToAmount.toString())-double.parse(walletBalance) ;
        // if (double.parse(totalToAmount!) < 0) {
        //   //totalToAmount = 0;
        // }
      }
    });
  }

  void openCheckout(String finalAmount, String orderId) async {
    //var orderId = data.id;
    //RazorpayKey,if test -> rzp_test_lxUciWRieYANWW if live -> rzp_live_Yiq5xQzeTYTZ6z
    var options = {
      'amount': finalAmount * 100,
      'name': 'Nohung',
      'description': '',
      'order_id': orderId,
      'timeout': 180, //in seconds
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {}
    // var options = {
    //   'key': "rzp_test_lxUciWRieYANWW",
    //   //RazorpayKey,if test -> rzp_test_lxUciWRieYANWW if live -> rzp_live_Yiq5xQzeTYTZ6z
    //   'amount': finalAmount * 100,
    //   'name': 'Nohung',
    //   "prefill": {},
    //   'description': 'Food Subscription App',
    //   //'order_id': '${data.id}',
    //   'timeout': 180,
    //   //in seconds
    // };
    //
    // try {
    //   _razorpay.open(options);
    // } catch (e) {
    //   debugPrint('Error: e');
    // }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final postponeMenu =
        Provider.of<PostPoneOrderModel>(context, listen: false);
    final orderModel =
        Provider.of<ActiveOrderCustomizationModel>(context, listen: false);
    Fluttertoast.showToast(
            msg: "SUCCESS: ${response.paymentId!}",
            toastLength: Toast.LENGTH_SHORT)
        .then(
      (response) => postponeMenu.postponeOrder(widget.orderDetails.items!.first.orderItemId.toString(),//widget.orderDetails.orderItemsId!,
              isWalletActive == true ? "1" : "0")
          .then((response) {
        if (response.statusCode == 200) {
          orderModel.gettingOrderHistoryDetail(
              widget.orderDetails.orderId.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Success"),
            ),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          throw Exception("Something went wrong");
        }

        // transaction.createTransaction(
        //     widget.orderId,
        //     orderNumber,
        //     response.body,
        //     amount,
        //     paymentType,
        //     postData,
        //     paymentMethod);
      }),
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Error-Payment failed");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "External Wallet -${response.walletName!}");
  }
}
