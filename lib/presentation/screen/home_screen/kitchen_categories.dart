import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/customWidgets/image_error.dart';
import 'package:food_app/customWidgets/kitchen_details_IconText.dart';
import 'package:food_app/model/home_screen_model/home_screen_model.dart';
import 'package:food_app/utils/Dimens.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../network/fav_kitchen_repo/fav_kitchen_model.dart';
import '../../../network/home_screen_repo/home_screen_api_controller.dart';
import '../../../utils/size_config.dart';
import '../kitchen_details/kitchen_details_screen.dart';

class KitchenCategories extends StatefulWidget {
  final mealFor;
  final mealFors;
  final mealTypeFilter;
  final apply;
  final cuisinesFilter;
  final mealPlanFilter;
  final min;
  final max;

  const KitchenCategories(
      {Key? key,
      this.mealFor,
      this.mealFors,
      this.mealTypeFilter,
      this.apply,
      this.cuisinesFilter,
      this.mealPlanFilter,
      this.min,
      this.max})
      : super(key: key);

  @override
  State<KitchenCategories> createState() => _KitchenCategoriesState();
}

class _KitchenCategoriesState extends State<KitchenCategories> {
  Future<HomeKitchen>? future;
  var isFav = false;

  @override
  void initState() {
    super.initState();
    var homeKitchenData =
        Provider.of<HomeScreenProvider>(context, listen: false);

    if (widget.apply == true) {
      future = homeKitchenData.getHomeScreenData(
        mealFor: "",
        cuisineType: "${widget.cuisinesFilter}",
        mealType: "${widget.mealTypeFilter}",
        mealPlan: "${widget.mealPlanFilter}",
        minPrice: "${widget.min}",
        maxPrice: "${widget.max}",
        rating: "0",
        customerLatitude: "17.4431103",
        customerLongitude: "78.3869877",
      );
    } else {
      future = homeKitchenData.getHomeScreenData(
        mealFor: "${widget.mealFor}",
        cuisineType: "",
        mealType: "",
        mealPlan: "",
        minPrice: "",
        maxPrice: "",
        rating: "",
        customerLatitude: "17.4431103",
        customerLongitude: "78.3869877",
      );
    }
  }

  List<String> dataList = [];
  List<String> MealTypes = ["All", "Breakfast", "Lunch", "Dinner"];
  List<bool> checkedItems = List<bool>.generate(3, (index) => false);
  List MealTypesIndex = [];
  List<String> firstThreeData = [];
  String isMealTypes = "both";
  int index1 = 0;

