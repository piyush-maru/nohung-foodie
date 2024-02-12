import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../model/customized_package_detail.dart';
import '../../../network/cart_repo/cart_screen_model.dart';
import '../../../network/check_out/checkout_model.dart';
import '../../../network/kitchen_details/kitchen_details_model.dart';
import '../../../network/pre_order/pre_order_provider.dart';
import '../../../utils/constants/ui_constants.dart';
import '../../../utils/helper_class.dart';
import '../Cart/cart_screen.dart';

class CustomizedSubscriptionPackageDetailsScreen extends StatelessWidget {
  final String kitchenId;
  final MealPlan mealPlan;
  final MealForEnum mealFor;
  const CustomizedSubscriptionPackageDetailsScreen({
    Key? key,
    required this.kitchenId,
    required this.mealPlan,
    required this.mealFor,
  }) : super(key: key);

  Future<void> _showCartResetDialog(
      BuildContext context, CustomizeData data) async {
    await showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              insetAnimationDuration: const Duration(seconds: 1),
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                // Set rounded corners
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: AppConstant.appColor,
                        size: 55,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Item already in cart",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBoldText
                            .copyWith(color: Colors.black54, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Would you like to reset your cart for package from this kitchen",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.normalText
                            .copyWith(color: Colors.black38, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "No",
                                style: AppTextStyles.semiBoldText.copyWith(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                var cartModelProvider =
                                    Provider.of<CartScreenModel>(context,
                                        listen: false);

                                ///RESET CART FIRST
                                final isResetSuccessful =
                                    await cartModelProvider.resetCart();

                                ///ADD NEW PACKAGE TO CART
                                if (isResetSuccessful) {
                                  cartModelProvider
                                      .addSubscriptionToCart(
                                    mealPlan: data.mealPlan ?? "",
                                    kitchenId: kitchenId,
                                    packageId: mealPlan.packageId,
                                  )
                                      .then((value) {
                                    if (value.status!) {
                                      final cartCountProvider =
                                          Provider.of<CartCountModel>(context,
                                              listen: false);
                                      final preOrderProvider =
                                          Provider.of<PreorderProvider>(
                                              context);

                                      cartCountProvider.checkCartCount(
                                          provider: preOrderProvider);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CartScreen(),
                                        ),
                                      );
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppConstant.appColor,
                              ),
                              child: Text(
                                "Yes, Start a Fresh",
                                style: AppTextStyles.semiBoldText.copyWith(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ]),
                    ]),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final checkoutModel = Provider.of<CheckOutModel>(context, listen: false);
    return SafeArea(
      child: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.white),
        child: Scaffold(
          body: FutureBuilder<BeanCustomizedPackageDetail?>(
            future:
                checkoutModel.customizedPackageDetailHttp(mealPlan.packageId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                final data = snapshot.data!.data;
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
                            ),
                          ),
                          /*InkResponse(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: kYellowColor, width: 2)),
                                child: const Icon(Icons.arrow_back)),
                          ),*/
                          const SizedBox(
                            width: 8,
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
                            data.packageName ?? "",
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
                            "${data.mealfor} | ${Helper.getVegNonVegText(data.mealtype ?? "")} | ${data.cuisinetype}",
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
                        thumbColor: kYellowColor,
                        radius: const Radius.circular(20),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.packageDetail!.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data.packageDetail?[index].daysName}, ${data.packageDetail?[index].date}",
                                    style: AppTextStyles.titleText
                                        .copyWith(height: 2),
                                  ),
                                  Text(
                                    "₹ ${data.packageDetail?[index].mealPrice}",
                                    style: AppTextStyles.titleText
                                        .copyWith(height: 2),
                                  ),
                                  ...data.packageDetail![index].items!.map(
                                    (e) => Text(
                                      e.itemname ?? "",
                                      style: AppTextStyles.normalText.copyWith(
                                        fontSize: 14,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
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
                                      "Order for ${data.countDays} days",
                                      style: AppTextStyles.semiBoldText,
                                    ),
                                  ],
                                ),
                                InkResponse(
                                  onTap: () {
                                    var cartModelProvider =
                                        Provider.of<CartScreenModel>(context,
                                            listen: false);
                                    cartModelProvider
                                        .addSubscriptionToCart(
                                      mealPlan: data.mealPlan ?? "",
                                      kitchenId: kitchenId,
                                      packageId: mealPlan.packageId,
                                    )
                                        .then((value) {
                                      if (value.status!) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CartScreen(),
                                          ),
                                        );
                                      } else {
                                        _showCartResetDialog(context, data);
                                      }
                                    });
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
                                          "Checkout",
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
                                    text: "Between ",
                                    style: AppTextStyles.semiBoldText.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data
                                        .packageDetail?.first.customisedTime,
                                    style: AppTextStyles.semiBoldText.copyWith(
                                        fontSize: 16,
                                        color: AppConstant.appColor),
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
