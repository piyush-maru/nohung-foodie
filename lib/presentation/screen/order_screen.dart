import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var isSelected = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      bottomsheet(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 70,
          child: const Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    "Orders History",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getItem();
                      },
                      itemCount: 4,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget getItem() {
    return InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Kitchen Name",
                        style: TextStyle(
                            fontFamily: AppConstant.fontBold,
                            color: Colors.black),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 16, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xff7EDABF)),
                  width: 60,
                  height: 30,
                  child: Center(
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        "Active",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  "1234 |Order From 12 -20 Apr,2021",
                  style: TextStyle(
                      fontFamily: AppConstant.fontRegular,
                      color: Color(0xffA7A8BC)),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Text(
                    "Weekly Lunch",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: RatingBarIndicator(
                    rating: 4,
                    itemCount: 5,
                    itemSize: 15.0,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10, bottom: 16),
                  child: Text(
                    "Total Bill: ₹310",
                    style: TextStyle(
                        color: Color(0xff7EDABF),
                        fontSize: 15,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16, top: 10, bottom: 16),
                  child: Text(
                    "Repeat Order",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: AppConstant.fontRegular),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  void bottomsheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "History of order no",
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: AppConstant.fontBold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Image.asset(
                              Res.icCross,
                              width: 16,
                              height: 16,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return getHistory();
                        },
                        itemCount: 10,
                      ),
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }

  getHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              Res.idli,
              width: 50,
              height: 50,
            ),
            const Column(
              children: [
                Text(
                  "Poha",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: AppConstant.fontBold),
                ),
                Text(
                  "13 Feb",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: AppConstant.fontBold),
                ),
              ],
            ),
            const Text(
              "Deliverd at 7:35 pm",
              style: TextStyle(
                  color: AppConstant.lightGreen,
                  fontSize: 16,
                  fontFamily: AppConstant.fontBold),
            )
          ],
        )
      ],
    );
  }
}
