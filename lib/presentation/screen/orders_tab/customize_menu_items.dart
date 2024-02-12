import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/get_order_customisation_details.dart';
import 'package:food_app/network/orders_repo/get_order_customization_details_model.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

class CustomizeMenuItems extends StatefulWidget {
  final String packageId;
  final String day;
  final String orderItemId;
  final String customizeDate;

  const CustomizeMenuItems({super.key, 
    required this.packageId,
    required this.day,
    required this.orderItemId,
    required this.customizeDate,
  });

  @override
  State<CustomizeMenuItems> createState() => _CustomizeMenuItemsState();
}

class _CustomizeMenuItemsState extends State<CustomizeMenuItems> {
  double sum = 0;
  double extraAmount = 0;
  bool isChanged = false;
  Future<GetOrderCustomizeDetails>? futureList;

  @override
  void initState() {
    super.initState();
    final customModel =
        Provider.of<GetOrderCustomizationDetailsModel>(context, listen: false);
    futureList = customModel.getOrderCustomizeDetails(
        widget.packageId, widget.orderItemId, widget.day);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            isChanged
                ? showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: const Text("Are you sure!"),
                      content: const Text(
                          "You have Unsaved Changes on this Page. Do you want to leave This page and discard your changes or Stay on this Page?"),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text("NO"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            //Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  )
                : Navigator.pop(context);
          },
        ),
        title: const Text(
          "Menu Customization",
          style: TextStyle(
              fontFamily: AppConstant.fontRegular,
              fontSize: 16,
              color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: AppConstant.appColor,
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
        child: SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              widget.day,
              style:
                  const TextStyle(fontSize: 20, fontFamily: AppConstant.fontRegular),
            ),
            Text(
              widget.customizeDate,
              style:
                  const TextStyle(fontSize: 16, fontFamily: AppConstant.fontRegular),
            )
          ]),
          FutureBuilder<GetOrderCustomizeDetails>(
              future: futureList,
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null
                    ? snapshot.data!.data.weekPackageDetails.isEmpty &&
                            snapshot.data!.data.orderItemDetail.isEmpty
                        ? const Text("No menu found")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                  color: Colors.white,
                                  height: 100,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot
                                        .data!.data.orderItemDetail.length,
                                    itemBuilder: (context, idx) {
                                      if (int.parse(snapshot.data!.data
                                                  .orderItemDetail[0].qty) >
                                              0 ||
                                          int.parse(snapshot
                                                  .data!
                                                  .data
                                                  .weekPackageDetails[0]
                                                  .menuData[0]
                                                  .menuItems[0]
                                                  .extraQty) >
                                              0) {
                                        // snapshot.data!.data.weekPackageDetails[0]
                                        //     .menuData[0].menuItems
                                        //     .add(CustomizeMenuItem(
                                        //         id: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]!
                                        //             .menuData![0]!
                                        //             .menuItems![idx]!
                                        //             .id,
                                        //         itemName: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]!
                                        //             .menuData![0]!
                                        //             .menuItems![idx]!
                                        //             .itemName,
                                        //         qty: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]!
                                        //             .menuData![0]!
                                        //             .menuItems![idx]!
                                        //             .qty,
                                        //         itemPrice: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]!
                                        //             .menuData![0]!
                                        //             .menuItems![idx]!
                                        //             .itemPrice,
                                        //         wVariationPrice: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]!
                                        //             .menuData![0]!
                                        //             .menuItems![idx]!
                                        //             .wVariationPrice,
                                        //         defaultQty: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]!
                                        //             .menuData![0]!
                                        //             .menuItems![idx]!
                                        //             .defaultQty,
                                        //         extraQty: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]!
                                        //             .menuData![0]!
                                        //             .menuItems![idx]!
                                        //             .extraQty,
                                        //         mVariationPrice: snapshot
                                        //             .data!
                                        //             .data
                                        //             .weekPackageDetails[0]
                                        //             .menuData[0]
                                        //             .menuItems[idx]
                                        //             .wVariationPrice
                                        //         /*orderItemId: widget.orderItemId*/
                                        //         ));
                                      }
                                      return int.parse(snapshot
                                                      .data!
                                                      .data
                                                      .orderItemDetail[idx]
                                                      .qty) >
                                                  0 ||
                                              int.parse(snapshot
                                                      .data!
                                                      .data
                                                      .weekPackageDetails[0]
                                                      .menuData[0]
                                                      .menuItems[idx]
                                                      .extraQty) >
                                                  0
                                          ? Container(
                                              padding: const EdgeInsets.all(6),
                                              height: 50,
                                              color: Colors.white,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data!
                                                          .data
                                                          .orderItemDetail[idx]
                                                          .itemName,
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontFamily:
                                                              AppConstant
                                                                  .fontRegular,
                                                          color: Colors.black),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          snapshot.data!.data
                                                              .orderItemDetail
                                                              .removeAt(idx);
                                                        });

                                                        //(weekPackageDetails[index]!.menuData![0]!.menuItems![idx].toString());
                                                        //(data.itemName).remove(index);
                                                        //onRemoveClicked();
                                                        // data.itemName;
                                                      },
                                                      icon: const Icon(Icons
                                                          .cancel_outlined),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    )
                                                  ]),
                                            )
                                          : const SizedBox();
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height*0.65,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: snapshot
                                          .data!
                                          .data
                                          .weekPackageDetails[0]
                                          .menuData
                                          .length,
                                      itemBuilder: (context, idx) {
                                        return Container(
                                          padding: const EdgeInsets.only(bottom: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot
                                                    .data!
                                                    .data
                                                    .weekPackageDetails[0]
                                                    .menuData[idx]
                                                    .category
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontFamily:
                                                        AppConstant.fontBold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Container(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 24),
                                                  child: ListView.separated(
                                                      separatorBuilder:
                                                          (context, i) {
                                                        return const SizedBox(
                                                          height: 4,
                                                        );
                                                      },
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: snapshot
                                                          .data!
                                                          .data
                                                          .weekPackageDetails[0]
                                                          .menuData[idx]
                                                          .menuItems
                                                          .length,
                                                      itemBuilder:
                                                          (context, indexing) {
                                                        return Row(children: [
                                                          Text(
                                                            snapshot
                                                                .data!
                                                                .data
                                                                .weekPackageDetails[
                                                                    0]
                                                                .menuData[idx]
                                                                .menuItems[
                                                                    indexing]
                                                                .itemName
                                                                .toString(),
                                                            // weekPackageDetails[index]!
                                                            //         .menuData![0]!
                                                            //         .menuItems![idx]!
                                                            //         .itemName
                                                            //         .toString() ??
                                                            //     "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 4,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    AppConstant
                                                                        .fontRegular),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            AppConstant.rupee +
                                                                snapshot
                                                                    .data!
                                                                    .data
                                                                    .weekPackageDetails[
                                                                        0]
                                                                    .menuData[
                                                                        idx]
                                                                    .menuItems[
                                                                        indexing]
                                                                    .itemPrice,
                                                            style: const TextStyle(
                                                              fontFamily:
                                                                  AppConstant
                                                                      .fontRegular,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          int.parse(snapshot
                                                                      .data!
                                                                      .data
                                                                      .weekPackageDetails[
                                                                          0]
                                                                      .menuData[
                                                                          idx]
                                                                      .menuItems[
                                                                          indexing]
                                                                      .qty) >=
                                                                  0
                                                              ? Container(
                                                                  height: 35,
                                                                  width: 80,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: AppConstant
                                                                        .appColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                              6),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            isChanged =
                                                                                true;

                                                                            if (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty) == 0 &&
                                                                                int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].defaultQty) > 0) {
                                                                              snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].isChecked = true;

                                                                              snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty = (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty) - 1).toString();
                                                                            } else {
                                                                              if (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty) > 0) {
                                                                                extraAmount = extraAmount - int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].itemPrice);
                                                                              }
                                                                              snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].isChecked = false;
                                                                              snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty = (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty) == 0) ? "Add" : (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty) - 1).toString();
                                                                            }
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              35,
                                                                          width:
                                                                              20,
                                                                          child:
                                                                              const Text(
                                                                            "-",
                                                                            style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 20,
                                                                                fontFamily: AppConstant.fontRegular),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "${int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty) + int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty)}",
                                                                        //int.parse(data.itemQty!) > 1 ?data.itemQty! : data.itemQty.toString(),
                                                                        style: const TextStyle(
                                                                            fontFamily:
                                                                                AppConstant.fontRegular,
                                                                            color: Colors.white,
                                                                            fontSize: 20),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            if (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].defaultQty) > 0 &&
                                                                                int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty) == 0) {
                                                                              snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty = (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty) + 1).toString();
                                                                            } else {
                                                                              isChanged = true;
                                                                              snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty = (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty) + 1).toString();

                                                                              if (int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty) > 0) {
                                                                                extraAmount = extraAmount + int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].itemPrice);
                                                                              }
                                                                              sum = int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty) == 0 ? (double.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].itemPrice) * int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty)) : (double.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].itemPrice) * int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].qty) * int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty));
                                                                            }
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          height:
                                                                              35,
                                                                          width:
                                                                              28,
                                                                          child:
                                                                              const Text(
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
                                                          const SizedBox(),
                                                          int.parse(snapshot
                                                                      .data!
                                                                      .data
                                                                      .weekPackageDetails[
                                                                          0]
                                                                      .menuData[
                                                                          idx]
                                                                      .menuItems[
                                                                          indexing]
                                                                      .extraQty) >
                                                                  0
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          16),
                                                                  //child: Text(AppConstant.rupee + (int.parse(data.itemPrice!)).toString()),
                                                                  child: Text(
                                                                    "${AppConstant
                                                                            .rupee}${int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].itemPrice) *
                                                                                int.parse(snapshot.data!.data.weekPackageDetails[0].menuData[idx].menuItems[indexing].extraQty)} Extra",
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          AppConstant
                                                                              .fontRegular,
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Container(),
                                                        ]);
                                                      })),
                                            ],
                                          ),
                                        );
                                      },

                                      // weekPackageDetails[index]!
                                      //     .menuData![0]!
                                      //     .menuItems!
                                      //
                                    )),
                                ElevatedButton(
                                  onPressed: () {
                                    String list = snapshot
                                        .data!
                                        .data
                                        .weekPackageDetails[0]
                                        .menuData[0]
                                        .menuItems
                                        .where((element) =>
                                            int.parse(element.defaultQty) > 0)
                                        .join(',');
                                    Navigator.pop(context, {
                                      'dishitems': '',
                                      'menudata': snapshot
                                          .data!
                                          .data
                                          .weekPackageDetails[0]
                                          .menuData[0]
                                          .menuItems,
                                      "extraAmount": extraAmount
                                    });
                                    //Fluttertoast.showToast(msg:"Working on it");
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.black),
                                    fixedSize: MaterialStateProperty.all(
                                      const Size(400, 50),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: AppConstant.fontRegular),
                                  ),
                                )
                              ])
                    : const Text(
                        "No menu Found",
                        style: TextStyle(fontFamily: AppConstant.fontBold),
                      );
              }),
        ]),
      ),
      ),);
  }
}
