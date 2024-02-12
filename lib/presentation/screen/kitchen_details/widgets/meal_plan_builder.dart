import 'package:flutter/material.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_model.dart';
import 'package:food_app/presentation/screen/kitchen_details/widgets/subscription_card.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../../model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import '../../../../network/cart_repo/cart_screen_model.dart';
import '../../../../network/pre_order/pre_order_provider.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../subscription_package_details_screen.dart';

class MealPlanBuilder extends StatelessWidget {
  final List<MealPlan> MealPlanList;
  final KitchenDetailsData kitchenDetails;
  final MealForEnum mealFor;

  const MealPlanBuilder({
    super.key,
    required this.MealPlanList,
    required this.kitchenDetails,
    required this.mealFor,
  });
  Future<void> _showCartResetDialog(
      BuildContext context, MealPlan mealPlan) async {
    await showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          final menuItemAddToCartProvider =
              Provider.of<MenuItemAddToCartProvider>(context, listen: false);
          final cartCountProvider =
              Provider.of<CartCountModel>(context, listen: false);
          final preOrderProvider =
              Provider.of<PreorderProvider>(context, listen: false);

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
                                  Navigator.pop(context);
                                  menuItemAddToCartProvider
                                      .clearMenuItemsWithQuantityList();
                                  cartCountProvider.checkCartCount(
                                      provider: preOrderProvider);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SubscriptionPackageDetailsScreen(
                                        mealFor: mealFor,
                                        mealPlan: mealPlan,
                                        kitchenID: kitchenDetails.kitchenId,
                                      ),
                                    ),
                                  );
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
    final cartCountProvider = Provider.of<CartCountModel>(context);

    return (MealPlanList.isEmpty)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/image_no_orders.png',
                    height: 200,
                  ),
                  poppinsText(
                      txt: "No such packages are available",
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w500),
                ],
              ),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: MealPlanList.length + 1,
            itemBuilder: (context, index) {
              if (index == MealPlanList.length) {
                return SizedBox(
                  height: 100,
                );
              } else {
                return SubscriptionCard(
                  kitchenDetails: kitchenDetails,
                  onProceedTap: () async {
                    if (cartCountProvider.isCartEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SubscriptionPackageDetailsScreen(
                            mealFor: mealFor,
                            mealPlan: MealPlanList[index],
                            kitchenID: kitchenDetails.kitchenId,
                          ),
                        ),
                      );
                    } else {
                      _showCartResetDialog(context, MealPlanList[index]);
                    }
                  },
                  mealPlan: MealPlanList[index],
                );
              }
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 0,
              );
            },
          );
  }
}
