import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/presentation/screen/start_delivery_screen.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../model/Profile/get_profile.dart';
import '../../network/profile_repo.dart';

class OrderDispatchedScreen extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String formattedAddress;

  const OrderDispatchedScreen(
      this.latitude, this.longitude, this.formattedAddress,
      {Key? key})
      : super(key: key);

  @override
  OrderDispatchedScreenState createState() => OrderDispatchedScreenState();
}

class OrderDispatchedScreenState extends State<OrderDispatchedScreen> {
  String? username = "";
  String? email = "";
  String? kitchenName = "";
  String? foodType = "";
  String? orderId = "";
  String? address = "";
  String? timing = "";
  String? openStatus = "";
  String? totalReview = "";
  var avgReview = "";
  late String arrivingTime;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getProfile(context);
      // kitchenDetail(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstant.appColor,
        // bottomNavigationBar: Bottom(selectedIndex: 1),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, right: 16),
                alignment: Alignment.topRight,
                child: Image.asset(
                  Res.close,
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              ),
              Center(
                child: CircularPercentIndicator(
                  radius: 180.0,
                  animation: true,
                  animationDuration: 1200,
                  lineWidth: 8.0,
                  percent: 0.8,
                  center: Container(
                    width: 155,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(14)),
                    height: 155,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Stack(
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            child: Stack(
                              children: [
                                Image.asset(
                                  Res.deliveryBoy,
                                  width: 150,
                                  height: 150,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 50, top: 16),
                                  child: Text(
                                    arrivingTime,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: const Color(0xffFCC647),
                  progressColor: const Color(0xff7EDABF),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Order Dispatched",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AppConstant.fontBold),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Image.asset(
                      Res.downArrow,
                      width: 25,
                      height: 25,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Center(
                  child: Text(
                "Expecting a slight delay in finding valet due to high\norder volumes",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: AppConstant.fontBold),
              )),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StartDeliveryScreen()));
                },
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          Image.asset(
                            Res.boy,
                            width: 50,
                            height: 50,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 6),
                                  child: Text(
                                    username!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: AppConstant.fontBold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 4),
                                  child: Text(
                                    email!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: AppConstant.fontBold),
                                  ),
                                ),
                                const Divider(
                                  color: Color(0xffA7A8BC),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image.asset(
                              Res.call,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "John can speak hindi & english He is from nagpur",
                          style:
                              TextStyle(color: Color(0xffA7A8BC), fontSize: 12),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Image.asset(
                              Res.check,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10, top: 6),
                            child: Text(
                              "Thank you for the tip john!",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 16, top: 6),
                        child: Text(
                          "${AppConstant.rupee}20 will be transferred to him at end of the week",
                          style:
                              TextStyle(color: Color(0xffA7A8BC), fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 6,
                            ),
                            Image.asset(
                              Res.kitchen,
                              width: 50,
                              height: 50,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 16, top: 6),
                                    child: Text(
                                      kitchenName!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 16, top: 4),
                                    child: Text(
                                      timing!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: AppConstant.fontBold),
                                    ),
                                  ),
                                  const Divider(
                                    color: Color(0xffA7A8BC),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Image.asset(
                                Res.call,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                "Today's Lunch Menu",
                                style: TextStyle(
                                    color: Color(0xffA7A8BC), fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Text(
                                "Customized",
                                style: TextStyle(
                                    color: AppConstant.appColor,
                                    fontSize: 12,
                                    fontFamily: AppConstant.fontBold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Image.asset(
                                  Res.breakfast,
                                  width: 20,
                                  height: 20,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 6),
                              child: Text(
                                foodType!,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Color(0xffA7A8BC),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 10),
                          child: Text(
                            username!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, bottom: 16, top: 10),
                                child: Image.asset(
                                  Res.location,
                                  width: 20,
                                  height: 20,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 10, bottom: 16),
                              child: Text(
                                address!,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 16),
                                child: Text(
                                  "Have an issue with your order",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 6),
                                child: Text(
                                  "Chat with us",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            ],
                          )),
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: 16, bottom: 16, top: 10),
                              child: Image.asset(
                                Res.orderIssue,
                                width: 40,
                                height: 40,
                              )),
                        ],
                      ),
                    ],
                  )),
              Container(
                  width: double.infinity,
                  color: Colors.white,
                  margin: const EdgeInsets.only(
                      top: 20, right: 16, left: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 16),
                        child: Text(
                          "Enjoy the NoHung app?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 5, bottom: 6),
                        child: Text(
                          "Spread the word by rating us on play store.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: AppConstant.fontRegular),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 40,
                              width: 100,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF3F6FA),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  "Not Now",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 100,
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              decoration: BoxDecoration(
                                  color: AppConstant.appColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  "Rating NoHung",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ));
  }

  Future<GetProfile?> getProfile(BuildContext context) async {
    final profileModel = Provider.of<ProfileModel>(context, listen: false);

    GetProfile? bean = await profileModel.getProfile();

    if (bean?.status == true) {
      setState(() {
        username = bean!.data[0].username;
        email = bean.data[0].email;
      });
      return bean;
    } else {
      Utils.showToast(bean!.message);
    }

    return null;
  }
}