  @override
  Widget build(BuildContext context) {
    var homeKitchenData =
        Provider.of<HomeScreenProvider>(context, listen: false);
    final favKitchenModel =
        Provider.of<FavKitchenModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          leadingWidth: 40,
          leading: InkWell(onTap: () {
            Navigator.pop(context);
          },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: SvgPicture.asset('assets/images/Xback.svg',
                height: 20,width: 20,),
            ),
          ),
          title:  Text(
            "${widget.mealFors ?? "Breckfast"}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12), //8
          child: Column(
            children: [
              /*Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "${widget.mealFors ?? "Breckfast"}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),*/
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          isMealTypes = "veg";
                          future = homeKitchenData.getHomeScreenData(
                            mealFor: "${widget.mealFor}",
                            cuisineType: "",
                            mealType: "0",
                            mealPlan: "", //"2",
                            minPrice: "0",
                            maxPrice: "0",
                            rating: "0",
                            customerLatitude: "17.4431103",
                            customerLongitude: "78.3869877",
                          );

                          setState(() {});
                        },
                        child: FilterImageAndText1(
                            color: isMealTypes == "veg"
                                ? Colors.amber
                                : Colors.white,
                            image: 'assets/images/leaf.svg',
                            text: 'Veg'),
                      ),
                      InkWell(
                        onTap: () {
                          isMealTypes = "nonveg";
                          future = homeKitchenData.getHomeScreenData(
                            mealFor: "${widget.mealFor}",
                            cuisineType: "",
                            mealType: "1",
                            mealPlan: "", //0
                            minPrice: "0",
                            maxPrice: "0",
                            rating: "0",
                            customerLatitude: "17.4431103",
                            customerLongitude: "78.3869877",
                          );

                          setState(() {});
                        },
                        child: FilterImageAndText1(
                            color: isMealTypes == "nonveg"
                                ? Colors.amber
                                : Colors.white,
                            image: 'assets/images/chicken.svg',
                            text: 'Non-Veg'),
                      ),
                      InkWell(
                        onTap: () {
                          isMealTypes = "both";
                          future = homeKitchenData.getHomeScreenData(
                            mealFor: "${widget.mealFor}",
                            cuisineType: "",
                            mealType: "2",
                            mealPlan: "", //
                            minPrice: "0",
                            maxPrice: "0",
                            rating: "0",
                            customerLatitude: "17.4431103",
                            customerLongitude: "78.3869877",
                          );

                          setState(() {});
                        },
                        child: FilterImageAndText1(
                            color: isMealTypes == "both"
                                ? Colors.amber
                                : Colors.white,
                            image: 'assets/images/both.svg',
                            text: 'Veg/Non-Veg'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 7),
              FutureBuilder<HomeKitchen>(
                  future: future,
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? Expanded(
                            child: Container(
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.data.length,
                                  itemBuilder: (context, index) {
                                    dataList = snapshot
                                        .data!.data[index].cuisineType
                                        .split(',');
                                    firstThreeData = dataList.take(3).toList();
                                    return SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          // top: SizeConfig.defaultSize! *
                                          //   Dimens.size1,
                                          bottom: SizeConfig.defaultSize! *
                                              Dimens.size1,
                                          left: SizeConfig.defaultSize! *
                                              Dimens.size1,
                                          right: SizeConfig.defaultSize! *
                                              Dimens.sizePoint9,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            KitchenDetailsScreen(
                                                                snapshot
                                                                    .data!
                                                                    .data[index]
                                                                    .kitchenId,
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
                                                          BorderRadius.circular(
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
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          16.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          16.0),
                                                                  topRight: Radius
                                                                      .circular(
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
                                                              child: SizedBox(
                                                                height: SizeConfig
                                                                        .defaultSize! *
                                                                    Dimens
                                                                        .size25, //30
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
                                                                      .image,
                                                                  errorBuilder:
                                                                      (BuildContext,
                                                                          Object,
                                                                          StackTrace) {
                                                                    return const ImageErrorWidget();
                                                                  },
                                                                  width: 340,
                                                                  height: 60.0,
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
                                                                right: SizeConfig
                                                                        .defaultSize! *
                                                                    Dimens
                                                                        .size2,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        //"RNS",
                                                                        snapshot
                                                                            .data!
                                                                            .data[index]
                                                                            .kitchenName,
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                20,
                                                                            fontFamily:
                                                                                AppConstant.fontBold),
                                                                      ),
                                                                      Visibility(
                                                                        visible: snapshot.data!.data[index].averageRating ==
                                                                                "0.0"
                                                                            ? false
                                                                            : true,
                                                                        child: Row(
                                                                            children: [
                                                                              const Icon(Icons.star, color: Colors.amber, size: 16),
                                                                              Text(
                                                                                snapshot.data!.data[index].averageRating.toString(),
                                                                                style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ]),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const SizedBox(
                                                                              height: 8),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset('assets/images/timings.svg', height: 18),
                                                                              const SizedBox(width: 4),
                                                                              Text(
                                                                                snapshot.data!.data[index].time.toString(),
                                                                                style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 14, fontWeight: FontWeight.w400),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 8),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/images/type_of_meal.svg',
                                                                                height: 18,
                                                                              ),
                                                                              const SizedBox(width: 4),
                                                                              SizedBox(
                                                                                width: 210,
                                                                                //color: Colors.red,
                                                                                child: Text(
                                                                                  firstThreeData.toString().replaceAll('[', '').replaceAll(']', ''),
                                                                                  //snapshot.data!.data![index].cuisinetype.toString(),
                                                                                  style: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 14, fontWeight: FontWeight.w400),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 3),
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              'assets/images/home_kitchen.svg',
                                                                              height: 32,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "Home",
                                                                            style: TextStyle(
                                                                                color: Colors.black.withOpacity(0.4),
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400),
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
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontFamily:
                                                                                AppConstant.fontBold),
                                                                      ),
                                                                      Text(
                                                                        "₹${snapshot.data!.data[index].startingPrice}/-",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .red,
                                                                            fontSize:
                                                                                17,
                                                                            fontFamily:
                                                                                AppConstant.fontBold),
                                                                      ),
                                                                      const Text(
                                                                        "meal",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontFamily:
                                                                                AppConstant.fontBold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Card(
                                                                    //color: Colors.red,
                                                                    elevation:
                                                                        10,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          30,
                                                                      //width: 50,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(8),
                                                                            bottomLeft: Radius.circular(8)),
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const SizedBox(
                                                                            width:
                                                                                4,
                                                                          ),
                                                                          SvgPicture
                                                                              .asset(
                                                                            'assets/images/Offer1.svg',
                                                                            height:
                                                                                18,
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                4,
                                                                          ),
                                                                          Text(
                                                                            "${snapshot.data!.data[index].discount.replaceRange(2, 5, "")}%",
                                                                            style: const TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                4,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 200,
                                                    right: 20,
                                                    child: Card(
                                                      elevation: 8,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(SizeConfig
                                                                    .defaultSize! *
                                                                Dimens.size2),
                                                      ),
                                                      child: Container(
                                                          height: SizeConfig
                                                                  .defaultSize! *
                                                              Dimens.size4,
                                                          width: SizeConfig
                                                                  .defaultSize! *
                                                              Dimens.size4,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(
                                                                    SizeConfig
                                                                            .defaultSize! *
                                                                        Dimens
                                                                            .size2)),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                isFav == true;
                                                              });

                                                              if (snapshot
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .isFavourite ==
                                                                  '0') {
                                                                homeKitchenData
                                                                    .FavUpdate(
                                                                        index,
                                                                        '1');
                                                                favKitchenModel
                                                                    .favKitchenHttp(snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .kitchenId);
                                                                setState(() {
                                                                  future =
                                                                      homeKitchenData
                                                                          .getHomeScreenData(
                                                                    mealFor: "",
                                                                    cuisineType:
                                                                        "${widget.mealFor}",
                                                                    mealType:
                                                                        "",
                                                                    mealPlan:
                                                                        "",
                                                                    minPrice:
                                                                        "",
                                                                    maxPrice:
                                                                        "",
                                                                    rating: "",
                                                                    customerLatitude:
                                                                        "17.4431103",
                                                                    customerLongitude:
                                                                        "78.3869877",
                                                                  );
                                                                });
                                                              } else if (snapshot
                                                                      .data!
                                                                      .data[
                                                                          index]
                                                                      .isFavourite ==
                                                                  '1') {
                                                                homeKitchenData
                                                                    .FavUpdate(
                                                                        index,
                                                                        '0');

                                                                favKitchenModel
                                                                    .removeKitchenHttp(snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .kitchenId);
                                                                setState(() {
                                                                  future =
                                                                      homeKitchenData
                                                                          .getHomeScreenData(
                                                                    mealFor: "",
                                                                    cuisineType:
                                                                        "${widget.mealFor}",
                                                                    mealType:
                                                                        "",
                                                                    mealPlan:
                                                                        "",
                                                                    minPrice:
                                                                        "",
                                                                    maxPrice:
                                                                        "",
                                                                    rating: "",
                                                                    customerLatitude:
                                                                        "17.4431103",
                                                                    customerLongitude:
                                                                        "78.3869877",
                                                                  );
                                                                });
                                                              }
                                                            },
                                                            child: snapshot
                                                                        .data!
                                                                        .data[
                                                                            index]
                                                                        .isFavourite ==
                                                                    '0'
                                                                ? const Icon(
                                                                    Icons
                                                                        .favorite_border,
                                                                    color: Colors
                                                                        .black)
                                                                : const Icon(
                                                                    Icons
                                                                        .favorite,
                                                                    color: Colors
                                                                        .red),
                                                          )),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                  fontFamily: AppConstant.fontRegular),
                            ),
                          );
                  })
            ],
          ),
        ),
      ),
    );
  }

  bool isEditing = false;

  Widget getMeals(Meals meal, int index, Meals selectAll) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.amber,
          //activeColor: Color(0xff7EDABF),
          onChanged: (value) async {
            setState(() {
              isEditing = true;
              meal.isCheckedMeals = value ?? false;
              if (selectAll.isCheckedMeals && index == 0) {
                meals[1].isCheckedMeals = true;
                meals[2].isCheckedMeals = true;
                meals[3].isCheckedMeals = true;
                meals[4].isCheckedMeals = true;
                meals[5].isCheckedMeals = true;
                //bean.data!.breakfastTotime = ""
              } else if (selectAll.isCheckedMeals == false && index == 0) {
                meals[1].isCheckedMeals = false;
                meals[2].isCheckedMeals = false;
                meals[3].isCheckedMeals = false;
                meals[4].isCheckedMeals = false;
                meals[5].isCheckedMeals = false;
              } else if (!meal.isCheckedMeals) {
                selectAll.isCheckedMeals = false;
              } else if (meals[1].isCheckedMeals == true &&
                  meals[2].isCheckedMeals == true &&
                  meals[3].isCheckedMeals == true &&
                  meals[4].isCheckedMeals == true &&
                  meals[5].isCheckedMeals == true) {
                selectAll.isCheckedMeals = true;
              }
            });
            //Navigator.pop(context);
            setState(() {});
          },
          value: selectAll.isCheckedMeals ? true : meal.isCheckedMeals,
        ),
        Text(
          meal.title,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 12),
        ),
      ],
    );
  }

  Widget getTypeOfFood(Choice choice, int index) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.amber,
          // activeColor: Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              isEditing = true;
              choice.isChecked = value ?? true;
            });
          },
          value: choice.isChecked ?? false,
        ),
        Text(
          choice.title ?? "",
          style: const TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 12),
        ),
      ],
    );
  }

  Widget getPlane(plan plan, int index) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.amber,
          //activeColor: Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              isEditing = true;

              plan.isChecked = value ?? true;
            });
          },
          value: plan.isChecked ?? false,
        ),
        Text(
          plan.title ?? "",
          style: const TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 12),
        ),
      ],
    );
  }

  Widget getPrice(price price, int index) {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.amber,
          //Color(0xff7EDABF),
          onChanged: (value) {
            setState(() {
              isEditing = true;
              price.isChecked = value ?? true;
            });
          },
          value: price.isChecked ?? false,
        ),
        Text(
          price.title ?? "",
          style: const TextStyle(
              color: Colors.black,
              fontFamily: AppConstant.fontRegular,
              fontSize: 12),
        ),
      ],
    );
  }
}

