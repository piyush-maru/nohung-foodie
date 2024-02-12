import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../model/package_details_model/package_details_model.dart';
import '../../network/PackageSubRepo/get_package_details.dart';
import '../../network/kitchen_details/kitchen_details_model.dart';
import '../../utils/constants/ui_constants.dart';
import '../../utils/helper_class.dart';
import 'kitchen_details/select_date_time.dart';

class SubscriptionPackageDetailsScreen extends StatelessWidget {
  final String kitchenID;
  final MealPlan mealPlan;
  final MealForEnum mealFor;
  const SubscriptionPackageDetailsScreen({
    Key? key,
    required this.kitchenID,
    required this.mealPlan,
    required this.mealFor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("=============================================<>packageid ${mealPlan.packageId}");
    print("=============================================<>packageid ${kitchenID}");
    print("=============================================<>packageid ${mealFor.value}");
    print(mealFor);
    print(kitchenID);

    print(mealPlan.packageName);
    print(mealPlan.packageId);
    final packageModel =
        Provider.of<PackageDetailModel>(context, listen: false);
    return SafeArea(
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: Scaffold(
          body: FutureBuilder<CustomizationPackageDetailsModel?>(
            future: packageModel.packageDetail(
              package_id: mealPlan.packageId,
              kitchen_id: kitchenID,
              mealFor: mealFor.value,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint("Erroe 44");
                print(snapshot.error);
              }
              if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                final data = snapshot.data!.data.first;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkResponse(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                "assets/images/backb.svg",
                                height: 27,
                                width: 27,
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          if (mealPlan.mealtype == "0")
                            SvgPicture.asset(
                              'assets/images/leaf.svg',
                              width: 30,
                            ),
                          if (mealPlan.mealtype == "1")
                            SvgPicture.asset(
                              'assets/images/chicken.svg',
                              width: 30,
                            ),
                          if (mealPlan.mealtype == "2")
                            SvgPicture.asset(
                              'assets/images/both.svg',
                              width: 30,
                            ),
                          const SizedBox(
                            width: 13,
                          ),
                          Text(
                            data.packageName,
                            style: AppTextStyles.semiBoldText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            "₹ ${data.price}",
                            style: AppTextStyles.normalText.copyWith(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${data.mealFor} | ${Helper.getVegNonVegText(data.mealType)} | ${data.cuisineType}",
                            style: AppTextStyles.normalText,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (data.provideCustomization == "y")
                            Text(
                              "Customization available",
                              style: AppTextStyles.normalText.copyWith(
                                color: kYellowColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: RawScrollbar(
                        thumbVisibility: true,
                        thumbColor: kYellowColor,
                        radius: const Radius.circular(20),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.packageDetail.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.packageDetail[index].daysName,
                                    style: AppTextStyles.titleText
                                        .copyWith(height: 2),
                                  ),
                                  ...data.packageDetail[index].itemName
                                      .split(",")
                                      .map(
                                        (meal) => Text(
                                          meal.trim(),
                                          style:
                                              AppTextStyles.normalText.copyWith(
                                            fontSize: 14,
                                            height: 1.7,
                                          ),
                                        ),
                                      )
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 7,
                              );
                            }),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹ ${data.price}",
                                      style: AppTextStyles.titleText.copyWith(
                                        color: kYellowColor,
                                      ),
                                    ),
                                    Text(
                                      "Order for ${data.packageDetail.length} days",
                                      style: AppTextStyles.semiBoldText,
                                    ),
                                  ],
                                ),
                                InkResponse(
                                  onTap: () {
                                    packageModel.updatePackageDetailsData(data);
                                    packageModel.updateMealPlan(mealPlan);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SelectDateTime(
                                          mealFor: mealFor,
                                          kitchenId: kitchenID,
                                          mealPlan: mealPlan,
                                          packageDetailsData: data,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    // width: 80,
                                    // height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: kYellowColor,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Select Date & Time",
                                          style:
                                              AppTextStyles.normalText.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Icon(Icons.arrow_right_alt)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "Order subscription package prior to ",
                                    style: AppTextStyles.normalText.copyWith(
                                      fontSize: 11,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.subscriptionOrderPriorTiming,
                                    style: AppTextStyles.normalText.copyWith(
                                      fontSize: 12,
                                      color: kYellowColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: " hour",
                                    style: AppTextStyles.normalText.copyWith(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: AppConstant.appColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
