import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/helper_class.dart';

import '../../../../customWidgets/kitchen_details_IconText.dart';
import '../../../../model/home_screen_model/top_packages_model.dart';
import '../../../../network/kitchen_details/kitchen_details_model.dart';
import '../../../../utils/Utils.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../kitchen_details/kitchen_details_screen.dart';
import '../../kitchen_details/widgets/meals_in_weekend.dart';
import '../../subscription_package_details_screen.dart';

class TopPackagesDetailsCardCarousel extends StatelessWidget {
  const TopPackagesDetailsCardCarousel({super.key, required this.package});
  final TopPackagesData package;
  @override
  Widget build(BuildContext context) {
    final mealForList = package.mealFor.split(', ');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubscriptionPackageDetailsScreen(
              mealFor: mealForList.first == "Dinner"
                  ? MealForEnum.dinner
                  : mealForList.first == "Lunch"
                      ? MealForEnum.lunch
                      : MealForEnum.breakfast,
              mealPlan: MealPlan(
                  includingSaturday: package.includingSaturday,
                  includingSunday: package.includingSunday,
                  cuisineType: package.cuisines,
                  packageId: package.packageId,
                  bestSeller: 1,
                  cuisines: package.cuisines,
                  description: package.description,
                  including: '',
                  mealtype: package.mealType,
                  monthly: package.monthly,
                  monthlyNewPrice: package.monthlyNewPrice,
                  monthlyOldPrice: package.monthlyOldPrice,
                  monthlyPriceOn: package.monthlyPriceOn,
                  oneDayPrice: package.oneDayPrice,
                  packageName: package.packageName,
                  price: package.price,
                  provideCustomization: package.provideCustomization,
                  weeklyNewPrice: package.weeklyNewPrice,
                  weeklyOldPrice: package.weeklyOldPrice,
                  weeklyPriceOn: package.weeklyPriceOn,
                  weekly: package.weekly),
              kitchenID: package.kitchenId,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.only(
          left: 7,
          right: 7,
          bottom: 7,
          top: 10,
        ),
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0x44000000),
              blurRadius: 5,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: poppinsText(
                      txt: package.packageName.toUpperCase(),
                      fontSize: 15,
                      weight: FontWeight.w600),
                ),
              ),
              Row(
                children: mealForList
                    .map((meal) => Container(
                          height: 23,
                          width: 23,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 3),
                          decoration: const BoxDecoration(
                            color: Color(0xFFFCC546),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: poppinsText(
                              txt: Helper.mealForInitials(meal),
                              fontSize: 13,
                              weight: FontWeight.w400,
                              color: Colors.black),
                        ))
                    .toList(),
              )
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KitchenDetailsScreen(
                            package.kitchenId,
                            OrderCategory.Subscription.toJsonKey()),
                      ),
                    );
                  },
                  child: Row(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(package.image),
                      radius: 17,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: poppinsText(
                            txt: package.kitchenName,
                            fontSize: 15,
                            weight: FontWeight.w500),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  Helper.getMealTypeImage(
                    package.mealType,
                  ),
                  // fit: BoxFit.scaleDown,
                  // width: 20,
                  // height: 20,
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              if (package.weekly == '1')
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 14,
                    ),
                    poppinsText(
                        txt: " Weekly  ",
                        fontSize: 12,
                        weight: FontWeight.w400),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Image(
                          image: AssetImage(
                            'assets/images/discount11.png',
                          ),
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            poppinsText(
                                txt:
                                    "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.weeklyOldPrice)}      ",
                                fontSize: 10,
                                weight: FontWeight.w500),
                            poppinsText(
                                txt:
                                    "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.weeklyNewPrice)}   ",
                                fontSize: 10,
                                color: Colors.white,
                                weight: FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              Spacer(),
              poppinsText(
                  txt: package.rating, fontSize: 12, weight: FontWeight.w500),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              (package.monthly == '1')
                  ? Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 14,
                        ),
                        poppinsText(
                            txt: " Monthly  ",
                            fontSize: 12,
                            weight: FontWeight.w400),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Image(
                              image: AssetImage(
                                'assets/images/discount11.png',
                              ),
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                poppinsText(
                                    txt:
                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.monthlyOldPrice)}      ",
                                    fontSize: 10,
                                    weight: FontWeight.w500),
                                poppinsText(
                                    txt:
                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.monthlyNewPrice)}   ",
                                    fontSize: 10,
                                    color: Colors.white,
                                    weight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 25,
                    ),
              Spacer(),
              InkWell(
                  onTap: () {
                    Utils.shareContent(Helper.shareKitchenPackageContent(
                        package.kitchenId, package.packageId));
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: SvgPicture.asset('assets/icons/icon_share.svg'),
                  )),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  if (package.cuisines.isNotEmpty)
                    CuisineTypeText(
                      text: package.cuisines.length > 30
                          ? '${package.cuisines.substring(0, 30)}...'
                          : package.cuisines,
                    ),
                  // MealsInAWeek(
                  //     includingSunday: package.includingSunday,
                  //     includingSaturday: package.includingSaturday),
                  IncludingMealInWeekend(
                      includingSaturday: package.includingSaturday,
                      includingSunday: package.includingSunday)
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class TopPackagesDetailsCard extends StatelessWidget {
  const TopPackagesDetailsCard({super.key, required this.package});
  final TopPackagesData package;
  @override
  Widget build(BuildContext context) {
    final mealForList = package.mealFor.split(', ');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubscriptionPackageDetailsScreen(
              mealFor: mealForList.first == "Dinner"
                  ? MealForEnum.dinner
                  : mealForList.first == "Lunch"
                      ? MealForEnum.lunch
                      : MealForEnum.breakfast,
              mealPlan: MealPlan(
                  includingSaturday: package.includingSaturday,
                  includingSunday: package.includingSunday,
                  cuisineType: package.cuisines,
                  packageId: package.packageId,
                  bestSeller: 1,
                  cuisines: package.cuisines,
                  description: package.description,
                  including: '',
                  mealtype: package.mealType,
                  monthly: package.monthly,
                  monthlyNewPrice: package.monthlyNewPrice,
                  monthlyOldPrice: package.monthlyOldPrice,
                  monthlyPriceOn: package.monthlyPriceOn,
                  oneDayPrice: package.oneDayPrice,
                  packageName: package.packageName,
                  price: package.price,
                  provideCustomization: package.provideCustomization,
                  weeklyNewPrice: package.weeklyNewPrice,
                  weeklyOldPrice: package.weeklyOldPrice,
                  weeklyPriceOn: package.weeklyPriceOn,
                  weekly: package.weekly),
              kitchenID: package.kitchenId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 7,
          top: 10,
        ),
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color(0x44000000),
              blurRadius: 5,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: poppinsText(
                      txt: package.packageName.toUpperCase(),
                      fontSize: 15,
                      weight: FontWeight.w600),
                ),
              ),
              Row(
                children: mealForList
                    .map((meal) => Container(
                          height: 23,
                          width: 23,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 3),
                          decoration: BoxDecoration(
                            color: Color(0xFFFCC546),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x26000000),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: poppinsText(
                              txt: Helper.mealForInitials(meal),
                              fontSize: 13,
                              weight: FontWeight.w400,
                              color: Colors.black),
                        ))
                    .toList(),
              )
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KitchenDetailsScreen(
                            package.kitchenId,
                            OrderCategory.Subscription.toJsonKey()),
                      ),
                    );
                  },
                  child: Row(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(package.image),
                      radius: 17,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: poppinsText(
                            txt: package.kitchenName,
                            fontSize: 15,
                            weight: FontWeight.w500),
                      ),
                    ),
                  ]),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.all(5),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  Helper.getMealTypeImage(
                    package.mealType,
                  ),
                  // fit: BoxFit.scaleDown,
                  // width: 20,
                  // height: 20,
                ),
              )
            ],
          ),
          SizedBox(
            height: 9,
          ),
          Row(
            children: [
              if (package.weekly == '1')
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 14,
                    ),
                    poppinsText(
                        txt: " Weekly  ",
                        fontSize: 12,
                        weight: FontWeight.w400),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Image(
                          image: AssetImage(
                            'assets/images/discount11.png',
                          ),
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            poppinsText(
                                txt:
                                    "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.weeklyOldPrice)}      ",
                                fontSize: 10,
                                weight: FontWeight.w500),
                            poppinsText(
                                txt:
                                    "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.weeklyNewPrice)}   ",
                                fontSize: 10,
                                color: Colors.white,
                                weight: FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              Spacer(),
              poppinsText(
                  txt: package.rating, fontSize: 12, weight: FontWeight.w500),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
            ],
          ),
          SizedBox(
            height: 9,
          ),
          Row(
            children: [
              (package.monthly == '1')
                  ? Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: 14,
                        ),
                        poppinsText(
                            txt: " Monthly  ",
                            fontSize: 12,
                            weight: FontWeight.w400),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Image(
                              image: AssetImage(
                                'assets/images/discount11.png',
                              ),
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                poppinsText(
                                    txt:
                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.monthlyOldPrice)}      ",
                                    fontSize: 10,
                                    weight: FontWeight.w500),
                                poppinsText(
                                    txt:
                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(package.monthlyNewPrice)}   ",
                                    fontSize: 10,
                                    color: Colors.white,
                                    weight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(
                      height: 25,
                    ),
              Spacer(),
              InkWell(
                  onTap: () {
                    Utils.shareContent(Helper.shareKitchenPackageContent(
                        package.kitchenId, package.packageId));
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(7),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(),
                      shadows: [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: SvgPicture.asset('assets/icons/icon_share.svg'),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                if (package.cuisines.isNotEmpty)
                  CuisineTypeText(
                    text: package.cuisines.length > 30
                        ? '${package.cuisines.substring(0, 30)}...'
                        : package.cuisines,
                  ),
                // MealsInAWeek(
                //     includingSunday: package.includingSunday,
                //     includingSaturday: package.includingSaturday),
                IncludingMealInWeekend(
                    includingSaturday: package.includingSaturday,
                    includingSunday: package.includingSunday)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
