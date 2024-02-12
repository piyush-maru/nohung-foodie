import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_model.dart';
import 'package:food_app/presentation/screen/kitchen_details/widgets/meals_in_a_week.dart';
import 'package:food_app/presentation/screen/kitchen_details/widgets/meals_in_weekend.dart';
import 'package:food_app/utils/constants/app_constants.dart';

import '../../../../utils/Utils.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../../utils/helper_class.dart';

class SubscriptionCard extends StatelessWidget {
  final MealPlan? mealPlan;
  final void Function() onProceedTap;
  final KitchenDetailsData kitchenDetails;

  const SubscriptionCard({
    super.key,
    required this.mealPlan,
    required this.kitchenDetails,
    required this.onProceedTap,
  });

  @override
  Widget build(BuildContext context) {
    final int maxRating = 5;
    if (mealPlan == null) {
      return const Center(
        child: Text("Nothing In the Menu"),
      );
    } else {
      // List<String> cuisinesList = mealPlan!.cuisines.split(', ');
      return Stack(alignment: Alignment.topRight, children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 20, top: 20, bottom: 0, left: 5),
          child: GestureDetector(
            onTap: () {
              onProceedTap();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26000000),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                    spreadRadius: 0,
                  )
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (mealPlan!.mealtype == "0")
                        SvgPicture.asset(
                          'assets/images/leaf.svg',
                          width: 19,
                        ),
                      if (mealPlan!.mealtype == "1")
                        SvgPicture.asset(
                          'assets/images/chicken.svg',
                          width: 19,
                        ),
                      if (mealPlan!.mealtype == "2")
                        SvgPicture.asset(
                          'assets/images/both.svg',
                          width: 19,
                        ),
                      const SizedBox(
                        width: 7,
                      ),
                      poppinsText(
                          txt: mealPlan!.packageName,
                          fontSize: 16,
                          color: Color(0xFF2F3443),
                          textAlign: TextAlign.center,
                          weight: FontWeight.w400),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (mealPlan!.description.isNotEmpty)
                    poppinsText(
                        txt: mealPlan!.description,
                        fontSize: 13,
                        color: Color(0xCC2F3443),
                        textAlign: TextAlign.center,
                        weight: FontWeight.w400),
                  const SizedBox(
                    height: 5,
                  ),
                  poppinsText(
                      txt: "Starting From ₹ ${mealPlan!.price}",
                      fontSize: 13,
                      color: Color(0xFF2F3443),
                      textAlign: TextAlign.center,
                      weight: FontWeight.w400),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                if (mealPlan!.weekly == "1") ...[
                                  SvgPicture.asset('assets/images/calendar.svg',
                                      height: 15),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Text(
                                    'Weekly ',
                                    style: TextStyle(
                                      fontFamily: AppConstant.fontRegular,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  (mealPlan!.weeklyPriceOn == "0")
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/icon_discount_new.svg',
                                              height: 25,
                                              width: 25,
                                            ),
                                            poppinsText(
                                                txt:
                                                    "₹${Helper.convertStringToDoubleAndRemoveDecimal(mealPlan!.weeklyNewPrice)}   ",
                                                fontSize: 10,
                                                color: Colors.white,
                                                weight: FontWeight.w500),
                                          ],
                                        )
                                      : Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                'assets/images/discount11.png',
                                              ),
                                              height: 25,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                poppinsText(
                                                    txt:
                                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(mealPlan!.weeklyOldPrice)}      ",
                                                    fontSize: 10,
                                                    weight: FontWeight.w500),
                                                poppinsText(
                                                    txt:
                                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(mealPlan!.weeklyNewPrice)}   ",
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    weight: FontWeight.w500),
                                              ],
                                            ),
                                          ],
                                        ),
                                ],
                              ],
                            ),
                            Row(
                              children: [
                                if (mealPlan!.monthly == "1") ...[
                                  SvgPicture.asset('assets/images/calendar.svg',
                                      height: 15),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Text(
                                    'Monthly ',
                                    style: TextStyle(
                                      fontFamily: AppConstant.fontRegular,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  (mealPlan!.monthlyPriceOn == "0")
                                      ? Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/icon_discount_new.svg',
                                              height: 25,
                                              width: 25,
                                            ),
                                            poppinsText(
                                                txt:
                                                    "₹${Helper.convertStringToDoubleAndRemoveDecimal(mealPlan!.monthlyNewPrice)}   ",
                                                fontSize: 10,
                                                color: Colors.white,
                                                weight: FontWeight.w500),
                                          ],
                                        )
                                      : Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                'assets/images/discount11.png',
                                              ),
                                              height: 25,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                poppinsText(
                                                    txt:
                                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(mealPlan!.monthlyOldPrice)}      ",
                                                    fontSize: 10,
                                                    weight: FontWeight.w500),
                                                poppinsText(
                                                    txt:
                                                        "₹${Helper.convertStringToDoubleAndRemoveDecimal(mealPlan!.monthlyNewPrice)}   ",
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    weight: FontWeight.w500),
                                              ],
                                            ),
                                          ],
                                        ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 9),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kYellowColor),
                            child: poppinsText(
                                txt: "Proceed",
                                color: Colors.black,
                                fontSize: 13,
                                textAlign: TextAlign.center,
                                weight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () {
                              Utils.shareContent(
                                Helper.shareKitchenPackageContent(
                                    kitchenDetails.kitchen_details_id,
                                    mealPlan!.packageId),
                              );
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              margin: const EdgeInsets.only(top: 10),
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
                              child: const Icon(
                                Icons.share,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    //direction: Axis.horizontal,
                    //runSpacing: 7,
                    children: [
                      // CuisineTypeText(
                      //   text: mealPlan?.cuisines ?? "",
                      // ),
                      MealsInAWeek(
                          includingSunday: mealPlan!.includingSunday,
                          includingSaturday: mealPlan!.includingSaturday),
                      IncludingMealInWeekend(
                          includingSaturday: mealPlan!.includingSaturday,
                          includingSunday: mealPlan!.includingSunday)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (mealPlan!.bestSeller == 1)
          Padding(
            padding: const EdgeInsets.only(left: 180),
            child: SvgPicture.asset('assets/images/bestseller_tag1.svg',
                width: 100, height: 100),
          ),
      ]);
    }
  }
}
