import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../network/check_out/checkout_model.dart';
import '../../../network/customization_details/customization_details_controller.dart';

class CustomizationScreen extends StatefulWidget {
  final String packageId;
  final String weeklyPackageId;
  final String packageName;
  final String cuisineType;
  final String price;
  final String customization;

  const CustomizationScreen({
    Key? key,
    required this.packageId,
    required this.weeklyPackageId,
    required this.packageName,
    required this.cuisineType,
    required this.price,
    required this.customization,
  }) : super(key: key);

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomizationDetailsController>(context, listen: false)
          .getPackageCustomizableItemHttp(
              widget.packageId, widget.weeklyPackageId)
          .then((value) async {
        await Provider.of<CustomizationDetailsController>(context,
                listen: false)
            .updateItem();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var checkOutController = Provider.of<CheckOutModel>(context, listen: false);

    return WillPopScope(
      onWillPop: () {
        Provider.of<CustomizationDetailsController>(context, listen: false)
            .clear();
        Navigator.of(context).pop();
        return false as Future<bool>;
      },
      child: Scaffold(
        body: SafeArea(
                  child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<CustomizationDetailsController>(
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/images/leaf.svg',
                                      width: 18),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.packageName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: AppConstant.fontRegular,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  value.clear();
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 28),
                            child: Text(
                              '₹ ${widget.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: AppConstant.fontRegular,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 28),
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 400,
                                maxHeight: 100,
                              ),
                              child: Text(
                                widget.cuisineType,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 28),
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 400,
                                maxHeight: 100,
                              ),
                              child: Text(
                                widget.customization == 'y'
                                    ? 'Customization Available'
                                    : '',
                                style: const TextStyle(
                                  color: AppConstant.appColor,
                                  fontFamily: AppConstant.fontBold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                            child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 3 / 1,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                children: List.generate(
                                  value.menuItems2.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: AppConstant.appColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              value.menuItems2[index].itemName
                                                          .length <
                                                      15
                                                  ? value.menuItems2[index]
                                                      .itemName
                                                  : value.menuItems2[index]
                                                      .itemName
                                                      .substring(0, 15)
                                                      .trim(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Icon(
                                                        Icons.info_outline,
                                                        color: Colors
                                                            .deepOrangeAccent,
                                                      ),
                                                      content: const Text(
                                                        "Are you sure you want to delete this item ?",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                AppConstant
                                                                    .fontRegular),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          child: const Text(
                                                            "No",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    AppConstant
                                                                        .fontRegular),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: const Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    AppConstant
                                                                        .fontRegular),
                                                          ),
                                                          onPressed: () {
                                                            value.remove(value
                                                                    .menuItems2[
                                                                index]);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child:
                                                  const Icon(Icons.close, size: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          ScrollbarTheme(
                            data: ScrollbarThemeData(
                              trackBorderColor: MaterialStateProperty.all(
                                Colors.grey,
                              ),
                              interactive: true,
                              thumbVisibility: MaterialStateProperty.all(true),
                              radius: const Radius.circular(10.0),
                              thumbColor: MaterialStateProperty.all(
                                AppConstant.appColor,
                              ),
                              thickness: MaterialStateProperty.all(5.0),
                              minThumbLength: 800,
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight:
                                    MediaQuery.of(context).size.height / 1.9,
                              ),
                              child: Scrollbar(
                                thumbVisibility: true,
                                controller: _scrollController,
                                interactive: true,
                                thickness: 10.0,
                                radius: const Radius.circular(20.0),
                                child: ListView.builder(
                                    controller: _scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: value.customizationData.length,
                                    itemBuilder: (context, i) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      value.customizationData[i]
                                                          .category,
                                                      style: const TextStyle(
                                                        fontFamily: AppConstant
                                                            .fontBold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: value
                                                      .customizationData[i]
                                                      .menuitems
                                                      .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                                    maxHeight:
                                                                        100,
                                                                    maxWidth:
                                                                        200),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  value
                                                                      .customizationData[
                                                                          i]
                                                                      .menuitems[
                                                                          index]
                                                                      .itemName,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        AppConstant
                                                                            .fontRegular,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '₹${value
                                                                          .customizationData[
                                                                              i]
                                                                          .menuitems[
                                                                              index]
                                                                          .itemPrice}',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        16,
                                                                    fontFamily:
                                                                        AppConstant
                                                                            .fontRegular,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                              maxHeight: 40,
                                                              maxWidth: 80,
                                                            ),
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.black,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    value.decrease(
                                                                            i,
                                                                            index);
                                                                  },
                                                                  child: const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                Consumer<
                                                                    CustomizationDetailsController>(
                                                                  builder:
                                                                      (context,
                                                                          u,
                                                                          child) {
                                                                    return Text(
                                                                      u.customizationData[i].menuitems[index].qty.toString(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    value.increase(
                                                                            i,
                                                                            index);
                                                                  },
                                                                  child: const Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                  minHeight: 40,
                                ),
                                child: const Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        '₹ 3500',
                                        style: TextStyle(
                                          color: AppConstant.appColor,
                                          fontFamily: AppConstant.fontBold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Order For',
                                      style: TextStyle(
                                        fontFamily: AppConstant.fontBold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'For 7 Days',
                                      style: TextStyle(
                                        fontFamily: AppConstant.fontBold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 8.0, right: 8.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async{

                                    value.addCustomizedPackageItemHttp(
                                      widget.packageId,
                                      widget.weeklyPackageId,
                                      value.menuItems2,
                                    ).then((v)async{
                                      value.clear();
                                      checkOutController.customizedPackageDetailHttp(widget.packageId, );

                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppConstant.appColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    constraints: BoxConstraints(
                                      maxHeight: 40,
                                      minWidth:
                                          MediaQuery.of(context).size.width /
                                              4.0,
                                    ),
                                    child: Center(
                                      child: value.isLoading == true
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text(
                                              'Save',
                                              style: TextStyle(
                                                fontFamily:
                                                    AppConstant.fontBold,
                                                fontSize: 16,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ))
      ),
    );
  }
}
