import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_controller.dart';
import 'package:food_app/presentation/screen/kitchen_details/widgets/bottom_floating_menu.dart';
import 'package:food_app/presentation/screen/kitchen_details/widgets/bottom_floating_snackbar.dart';
import 'package:food_app/presentation/screen/kitchen_details/widgets/kitchen_details_card.dart';
import 'package:food_app/presentation/screen/kitchen_details/widgets/meal_plan_builder.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../model/cuisine_types_model/cuisine_types_model.dart';
import '../../../model/cuisine_types_provider/cuisine_types_provider.dart';
import '../../../model/menu_list_provider/menu_list_provider.dart';
import '../../../network/kitchen_details/kitchen_details_model.dart';
import '../../../network/kitchen_details/subscription_provider.dart';
import '../../../utils/constants/ui_constants.dart';
import 'widgets/pre_order_list_builder.dart';

enum OrderCategory { Subscription, OrderNow }

extension ParseToString on OrderCategory {
  String toJsonKey() {
    switch (this) {
      case OrderCategory.Subscription:
        return "subscription";
      case OrderCategory.OrderNow:
        return "order_now";
    }
  }
}

class KitchenDetailsScreen extends StatefulWidget {
  final String kitchenId;
  final String mealPlan;
  final int initialIndex;

  const KitchenDetailsScreen(this.kitchenId, this.mealPlan,
      {Key? key, this.initialIndex = 0})
      : super(key: key);

  @override
  _KitchenDetailsScreenState createState() => _KitchenDetailsScreenState();
}

