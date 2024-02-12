import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/constants/ui_constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> day = ["Today", "Yesterday", "12 Sep 2023", "11 Sep 2023"];
  List<String> nitify = [
    "Subscription Order Accepted.",
    "Subscription Order Accepted.",
    "Subscription Order Accepted."
  ];
  bool isNotification = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 166,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset("assets/images/backyellowbutton.png",
                    height: 28)),
            poppinsText(
                txt: "Notifications",
                maxLines: 3,
                fontSize: 18,
                textAlign: TextAlign.center,
                weight: FontWeight.w600),
          ],
        ),
      ),
      body: isNotification
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/notification_mpty.png",
                height: 213, width: 213),
            const SizedBox(height: 18),
            poppinsText(
                txt: "No Notifications Yet",
                maxLines: 3,
                fontSize: 26,
                textAlign: TextAlign.center,
                weight: FontWeight.w600),
            const SizedBox(height: 6),
            poppinsText(
                txt: "Watch this area for updates, offers and more",
                maxLines: 3,
                fontSize: 13,
                textAlign: TextAlign.center,
                weight: FontWeight.w400),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.only(
            top: 8, left: 10, bottom: 14, right: 14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: day.length,
                itemBuilder: (context, index1) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index1 < 0) SizedBox(height: 8),
                      poppinsText(
                          txt: day[index1],
                          maxLines: 3,
                          fontSize: 16,
                          textAlign: TextAlign.center,
                          weight: FontWeight.w500),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: nitify.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(50),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/images/notification_profile.svg',
                                            width: 50,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        poppinsText(
                                            txt: /*"  Subscription Order Accepted."*/
                                            nitify[index],
                                            maxLines: 3,
                                            fontSize: 13,
                                            textAlign: TextAlign.center,
                                            weight: FontWeight.w400),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/icons_clock.svg',
                                          width: 10,
                                          fit: BoxFit.contain,
                                        ),
                                        poppinsText(
                                            txt: " 01:30 pm",
                                            maxLines: 3,
                                            fontSize: 8,
                                            textAlign: TextAlign.center,
                                            weight: FontWeight.w400),
                                      ],
                                    ),
                                  ]),
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 2.0, top: 8, bottom: 8),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 2,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      )
    );
  }
}
