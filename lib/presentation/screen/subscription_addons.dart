import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/constants/app_constants.dart';

import '../../model/login.dart';
import '../../model/package_details_model/package_detail.dart';
import '../../utils/Utils.dart';

class SubscriptionAddOn extends StatefulWidget {
  final List<Menu> data;
  final String weeklyPackageId;
  final String? packageId;

  const SubscriptionAddOn(
      {required this.data,
      required this.weeklyPackageId,
      required this.packageId,
      Key? key})
      : super(key: key);

  @override
  State<SubscriptionAddOn> createState() => _SubscriptionAddOnState();
}

class _SubscriptionAddOnState extends State<SubscriptionAddOn> {
  List<int> sums = [];
  double extraAmount = 0;

  //Map<String, Menuitem> menuItems = Map();
  List<Menuitem> menuItems = [];
  bool isChanged = false;
  var sum = 0;
  var givenList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: AppConstant.appColor,
        title: const Text(
          "Customize your menu",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Select From Below Option",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppConstant.fontBold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(12),
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            height: 100,
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return getCategory1(widget.data[index], () {
                  setState(() {
                    widget.data[index].menuitems.removeAt(index);
                  });
                });
              },
              itemCount: widget.data.length,
            ),
          ),
          widget.data.isEmpty
              ? const Center(
                  child: Text(
                    "No  Detail",
                    style: TextStyle(fontFamily: AppConstant.fontRegular),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return getCategory(widget.data[index]);
                  },
                  itemCount: widget.data.length,
                ),
          GestureDetector(
            onTap: () {
              var encodedString = encodeMenuItemsToJsonString(widget.data);
              if (encodedString.isNotEmpty) {
                addCustomizePackageItemApi(
                    encodedString, widget.weeklyPackageId);
              } else {
                Utils.showToast("Select menu to customize");
              }
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.only(
                  bottom: 6, right: 16, left: 16, top: 26),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppConstant.fontRegular,
                      fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void addCustomizePackageItemApi(
      String menuItems, String? weeklyPackageId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    FormData from = FormData.fromMap({
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "package_id": widget.packageId,
      "weekly_package_id": weeklyPackageId,
      /*"menu_id":"124",
        "qty":"5",Ca
        "itemprice":"30"*/
      "menu_items": menuItems
    });
  }

  getCategory(Menu data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            data.category,
            style:
                const TextStyle(fontSize: 15, fontFamily: AppConstant.fontBold),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return getPackageItems(data.menuitems[index], index);
          },
          itemCount: data.menuitems.length,
        )
      ],
    );
  }

  getCategory1(Menu data, Function onRemoveClicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 70,
            child: ListView.separated(
              padding: const EdgeInsets.only(right: 12),
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return packageItems(data.menuitems[index], onRemoveClicked);
              },
              itemCount: data.menuitems.length,
            ))
      ],
    );
  }

  getPackageItems(Menuitem data, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
              activeColor: const Color(0xff7EDABF),
              onChanged: (value) {
                setState(() {
                  data.isChecked = value;
                  if (value!) {
                    data.qtytoincrease = 1;

                    data.itemQty++;
                  } else {
                    data.itemQty = data.itemQty - data.qtytoincrease;
                    data.qtytoincrease = 0;
                  }
                });
              },
              value: data.isChecked),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              data.itemName,
              style: const TextStyle(fontFamily: AppConstant.fontRegular),
            ),
          ),
          const Spacer(),
          Text(AppConstant.rupee + data.itemPrice),
          const SizedBox(
            width: 12,
          ),
          data.qtytoincrease > 0
              ? Container(
                  height: 35,
                  width: 90,
                  decoration: const BoxDecoration(
                    color: AppConstant.appColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (data.qtytoincrease > 1) {
                              data.qtytoincrease -= 1;
                              data.itemQty--;
                              sums[index] = (int.parse(data.itemPrice) *
                                  data.qtytoincrease);
                            } else {
                              setState(() {
                                data.isChecked = false;
                                data.itemQty =
                                    data.itemQty - data.qtytoincrease;
                                data.qtytoincrease = 0;
                              });
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 20,
                          child: const Text(
                            "-",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: AppConstant.fontRegular),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        data.qtytoincrease.toString(),
                        style: const TextStyle(
                            fontFamily: AppConstant.fontRegular,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            data.qtytoincrease += 1;

                            data.itemQty++;
                            sums[index] = (int.parse(data.itemPrice) *
                                data.qtytoincrease);
                            int temp = 0;
                            for (var element in sums) {
                              temp += element;
                              givenList = (int.parse(data.itemPrice) *
                                  data.qtytoincrease);
                              totalAmount(data);
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 20,
                          child: const Text(
                            "+",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppConstant.fontRegular,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            width: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
                "${AppConstant.rupee}${int.parse(data.itemPrice) * data.qtytoincrease} Extra"),
          ),
        ],
      ),
    );
  }

  void totalAmount(Menuitem data) {
    for (var i = 0; i < givenList; i++) {
      sum += int.parse(givenList[i]);
    }
  }

  packageItems(Menuitem data, Function onRemoveClicked) {
    return Container(
        color: const Color(0xFFF6F6F6),
        child: Row(children: [
          Text(
            data.itemName,
            style: const TextStyle(fontFamily: AppConstant.fontRegular),
          ),
          IconButton(
              onPressed: () {
                onRemoveClicked();
                data.itemName;
              },
              icon: const Icon(Icons.cancel_outlined)),
        ]));
  }

  String encodeMenuItemsToJsonString(List<Menu> data) {
    List<Map<String, String?>> listOfMenuItems = [];

    for (var element in data) {
      for (var menu in element.menuitems) {
        if (menu.isChecked!) {
          var map = {
            "menu_id": menu.itemId,
            "itemname": menu.itemName,
            "itemprice": menu.itemPrice,
            "quantity": menu.qtytoincrease.toString(),
          };
          listOfMenuItems.add(map);
        }
      }
    }
    return listOfMenuItems.isNotEmpty ? json.encode(listOfMenuItems) : "";
  }
}
