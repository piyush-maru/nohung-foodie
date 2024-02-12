import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/customWidgets/image_error.dart';
import 'package:food_app/utils/Dimens.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:food_app/utils/size_config.dart';
import 'package:provider/provider.dart';

import '../../../model/fav_kitchen_classes/get_fav_kitchen.dart';
import '../../../network/fav_kitchen_repo/fav_kitchen_model.dart';
import '../kitchen_details/kitchen_details_screen.dart';
import '../landing/landing_screen.dart';

class FavKitchen extends StatefulWidget {
  const FavKitchen({Key? key}) : super(key: key);

  @override
  State<FavKitchen> createState() => _FavKitchenState();
}

class _FavKitchenState extends State<FavKitchen> {
  Future<GetFavKitchen>? future;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final kitchenModel = Provider.of<FavKitchenModel>(context, listen: false);
    future = kitchenModel.getFavKitchen();
  }

  bool isLike = false;
  var isFav = false;
  List<String> dataList = [];
  List<String> firstThreeData = [];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final kitchenModel = Provider.of<FavKitchenModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset("assets/images/white_backButton.png",
                    height: 23)),
            const SizedBox(width: 8),
            poppinsText(
                txt: "Favourite Kitchen",
                maxLines: 3,
                fontSize: 16,
                textAlign: TextAlign.center,
                weight: FontWeight.w500),
          ],
        ),
        backgroundColor: const Color(0xffffb300),
        elevation: 0,
      ),
      backgroundColor: AppConstant.appColor,
      body: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<GetFavKitchen>(
              future: kitchenModel.getFavKitchen(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null
                    ? snapshot.data!.data.isEmpty
                        ? SizedBox(
                            width: screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 70,
                                ),
                                Image.asset(
                                  'assets/images/image_no_fav_kitchen.png',
                                  width: screenWidth * 0.7,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                poppinsText(
                                    txt: 'There are no favorite kitchens',
                                    fontSize: 20,
                                    maxLines: 2,
                                    weight: FontWeight.w500),
                                SizedBox(
                                  height: 20,
                                ),
                                InkResponse(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LandingScreen(),
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
                                      shadows: [
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
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.only(top: 8, bottom: 12),
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.data.length,
                                itemBuilder: (context, index) {
                                  dataList = snapshot.data!.data[index].foodType
                                      .toString()
                                      .split(',');
                                  firstThreeData = dataList.take(3).toList();
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  KitchenDetailsScreen(
                                                      snapshot
                                                          .data!.data[index].id
                                                          .toString(),
                                                      OrderCategory.Subscription
                                                          .toJsonKey())));
                                    },
                                    child:
                                        snapshot.data!.data[index]
                                                    .kitchenName ==
                                                null
                                            ? Container()
                                            : Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => KitchenDetailsScreen(
                                                                  snapshot
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  OrderCategory
                                                                          .Subscription
                                                                      .toJsonKey()),
                                                            ),
                                                          );
                                                        },
                                                        child: Card(
                                                          elevation: 8,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              16.0),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              16.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              16.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              16.0),
                                                                    ),
                                                                    color: Colors
                                                                        .white),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10.0),
                                                                  ),
                                                                  child:
                                                                      SizedBox(
                                                                    height: SizeConfig
                                                                            .defaultSize! *
                                                                        Dimens
                                                                            .size16,
                                                                    width: SizeConfig
                                                                            .defaultSize! *
                                                                        Dimens
                                                                            .size40,
                                                                    child: Image
                                                                        .network(
                                                                      snapshot
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .profilePic
                                                                          .toString(),
                                                                      errorBuilder: (BuildContext,
                                                                          Object,
                                                                          StackTrace) {
                                                                        return const ImageErrorWidget();
                                                                      },
                                                                      width:
                                                                          340,
                                                                      height:
                                                                          60.0,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: SizeConfig
                                                                            .defaultSize! *
                                                                        Dimens
                                                                            .size2,
                                                                    bottom: 8,
                                                                    left: SizeConfig
                                                                            .defaultSize! *
                                                                        Dimens
                                                                            .size2,
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            snapshot.data!.data[index].kitchenName.toString(),
                                                                            style: const TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 20,
                                                                                fontFamily: AppConstant.fontBold),
                                                                          ),
                                                                          Visibility(
                                                                            visible: snapshot.data!.data[index].ratingSystem == "0.0"
                                                                                ? false
                                                                                : true,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(right: 20.0, top: 4),
                                                                              child: Row(children: [
                                                                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                                                                Text(
                                                                                  snapshot.data!.data[index].ratingSystem.toString(),
                                                                                  style: const TextStyle(color: Colors.black, fontFamily: AppConstant.fontRegular, fontSize: 15, fontWeight: FontWeight.w400),
                                                                                ),
                                                                              ]),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              const SizedBox(height: 8),
                                                                              Row(
                                                                                children: [
                                                                                  SvgPicture.asset('assets/images/timings.svg', height: 18),
                                                                                  const SizedBox(width: 4),
                                                                                  Text(
                                                                                    snapshot.data!.data[index].timing.toString(),
                                                                                    style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: AppConstant.fontRegular, fontSize: 14, fontWeight: FontWeight.w400),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const SizedBox(height: 8),
                                                                              Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  SvgPicture.asset(
                                                                                    'assets/images/type_of_meal.svg',
                                                                                    height: 18,
                                                                                  ),
                                                                                  const SizedBox(width: 4),
                                                                                  SizedBox(
                                                                                    width: 200,
                                                                                    //color: Colors.red,
                                                                                    child: Text(
                                                                                      // snapshot.data!.data[index].foodType.toString(),
                                                                                      firstThreeData.toString().replaceAll('[', '').replaceAll(']', ''),
                                                                                      style: TextStyle(color: Colors.black.withOpacity(0.4), fontFamily: AppConstant.fontRegular, fontSize: 14, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 12,
                                                                    bottom: 14,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          const Text(
                                                                            " Starting from ",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 17,
                                                                                fontFamily: AppConstant.fontBold),
                                                                          ),
                                                                          Text(
                                                                            "₹${snapshot.data!.data[index].startingPrice}/-",
                                                                            style: const TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 17,
                                                                                fontFamily: AppConstant.fontBold),
                                                                          ),
                                                                          const Text(
                                                                            "meal",
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 17,
                                                                                fontFamily: AppConstant.fontBold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  /* Container(
                                            height: 300,
                                            margin: const EdgeInsets.all(12),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.75,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
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
                                                color: Colors.white),
                                            child: */ /*Stack(children: [*/ /*
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) => KitchenDetailsScreen(
                                                                    snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    OrderCategory
                                                                            .Subscription
                                                                        .toJsonKey())));
                                                      },
                                                      child: Image.network(
                                                        snapshot
                                                            .data!
                                                            .data[index]
                                                            .profilePic
                                                            .toString(),
                                                        height: 100,
                                                        width: double.infinity,
                                                        fit: BoxFit.fill,
                                                      )),
                                                  const Divider(
                                                    color: Colors.black,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${snapshot.data!.data[index].kitchenName}",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                AppConstant
                                                                    .fontBold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const Spacer(),
                                                      const Icon(Icons.star),
                                                      const SizedBox(
                                                        width: 6,
                                                      ),
                                                      Text(
                                                        "${snapshot.data!.data[index].ratingSystem}",
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                AppConstant
                                                                    .fontBold),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/store-timings.svg",
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Text(
                                                        snapshot.data!
                                                            .data[index].timing
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                AppConstant
                                                                    .fontRegular),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/meal-menu.svg",
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Container(
                                                          constraints: BoxConstraints(
                                                              maxHeight: 100,
                                                              maxWidth: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.75),
                                                          child: Text(
                                                            "${snapshot.data!.data[index].foodType}",
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    AppConstant
                                                                        .fontRegular),
                                                          ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Starting from ${AppConstant.rupee} ${snapshot.data!.data[index].startingPrice}/- meal",
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  AppConstant
                                                                      .fontBold),
                                                        ),
                                                        IconButton(
                                                          icon: const Icon(Icons
                                                              .delete_sharp),
                                                          onPressed: () {
                                                            setState(() {
                                                              isLike == true;
                                                              kitchenModel
                                                                  .removeKitchenHttp(
                                                                      snapshot
                                                                          .data!
                                                                          .data[
                                                                              index]
                                                                          .id)
                                                                  .then(
                                                                      (value) {
                                                                // ScaffoldMessenger.of(context)
                                                                //     .showSnackBar(
                                                                //   SnackBar(
                                                                //     content: Text(
                                                                //       "Removed from Fav kitchen",
                                                                //       style: TextStyle(
                                                                //           fontFamily: AppConstant
                                                                //               .fontRegular),
                                                                //     ),
                                                                //   ),
                                                                // );
                                                                kitchenModel
                                                                    .getFavKitchen();
                                                              });
                                                            });
                                                          },
                                                        ),
                                                      ]),

*/ /*
                                        InkWell(
                                          onTap: () {
                                             setState(() {
                                              isLike == true;
                                              kitchenModel
                                                  .removeKitchenHttp(
                                                      snapshot.data!.data[index].id)
                                                  .then((value) {
                                                // ScaffoldMessenger.of(context)
                                                //     .showSnackBar(
                                                //   SnackBar(
                                                //     content: Text(
                                                //       "Removed from Fav kitchen",
                                                //       style: TextStyle(
                                                //           fontFamily: AppConstant
                                                //               .fontRegular),
                                                //     ),
                                                //   ),
                                                // );
                                                kitchenModel.getFavKitchen();
                                              });
                                            });
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.09,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.81),
                                              height: 30,
                                              width: 30,
                                              padding: EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      offset: const Offset(
                                                        2.0,
                                                        2.0,
                                                      ),
                                                      blurRadius: 5.0,
                                                      spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                  color: Colors.white),
                                              alignment: Alignment.centerRight,
                                              child: isLike == false
                                                  ? SvgPicture.asset(
                                                      Res.heartFill,
                                                      color: AppConstant.appColor,
                                                      height: 20,
                                                      width: 20,
                                                    )
                                                  : SvgPicture.asset(
                                                      Res.heartOutline,
                                                      color: Colors.black,
                                                      height: 20,
                                                      width: 20,
                                                    )),
                                        )
*/ /*
                                                ]),
                                          ),*/
                                                ],
                                              ),
                                  );
                                }),
                          )
                    : const SizedBox(
                        height: 500,
                        child: Center(
                          child: Text(
                            "No Kitchens",
                            style: TextStyle(
                                fontFamily: AppConstant.fontRegular,
                                fontSize: 20),
                          ),
                        ),
                      );
              }),
        ),
      ),
    );
  }
}
