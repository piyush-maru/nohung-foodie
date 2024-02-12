import 'package:flutter/material.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return getOrderList();
                },
                itemCount: 10,
              ),
            ),
          ],
        ));
  }

  Widget getOrderList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: Image.asset(
                Res.people,
                width: 60,
                height: 60,
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Kunal Shah",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16, top: 6),
                            child: Text(
                              "1234 | From MArch 1st.2021 ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16, top: 10),
                            child: Text(
                              "Customized ",
                              style: TextStyle(
                                  color: AppConstant.appColor,
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontBold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16, top: 10),
                            child: Text(
                              "Lunch Menu ",
                              style: TextStyle(
                                  color: Color(0xffA7A8BC),
                                  fontSize: 14,
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Image.asset(
                                  Res.breakfast,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Paneer Sabji+Roti",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16, top: 10),
                                child: Image.asset(
                                  Res.loc,
                                  width: 20,
                                  height: 20,
                                  color: AppConstant.lightGreen,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5, top: 10),
                                child: Text(
                                  "H.no 43223 Height ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 16, bottom: 10),
                                  height: 45,
                                  width: 190,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 13),
                                        child: Text(
                                          "Order in Preparation",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: AppConstant.fontBold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Image.asset(
                                          Res.whiteArrow,
                                          width: 16,
                                          height: 16,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 1, top: 16, right: 20),
                child: Image.asset(
                  Res.call,
                  width: 50,
                  height: 50,
                )),
          ],
        ),
      ],
    );
  }
}
