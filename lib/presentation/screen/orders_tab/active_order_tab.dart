import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/model/orders/get_active_order.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../network/orders_repo/active_orders_repo.dart';
import '../../../res.dart';
import '../../../utils/constants/ui_constants.dart';
import '../landing/landing_screen.dart';
import 'order_history_preview.dart';

class ActiveOrdersTab extends StatefulWidget {
  final Function refreshOrdersCallback;

  ActiveOrdersTab({required this.refreshOrdersCallback, Key? key})
      : super(key: key);

  @override
  State<ActiveOrdersTab> createState() => _ActiveOrdersTabState();
}

class _ActiveOrdersTabState extends State<ActiveOrdersTab> {
  bool like = false;
  bool disLike = true;
  String userId = '';
  Future<GetActiveOrders?>? future;

  @override
  void initState() {
    super.initState();
    final activeModel = Provider.of<ActiveOrdersModel>(context, listen: false);
    future = activeModel.getActiveOrders();
  }

  @override
  Widget build(BuildContext context) {
    final activeModel = Provider.of<ActiveOrdersModel>(context, listen: false);
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<GetActiveOrders?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstant.appColor,
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
            if (!snapshot.data!.status) {
              return SizedBox(
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Image.asset(
                      'assets/images/image_no_orders.png',
                      width: screenWidth * 0.7,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    poppinsText(
                        txt: 'NO ORDER YET',
                        fontSize: 22,
                        weight: FontWeight.w500),
                    const SizedBox(
                      height: 20,
                    ),
                    InkResponse(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LandingScreen(),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: ShapeDecoration(
                          color: kYellowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 3,
                              offset: Offset(0, 1),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Text(
                          "Browse Kitchens",
                          style: AppTextStyles.titleText.copyWith(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                color: AppConstant.appColor,
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 1));
                  setState(() {});
                },
                child: ListView(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.data.length,
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 200),
                        itemBuilder: (context, index) {
                          DateTime date = DateTime.parse(
                              snapshot.data!.data[index].orderNowDeliveryDate ??
                                  "");
                          String formattedDate =
                              DateFormat('d MMM yyyy').format(date);
                          DateTime fromTime = DateFormat('HH:mm:ss').parse(
                              snapshot.data!.data[index]
                                      .orderNowDeliveryFromTime ??
                                  "");
                          String formattedFromTime =
                              DateFormat('h:mm a').format(fromTime);
                          DateTime toTime = DateFormat('HH:mm:ss').parse(
                              snapshot.data!.data[index]
                                      .orderNowDeliveryToTime ??
                                  "");
                          String formattedToTime =
                              DateFormat('h:mm a').format(toTime);

                          return Container(
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      2.0,
                                      2.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  ),
                                  //BoxShadow
                                  // BoxShadow(
                                  //   color: Colors.white,
                                  //   offset: const Offset(0.0, 0.0),
                                  //   blurRadius: 0.0,
                                  //   spreadRadius: 0.0,
                                  // ), //BoxShadow
                                ],
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!.data[index].kitchenname ??
                                          "",
                                      style: const TextStyle(
                                          fontFamily: AppConstant.fontBold,
                                          fontSize: 20),
                                    ),
                                    (int.parse(snapshot
                                                    .data!.data[index].status ??
                                                "") ==
                                            6)
                                        ? const Text(
                                            "Subscription Completed",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        : Container(),
                                    (int.parse(snapshot
                                                    .data!.data[index].status ??
                                                "") ==
                                            7)
                                        ? const Text(
                                            "Subscription Cancelled",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        : Container(),
                                    (int.parse(snapshot
                                                    .data!.data[index].status ??
                                                "") ==
                                            8)
                                        ? const Text(
                                            "Subscription Postponed",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        : Container(),
                                    (int.parse(snapshot
                                                    .data!.data[index].status ??
                                                "") ==
                                            2)
                                        ? const Text(
                                            "Order Rejected",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        : Container(),
                                    (int.parse(snapshot
                                                    .data!.data[index].status ??
                                                "") ==
                                            0)
                                        ? const Text(
                                            "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        : Container(),
                                    // (int.parse(snapshot.data!.data![index]
                                    //                 .status!) ==
                                    //             1 ||
                                    //         int.parse(snapshot.data!.data![index]
                                    //                 .status!) ==
                                    //             3 ||
                                    //         int.parse(snapshot.data!.data![index]
                                    //                 .status!) ==
                                    //             4 ||
                                    //         int.parse(snapshot.data!.data![index]
                                    //                 .status!) ==
                                    //             5)
                                    //     ? Text(
                                    //         "Active",
                                    //         style: TextStyle(
                                    //             fontSize: 16,
                                    //             color: Colors.green,
                                    //             fontFamily:
                                    //                 AppConstant.fontRegular),
                                    //       )
                                    //     : Container(),
                                    // snapshot.data!.data![index].favoriteOrder=="0"?
                                    Row(
                                      children: [
                                        const Text(
                                          "Active",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                        SizedBox(width: 6),
                                        InkWell(
                                          onTap: () async {
                                            snapshot.data!.data[index].favoriteOrder == "0"
                                                ? activeModel.addToFav(snapshot.data!.data[index].id.toString()).then((response) {
                                                    if (response.statusCode == 200) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          duration: Duration(seconds: 1),
                                                          content: Text(
                                                            "Added to Fav",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                AppConstant.fontRegular),
                                                          ),
                                                        ),
                                                      );

                                                      setState(() {
                                                        snapshot
                                                                .data!
                                                                .data[index]
                                                                .favoriteOrder =
                                                            "1";
                                                        // like = true;
                                                        // disLike = false;
                                                      });
                                                    }
                                                  })
                                                : activeModel.removeFromFav(snapshot.data!.data[index].id.toString()).then((response) {
                                                    if (response.statusCode == 200) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          duration: Duration(seconds: 1),
                                                          content: Text(
                                                            "Removed from fav order",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                AppConstant.fontRegular),
                                                          ),
                                                        ),
                                                      );
                                                      setState(() {
                                                        snapshot.data!.data[index].favoriteOrder = "0";
                                                      });

                                                      // ScaffoldMessenger.of(context)
                                                      //     .showSnackBar(
                                                      //   SnackBar(
                                                      //     duration:
                                                      //         Duration(seconds: 1),
                                                      //     content: Text(
                                                      //       "Removed from fav order",
                                                      //       style: TextStyle(
                                                      //           fontFamily:
                                                      //               AppConstant
                                                      //                   .fontRegular),
                                                      //     ),
                                                      //   ),
                                                      // );
                                                    }
                                                  });
                                            // setState(() {
                                            //   future = context
                                            //       .read<ActiveOrdersModel>()
                                            //       .getActiveOrders();
                                            // });
                                          },
                                          child: snapshot.data!.data[index].favoriteOrder == "1"
                                              ? SvgPicture.asset(
                                                  Res.heartFill,
                                                  color: Colors.red,
                                                  height: 20,
                                                  width: 20,
                                                )
                                              : SvgPicture.asset(
                                                  Res.heartOutline,
                                                  color: Colors.red,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),

                                Text(
                                  "${AppConstant.rupee}${snapshot.data!.data[index].netamount}",
                                  style: TextStyle(
                                    fontFamily: AppConstant.fontRegular,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                // (int.parse(snapshot.data!.data![index].status ?? '0') == 1 ||
                                //         int.parse(snapshot.data!.data![index].status!) == 3 ||
                                //         int.parse(snapshot.data!.data![index].status!) == 4 ||
                                //         int.parse(snapshot.data!.data![index].status!) == 5)
                                //     ? const Text(
                                //         "You can Customize",
                                //         style: TextStyle(
                                //             fontSize: 16,
                                //             fontFamily: AppConstant.fontRegular),
                                //       )
                                //     : Container(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            snapshot.data!.data[index]
                                                        .ordertype ==
                                                    "trial"
                                                ? "Items:"
                                                : "Package Name:",
                                            style: const TextStyle(
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const Text(
                                          "Order No :",
                                          style: TextStyle(
                                            fontFamily: AppConstant.fontRegular,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        const Text(
                                          "Ordered On :",
                                          style: TextStyle(
                                            fontFamily: AppConstant.fontRegular,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        if (snapshot
                                                .data!.data[index].ordertype ==
                                            "trial")
                                          const Text(
                                            "Delivery On :",
                                            style: TextStyle(
                                              fontFamily:
                                                  AppConstant.fontRegular,
                                              color: Colors.black,
                                            ),
                                          ),
                                        if (snapshot
                                                .data!.data[index].ordertype ==
                                            "trial")
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        snapshot.data!.data[index].ordertype ==
                                                "package"
                                            ? const Text(
                                                "Order From :",
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                              maxHeight: 20, maxWidth: 220),
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                        .data!
                                                        .data[index]
                                                        .ordertype ==
                                                    "trial"
                                                ? snapshot.data!.data[index]
                                                    .trialOrders?.length
                                                : snapshot.data!.data[index]
                                                    .packageDetail?.length,
                                            itemBuilder: (context, idx) {
                                              return Container(
                                                  constraints: BoxConstraints(
                                                      maxHeight: 250,
                                                      maxWidth: 250),
                                                  child: Text(
                                                    snapshot.data!.data[index]
                                                                .ordertype ==
                                                            "trial"
                                                        ? "${snapshot.data!.data[index].trialOrders?[idx].itemName}"
                                                        : "${snapshot.data!.data[index].packageDetail?[idx].itemName}",
                                                    style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ));
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          snapshot.data!.data[index].orderid ??
                                              "",
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontFamily:
                                                  AppConstant.fontRegular),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          snapshot.data!.data[index].orderOn ??
                                              "",
                                          style: TextStyle(
                                            fontFamily: AppConstant.fontRegular,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        if (snapshot
                                                .data!.data[index].ordertype ==
                                            "trial")
                                          Text(
                                            "$formattedDate at $formattedFromTime",
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          ),
                                        if (snapshot
                                                .data!.data[index].ordertype ==
                                            "trial")
                                          const SizedBox(
                                            height: 12,
                                          ),
                                        snapshot.data!.data[index].ordertype ==
                                                "package"
                                            ? Text(
                                                snapshot.data!.data[index]
                                                        .orderfrom ??
                                                    "",
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              )
                                            : const SizedBox(),
                                      ],
                                    )
                                  ],
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: AppConstant.appColor
                                            .withOpacity(0.3),
                                      ),
                                      // height: 40,
                                      width: 80,
                                      alignment: Alignment.center,
                                      child: snapshot.data!.data[index]
                                                  .ordertype ==
                                              "trial"
                                          ? Text(
                                              '${snapshot.data!.data[index].trialOrders?[0].mealtype}',
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            )
                                          : Text(
                                              '${snapshot.data!.data[index].packageDetail?.first.mealtype}',
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      decoration: BoxDecoration(
                                        color: AppConstant.appColor
                                            .withOpacity(0.3),
                                      ),
                                      // height: 40,
                                      width: 80,
                                      alignment: Alignment.center,
                                      child: snapshot.data!.data[index]
                                                  .ordertype ==
                                              "trial"
                                          ? Center(
                                              child: Text(
                                                '${snapshot.data!.data[index].trialOrders?[0].cuisine}',
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                            )
                                          : Text(
                                              '${snapshot.data!.data[index].packageDetail?.first.cuisine}',
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Spacer(),
                                    snapshot.data!.data[index].ordertype !=
                                            "trial"
                                        ? ElevatedButton(
                                            onPressed: () {
                                                print("========================ref${snapshot.data!.data[index].id ?? ""}");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderHistoryPreview(
                                                          orderItemId: snapshot.data!.data[index].packageDetail?[0].referenceId.toString(),//snapshot.data!.data[index].packageDetail?[0].id.toString()
                                                          orderId: snapshot.data!.data[index].id ?? "",
                                                          kitchenName: snapshot.data!.data[index].kitchenname,
                                                        )),
                                              );
                                            },
                                            style: ButtonStyle(
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black),
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                const Size(120, 30),
                                              ),
                                            ),
                                            child: const Text(
                                              "Customize",
                                              style: TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular,
                                                  color: Colors.white),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 170,
                    )
                  ],
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppConstant.appColor,
            ),
          );
        },
      ),
    );
  }
}
