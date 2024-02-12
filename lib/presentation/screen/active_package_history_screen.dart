import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app/model/active_package_history.dart';
import 'package:food_app/res.dart';
import 'package:food_app/utils/constants/app_constants.dart';

class ActivePackageHistoryScreen extends StatefulWidget {
  final String orderId;
  final String kitchenName;
  final String address;

  const ActivePackageHistoryScreen(this.orderId, this.kitchenName, this.address,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ActivePackageHistoryScreenState();
}

class ActivePackageHistoryScreenState
    extends State<ActivePackageHistoryScreen> {
  var mealFor = "";
  String? cuisineType = "";
  var mealType = "";
  List<DayList>? dayList;
  final _listItems = List.generate(200, (i) => "Item $i");

  // Used to generate random integers
  final _random = Random();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      packageHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          widget.kitchenName,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 16),
                        child: Text(
                          widget.address,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Lunch",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset(
                      Res.veg,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      "Veg",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      cuisineType!.isEmpty ? "South Indian" : cuisineType!,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
              ),
              dayList == null
                  ? const Center(
                      child: Text("No History Available"),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return getPackage(dayList![index]);
                      },
                      itemCount: dayList!.length,
                    )
            ],
          ),
        )));
  }

  Future<BeanActivePackageHistory?> packageHistory() async {
    return null;
  }

  Widget getPackage(DayList dayList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                dayList.day!,
                style:
                    const TextStyle(color: AppConstant.appColor, fontSize: 14),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 16, top: 8),
                child: Text(
                  dayList.time!,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  dayList.menuItem!,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
            Container(
                height: 40,
                width: 100,
                margin: const EdgeInsets.only(right: 16, top: 16),
                color:
                    Colors.primaries[_random.nextInt(Colors.primaries.length)]
                        [_random.nextInt(9) * 100],
                child: Center(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(
                        dayList.status!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
