import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/main.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/orders/fav_orders_class.dart';
import '../../../network/orders_repo/fav_orders_model.dart';
import '../../../utils/constants/ui_constants.dart';
import '../kitchen_details/kitchen_details_screen.dart';
import '../landing/landing_screen.dart';

class FavOrderScreen extends StatefulWidget {
  const FavOrderScreen({Key? key}) : super(key: key);

  @override
  _FavOrderScreenState createState() => _FavOrderScreenState();
}

class _FavOrderScreenState extends State<FavOrderScreen> {
  var like = false;
  var disLike = true;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favModel = Provider.of<FavOrdersModel>(context, listen: false);
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body:
          /*Consumer<FavOrdersModel>(builder: (context, favOrderModel, child) {
      return*/
          FutureBuilder<FavOrdersClass?>(
              future: favModel.getFavOrders(),
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
                  if (!snapshot.data!.status!) {
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
                              txt: 'No favorite Orders',
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
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 12, bottom: 0),
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
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white),
                                  margin: const EdgeInsets.only(
                                      right: 12, top: 12, left: 12, bottom: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print(
                                                  "============initialIndex>${snapshot.data!.data![index]!.orderType == "package" ? 0 : 1}");
                                              print(
                                                  "============>${snapshot.data!.data![index]!.kitchenId!}");
                                              print(
                                                  "============>${snapshot.data!.data![index]!.orderType == "trial" ? OrderCategory.OrderNow.toJsonKey() : OrderCategory.Subscription.toJsonKey()}");
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                    opaque: false,
                                                    pageBuilder:
                                                        (BuildContext context,
                                                            _, __) {
                                                      print(snapshot
                                                          .data!
                                                          .data![index]!
                                                          .orderType);
                                                      return KitchenDetailsScreen(
                                                        initialIndex: snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]!
                                                                    .orderType ==
                                                                "package"
                                                            ? 0
                                                            : 1,
                                                        snapshot
                                                            .data!
                                                            .data![index]!
                                                            .kitchenId!,
                                                        snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]!
                                                                    .orderType ==
                                                                "trial"
                                                            ? OrderCategory
                                                                    .OrderNow
                                                                .toJsonKey()
                                                            : OrderCategory
                                                                    .Subscription
                                                                .toJsonKey(),
                                                      );
                                                    }),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 17,
                                                  backgroundImage: NetworkImage(
                                                      snapshot
                                                          .data!
                                                          .data![index]!
                                                          .profile_pic!),
                                                ),
                                                Text(
                                                  '   ${snapshot.data!.data![index]!.kitchenName}',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          AppConstant.fontBold),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                      opaque: false,
                                                      pageBuilder:
                                                          (BuildContext context,
                                                              _, __) {
                                                        print(snapshot
                                                            .data!
                                                            .data![index]!
                                                            .orderType);
                                                        return KitchenDetailsScreen(
                                                          initialIndex: snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .orderType ==
                                                                  "package"
                                                              ? 0
                                                              : 1,
                                                          snapshot
                                                              .data!
                                                              .data![index]!
                                                              .kitchenId!,
                                                          snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]!
                                                                      .orderType ==
                                                                  "trial"
                                                              ? OrderCategory
                                                                      .OrderNow
                                                                  .toJsonKey()
                                                              : OrderCategory
                                                                      .Subscription
                                                                  .toJsonKey(),
                                                        );
                                                      }),
                                                );
                                              },
                                              style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24))),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          AppConstant
                                                              .appColor)),
                                              child: const Text(
                                                "Repeat Order",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        "Price ${AppConstant.rupee} ${snapshot.data!.data![index]!.netAmount}",
                                        style: const TextStyle(
                                            fontFamily:
                                                AppConstant.fontRegular),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        dateTimeFormat(
                                            snapshot
                                                .data!.data![index]!.orderDate
                                                .toString(),
                                            "E, dd MMM, yyyy"),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontFamily: AppConstant.fontBold),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      snapshot.data!.data![index]!.orderType ==
                                              "package"
                                          ? Text(
                                              "Package:  ${snapshot.data!.data![index]!.packageDetail![0]!.itemName}",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            )
                                          : Text(
                                              "${snapshot.data!.data![index]!.trialOrders![0]!.itemName}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      AppConstant.fontRegular,
                                                  fontSize: 12),
                                            ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.data![index]!.orderId
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily:
                                                    AppConstant.fontRegular,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            " | Order From ${dateTimeFormat(snapshot.data!.data![index]!.orderDate.toString(), "E, dd MMM, yyyy")}",
                                            style: const TextStyle(
                                                fontFamily:
                                                    AppConstant.fontRegular),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 250,
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
              }),
    );
  }
}