class Meals {
  Meals({required this.title, required this.isCheckedMeals});

  String title;
  bool isCheckedMeals = false;
}

List<Meals> meals = <Meals>[
  Meals(
    title: 'All',
    isCheckedMeals: false,
  ),
  Meals(title: 'Breakfast', isCheckedMeals: false),
  Meals(title: 'Lunch', isCheckedMeals: false),
  Meals(title: 'Dinner', isCheckedMeals: false),
];

class Choice {
  Choice({this.title, this.isChecked});

  String? title;
  bool? isChecked = false;
}

List<Choice> choices = <Choice>[
  Choice(title: 'South Indian homely', isChecked: false),
  Choice(title: 'North Indian', isChecked: false),
  Choice(title: 'Weight loss', isChecked: false),
  Choice(title: 'Healthy', isChecked: false),
  Choice(title: 'Low carb', isChecked: false),
  Choice(title: 'Diabetic', isChecked: false),
  Choice(title: 'Keto', isChecked: false),
  Choice(title: 'Muscle gain', isChecked: false),
  Choice(title: 'Protein', isChecked: false),
  Choice(title: 'Vegan Diet', isChecked: false),
  Choice(title: 'Weight gain', isChecked: false),
];

class plan {
  plan({this.title, this.isChecked});

  String? title;
  bool? isChecked = false;
}

List<plan> plans = <plan>[
  plan(title: 'All', isChecked: false),
  plan(title: 'Weekly', isChecked: false),
  plan(title: 'Monthly', isChecked: false),
  plan(title: 'Order Now', isChecked: false),
];

class price {
  price({this.title, this.isChecked});

  String? title;
  bool? isChecked = false;
}

List<price> prices = <price>[
  price(title: 'All', isChecked: false),
  price(title: '₹0-₹100', isChecked: false),
  price(title: '₹101-₹500', isChecked: false),
  price(title: '₹501-₹1000', isChecked: false),
  price(title: '₹1001-₹1500', isChecked: false),
];