class _KitchenDetailsScreenState extends State<KitchenDetailsScreen>
    with TickerProviderStateMixin {
  //late TabController _tabControllerMealType;
  late TabController _tabControllerMealPlan;
  Future<CuisineTypesModel>? getAllCuisineTypesFuture;

  late AutoScrollController controller;
  final nestedParentScrollViewKey = GlobalKey();

  bool isFav = false;
  int ind = 0;
  int mealTypeIndex = 0;
  late bool isBreakfastEmpty;
  late bool isLunchEmpty;
  late bool isDinnerEmpty;
  CarouselController carouselController = CarouselController();
  int slideIndex = 0;
  final scrollDirection = Axis.vertical;

  @override
  void initState() {
    super.initState();

    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _tabControllerMealPlan = TabController(
          length: 2, vsync: this, initialIndex: widget.initialIndex);
    });
    final cuisineTypesProvider =
        Provider.of<CuisineTypesProvider>(context, listen: false);

    getAllCuisineTypesFuture = cuisineTypesProvider.getAllCuisineTypes();
    setIndex();
  }

  setIndex() async {
    final data = await Provider.of<SubscriptionProvider>(context, listen: false)
        .getSubscriptionDetailsList(kitchenId: widget.kitchenId);
    setState(() {
      mealTypeIndex = data.mealTypeIndex;
      isLunchEmpty = data.isLunchEmpty;
      isDinnerEmpty = data.isDinnerEmpty;
      isBreakfastEmpty = data.isBreakfastEmpty;
    });
  }

  Future<void> _openFiltersDialog({
    required bool isForPreOrder,
    required BuildContext context,
    required List<CuisineForSubscription> cuisineForSubscription,
    required List<CuisineForPreorder> cuisineForPreorder,
    required KitchenDetailsModel provider,
  }) async {
    String mealTypeFilter = provider.mealType;
    List<String> cuisineTypesFilter =
        provider.cuisine.isEmpty ? [] : provider.cuisine.split(',');

    await showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, myState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetAnimationDuration: const Duration(seconds: 1),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(36.0),
                // Set rounded corners
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppConstant.appColor, // Set the border color
                    width: 1.0, // Set the border width
                  ),
                  borderRadius: BorderRadius.circular(36.0),
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Filters",
                            style: AppTextStyles.boldText
                                .copyWith(color: Colors.black, fontSize: 19),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              "assets/images/xcircle.png",
                              width: 45,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Meal Type",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBoldText
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FittedBox(
                        child: Row(
                            children: List.generate(
                          mealTypeListWithImage.length,
                          (index) => InkResponse(
                            onTap: () {
                              myState(() {
                                if (mealTypeFilter == index.toString()) {
                                  mealTypeFilter = "";
                                } else {
                                  mealTypeFilter = index.toString();
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 7),
                              decoration: BoxDecoration(
                                  color: mealTypeFilter == index.toString()
                                      ? AppConstant.appColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black54)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    mealTypeListWithImage[index].icon,
                                  ),
                                  Text(mealTypeListWithImage[index].name),
                                ],
                              ),
                            ),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Cuisine Type",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBoldText
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      isForPreOrder
                          ? Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 5,
                              runSpacing: 10,
                              children: cuisineForPreorder
                                  .map(
                                    (e) => InkResponse(
                                      onTap: () {
                                        myState(() {
                                          if (cuisineTypesFilter
                                              .contains(e.key!.toString())) {
                                            cuisineTypesFilter.removeWhere(
                                                (element) =>
                                                    element ==
                                                    e.key!.toString());
                                          } else {
                                            cuisineTypesFilter
                                                .add(e.key!.toString());
                                          }
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        decoration: BoxDecoration(
                                            color: cuisineTypesFilter
                                                    .contains(e.key!.toString())
                                                ? AppConstant.appColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.black54)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(e.name!)),
                                      ),
                                    ),
                                  )
                                  .toList())
                          : Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 5,
                              runSpacing: 10,
                              children: cuisineForSubscription
                                  .map(
                                    (e) => InkResponse(
                                      onTap: () {
                                        myState(() {
                                          if (cuisineTypesFilter
                                              .contains(e.key!)) {
                                            cuisineTypesFilter.removeWhere(
                                                (element) => element == e.key!);
                                          } else {
                                            cuisineTypesFilter.add(e.key!);
                                          }
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        decoration: BoxDecoration(
                                            color: cuisineTypesFilter
                                                    .contains(e.key!)
                                                ? AppConstant.appColor
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.black54)),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(e.name!)),
                                      ),
                                    ),
                                  )
                                  .toList()),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.resetFilters();

                              myState(() {
                                mealTypeFilter = '';
                                cuisineTypesFilter.clear();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 11,
                              ),
                              //width: double.infinity,
                              alignment: Alignment.center,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0.0,
                                    bottom: 0.0),
                                child: Text(
                                  "Reset Filters",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              provider.updateMealType(mealTypeFilter);
                              provider
                                  .updateCuisine(cuisineTypesFilter.join(','));
                              Logger().f(
                                  "meal type is ${provider.mealType} and cuisne are ${provider.cuisine}");
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kYellowColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 11,
                              ),
                              //width: double.infinity,
                              alignment: Alignment.center,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0.0,
                                    bottom: 0.0),
                                child: Text(
                                  "Apply Filters",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            );
          });
        });
  }

  @override
  void dispose() {
    //_tabControllerMealType.dispose();
    _tabControllerMealPlan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenNotch = MediaQuery.paddingOf(context).top;
    final kitchenDetailsProvider = Provider.of<KitchenDetailsModel>(
      context,
    );

    // if (presed) {
    //   mySubscriptionDetails!.breakfast!.isNotEmpty
    //       ? indexs = 0
    //       : mySubscriptionDetails!.lunch!.isNotEmpty
    //           ? indexs = 1
    //           : mySubscriptionDetails.dinner!.isNotEmpty
    //               ? indexs = 2
    //               : indexs = -1;
    // }

    return WillPopScope(
      onWillPop: () async {
        context.read<MenuListProvider>().updateMenuStatus(value: false);
        context.read<KitchenDetailsModel>().resetFilters();
        context.read<MenuListProvider>().updateSelectedMenuIndex(index: 0);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingMenu(
              selectedIndex: (index) {
                controller.scrollToIndex(index, duration: Duration(seconds: 1));
                Navigator.pop(context);
              },
              kitchenID: widget.kitchenId,
            ),
            const SizedBox(
              height: 10,
            ),
            const BottomFloatingSnackBar(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        body: FutureBuilder<KitchenDetailsApi>(
            future: kitchenDetailsProvider.getKitchenDetailsData(
                kitchenId: widget.kitchenId,
                mealPlan: "subscription",
                mealType: "",
                cuisineType: "",
                mealFor: ""),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppConstant.appColor,
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "${snapshot.data!.message.toString()}",
                    //"Something went wrong",
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final myKitchenDetails = snapshot.data!;
                return NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(
                            height: screenNotch,
                          ),
                          KitchenDetailsCard(
                              myKitchenDetails: myKitchenDetails,
                              kitchenDetailsProvider: kitchenDetailsProvider),
                        ]),
                      ),
                    ];
                  },
                  body: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x26000000),
                                      blurRadius: 3,
                                      offset: Offset(0, 1),
                                      spreadRadius: 0,
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 3),
                                child: TabBar(
                                    onTap: (value) {
                                      setState(() {
                                        kitchenDetailsProvider.resetFilters();
                                        if (value == 0) {
                                          context
                                              .read<MenuListProvider>()
                                              .updateMenuStatus(value: false);
                                        } else {
                                          context
                                              .read<MenuListProvider>()
                                              .updateMenuStatus(value: true);
                                        }
                                      });
                                    },
                                    controller: _tabControllerMealPlan,
                                    physics: const BouncingScrollPhysics(),
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: kYellowColor,
                                    ),
                                    labelPadding:
                                        EdgeInsets.symmetric(horizontal: 27),
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.black,
                                    labelStyle: AppTextStyles.normalText
                                        .copyWith(fontSize: 15),
                                    isScrollable: true,
                                    tabs: const [
                                      Tab(
                                        text: "Subscription",
                                      ),
                                      Tab(
                                        text: "Pre Order",
                                      ),
                                    ]),
                              ),
                            ),
                            if (_tabControllerMealPlan.index == 1)
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkResponse(
                                  onTap: () {
                                    _openFiltersDialog(
                                      cuisineForPreorder: snapshot
                                          .data!.data.first.cuisineForPreorder!,
                                      cuisineForSubscription: snapshot.data!
                                          .data.first.cuisineForSubscription!,
                                      isForPreOrder: true,
                                      context: context,
                                      provider: kitchenDetailsProvider,
                                    );
                                  },
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/images/filters1.png"),
                                    height: 30,
                                    width: 35,
                                  ),
                                ),
                              )
                          ],
                        ),
                        if (_tabControllerMealPlan.index == 0 && mealTypeIndex != -1)
                          FutureBuilder<KitchenDetailsApi>(
                              future: kitchenDetailsProvider.getPackagesList(
                                kitchenId: widget.kitchenId,
                              ),
                              builder:
                                  (BuildContext context, subscriptionSnapshot) {
                                if (subscriptionSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppConstant.appColor,
                                    ),
                                  );
                                }
                                if (subscriptionSnapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                      "Something went wrong",
                                    ),
                                  );
                                }
                                if (subscriptionSnapshot.connectionState ==
                                        ConnectionState.done &&
                                    subscriptionSnapshot.hasData) {
                                  final SubscriptionPackageDetail? data =
                                      subscriptionSnapshot
                                          .data!.data.first.subscriptionDetail;

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17.0, right: 8, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: !isBreakfastEmpty,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    mealTypeIndex = 0;
                                                  });
                                                },
                                                child: Container(
                                                    // height: 36,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 8),
                                                    decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                                0x26000000),
                                                            blurRadius: 3,
                                                            offset:
                                                                Offset(0, 1),
                                                            spreadRadius: 0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: mealTypeIndex ==
                                                                0 /*ind==index*/
                                                            ? kYellowColor
                                                            : Colors.white),
                                                    child: Center(
                                                      child: poppinsText(
                                                        txt: 'Breakfast',
                                                        weight: FontWeight.w400,
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Visibility(
                                              visible: !isLunchEmpty,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    mealTypeIndex = 1;
                                                  });
                                                },
                                                child: Container(
                                                    // height: 36,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 8),
                                                    decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                                0x26000000),
                                                            blurRadius: 3,
                                                            offset:
                                                                Offset(0, 1),
                                                            spreadRadius: 0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: mealTypeIndex ==
                                                                1 /*ind==index*/
                                                            ? kYellowColor
                                                            : Colors.white),
                                                    child: Center(
                                                      child: poppinsText(
                                                        txt: 'Lunch',
                                                        weight: FontWeight.w400,
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Visibility(
                                              visible: !isDinnerEmpty,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    mealTypeIndex = 2;
                                                  });
                                                },
                                                child: Container(
                                                    // height: 36,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20.0,
                                                        vertical: 8),
                                                    decoration: BoxDecoration(
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Color(
                                                                0x26000000),
                                                            blurRadius: 3,
                                                            offset:
                                                                Offset(0, 1),
                                                            spreadRadius: 0,
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: mealTypeIndex ==
                                                                2 /*ind==index*/
                                                            ? kYellowColor
                                                            : Colors.white),
                                                    child: Center(
                                                      child: poppinsText(
                                                        txt: 'Dinner',
                                                        weight: FontWeight.w400,
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkResponse(
                                          onTap: () {
                                            _openFiltersDialog(
                                                isForPreOrder: false,
                                                context: context,
                                                provider:
                                                    kitchenDetailsProvider,
                                                cuisineForPreorder:
                                                    subscriptionSnapshot
                                                        .data!
                                                        .data
                                                        .first
                                                        .cuisineForPreorder!,
                                                cuisineForSubscription:
                                                    subscriptionSnapshot
                                                        .data!
                                                        .data
                                                        .first
                                                        .cuisineForSubscription!);
                                          },
                                          child: const Image(
                                            image: AssetImage(
                                                "assets/images/filters1.png"),
                                            height: 30,
                                            width: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppConstant.appColor,
                                  ),
                                );
                              }),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabControllerMealPlan,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              (mealTypeIndex == -1)
                                  ? Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Image.asset(
                                            'assets/images/image_no_orders.png',
                                            height: 200,
                                          ),
                                          poppinsText(
                                              txt: "Nothing in the menu",
                                              fontSize: 16,
                                              textAlign: TextAlign.center,
                                              weight: FontWeight.w500),
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20.0,
                                      ),
                                      child: FutureBuilder<KitchenDetailsApi>(
                                          future: kitchenDetailsProvider
                                              .getPackagesList(
                                            kitchenId: widget.kitchenId,
                                          ),
                                          builder: (BuildContext context,
                                              subscriptionSnapshot) {
                                            if (subscriptionSnapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppConstant.appColor,
                                                ),
                                              );
                                            }
                                            if (subscriptionSnapshot.hasError) {
                                              return const Center(
                                                child: Text(
                                                  "Something went wrong",
                                                ),
                                              );
                                            }
                                            if (subscriptionSnapshot
                                                        .connectionState ==
                                                    ConnectionState.done &&
                                                subscriptionSnapshot.hasData) {
                                              final SubscriptionPackageDetail?
                                                  data = subscriptionSnapshot
                                                      .data!
                                                      .data
                                                      .first
                                                      .subscriptionDetail;
                                              return Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      mealTypeIndex == 0
                                                          ? "Breakfast"
                                                          : mealTypeIndex == 1
                                                              ? "Lunch"
                                                              : "Dinner",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      mealTypeIndex == 0
                                                          ? "${data!.breakfast!.length} Packages"
                                                          : mealTypeIndex == 1
                                                              ? "${data!.lunch!.length} Packages"
                                                              : "${data!.dinner!.length} Packages",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Expanded(
                                                    child: MealPlanBuilder(
                                                        mealFor: mealTypeIndex == 0
                                                            ? MealForEnum.breakfast
                                                            : mealTypeIndex == 1
                                                            ? MealForEnum.lunch
                                                                : MealForEnum.dinner,
                                                        kitchenDetails: myKitchenDetails.data.first,
                                                        MealPlanList: mealTypeIndex == 0
                                                                ? data!.breakfast!
                                                                : mealTypeIndex == 1
                                                                    ? data!.lunch!
                                                                    : data!.dinner!),
                                                  ),
                                                ],
                                              );
                                            }
                                            return const Center(
                                              child: CircularProgressIndicator(
                                                color: AppConstant.appColor,
                                              ),
                                            );
                                          }),
                                    ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20,
                                    // bottom: 65,
                                  ),
                                  child: FutureBuilder<List<OrderNowDetail>?>(
                                      future: kitchenDetailsProvider
                                          .getPreOrderList(
                                        kitchenId: widget.kitchenId,
                                      ),
                                      builder: (BuildContext context,
                                          preOrderSnapshot) {
                                        if (preOrderSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: AppConstant.appColor,
                                            ),
                                          );
                                        }
                                        if (preOrderSnapshot.hasError) {
                                          return const Center(
                                            child: Text(
                                              "Something went wrong",
                                            ),
                                          );
                                        }
                                        if (preOrderSnapshot.connectionState ==
                                                ConnectionState.done &&
                                            preOrderSnapshot.hasData) {
                                          return preOrderSnapshot.data!.isEmpty
                                              ? Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0,
                                                            bottom: 50),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/image_no_orders.png',
                                                          height: 200,
                                                        ),
                                                        poppinsText(
                                                            txt:
                                                                "No such Items are available",
                                                            fontSize: 16,
                                                            textAlign: TextAlign
                                                                .center,
                                                            weight: FontWeight
                                                                .w500),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : ListView.builder(
                                                  physics: BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      scrollDirection,
                                                  controller: controller,
                                                  itemCount: preOrderSnapshot.data!.length ?? 0,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    final OrderNowDetail data = preOrderSnapshot.data![index];
                                                    return AutoScrollTag(
                                                      key: ValueKey(index),
                                                      controller: controller,
                                                      index: index,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "${data?.categoryName} (${data?.menuItems.length})",
                                                              style: const TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            const SizedBox(
                                                              height: 16,
                                                            ),
                                                            PreOrderListBuilder(
                                                              isPeOrderAvaialble: myKitchenDetails.data.first.availableStatus == "1",
                                                              menuItemList: data?.menuItems ?? [],
                                                              kitchenDetails: myKitchenDetails.data.first,
                                                            ),
                                                            SizedBox(
                                                              height: (index ==
                                                                      preOrderSnapshot
                                                                              .data!
                                                                              .length -
                                                                          1)
                                                                  ? 95
                                                                  : 35,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: AppConstant.appColor,
                                          ),
                                        );
                                      })),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: AppConstant.appColor,
                ),
              );
            }),
      ),
    );
  }
}

class DotBar extends StatelessWidget {
  final int numberOfDots;
  final int currentDotIndex;

  DotBar({required this.numberOfDots, required this.currentDotIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfDots,
        (index) => Dot(
          isActive: index == currentDotIndex,
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;
  final double size = 5.0;

  Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppConstant.appColor : Colors.grey,
      ),
    );
  }
}
