import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/model/cart_count_provider/cart_count_provider.dart';
import 'package:food_app/presentation/screen/cart/widgets/remove_item_dialog.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../model/cart_screen_class/cart_screen_model_class.dart';
import '../../../../model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import '../../../../network/PackageSubRepo/get_package_details.dart';
import '../../../../network/cart_repo/cart_screen_model.dart';
import '../../../../network/pre_order/pre_order_provider.dart';
import '../../../../providers/cart_providers/cart_bill_details_provider.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../../utils/helper_class.dart';
import '../../kitchen_details/select_date_time.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({super.key, required this.cartProvider});
  final CartScreenModel cartProvider;
  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    final cartBillDetailsProvider =
        Provider.of<CartBillDetailsProvider>(context, listen: true);
    final menuItemAddToCartProvider = Provider.of<MenuItemAddToCartProvider>(
      context,
    );
    final preOrderProvider = Provider.of<PreorderProvider>(context);

    final packageModel =
        Provider.of<PackageDetailModel>(context, listen: false);
    var cartCountModel = Provider.of<CartCountModel>(context, listen: false);
    return FutureBuilder<GetCartDetailsModel>(
        future: cartBillDetailsProvider.getCartBillDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 105,
              child: Center(
                child: SpinKitCubeGrid(
                  color: AppConstant.appColor,
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final data = snapshot.data!.data;
            return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 10,
                          offset: Offset(4, 5),
                          spreadRadius: 0,
                        )
                      ],
                      border: Border.all(color: Colors.black26, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        data.cartItems[index].itemName,
                                        style:
                                            AppTextStyles.normalText.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  if (!data.cartItems[index].isTrial)
                                    GestureDetector(
                                      onTap: () async {
                                        final mealPlan =
                                            await packageModel.getMealPlan();
                                        final packageDetails =
                                            await packageModel
                                                .getPackageDetailsData();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SelectDateTime(
                                              mealFor: MealForEnum.lunch,
                                              kitchenId: data.kitchenDetailData
                                                      .kitchenId ??
                                                  "",
                                              mealPlan: mealPlan,
                                              packageDetailsData:
                                                  packageDetails,
                                            ),
                                          ),
                                        );
                                      },
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: AppConstant.appColor,
                                        ))),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Customize",
                                              style: AppTextStyles.normalText
                                                  .copyWith(
                                                color: AppConstant.appColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3.0, left: 5),
                                              child: SvgPicture.asset(
                                                'assets/images/customize.svg',
                                                width: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            (data.cartItems[index].isTrial)
                                ? Text(
                                    "₹ ${(double.parse(data.cartItems[index].price) * double.parse(data.cartItems[index].quantity))} ",
                                    style: AppTextStyles.normalText.copyWith(
                                      color: Color(0xD84A4A4B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  )
                                : Text(
                                    "₹ ${data.cartTotal}",
                                    style: AppTextStyles.normalText.copyWith(
                                      color: Color(0xD84A4A4B),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                            Spacer(),
                            if (data.cartItems[index].isTrial)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  color: kYellowColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    InkResponse(
                                      onTap: () async {
                                        if (data.cartItems[index].quantity ==
                                            '1') {
                                          var cartScreenModel =
                                              Provider.of<CartScreenModel>(
                                                  context,
                                                  listen: false);

                                          ///REMOVE CART FIRST
                                          final isRemoveSuccessful =
                                              await cartScreenModel
                                                  .removeCartItem(
                                                      cartID: data
                                                          .cartItems[index]
                                                          .cartId);
                                          if (isRemoveSuccessful) {
                                            preOrderProvider.updateTime('');
                                            preOrderProvider.updateDate('');
                                            menuItemAddToCartProvider
                                                .decreaseMenuItemsWithQuantityProvider(
                                                    cartCountProvider:
                                                        cartCountModel,
                                                    preorderProvider:
                                                        preOrderProvider,
                                                    menuId: data
                                                        .cartItems[index]
                                                        .typeid);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor:
                                                    AppConstant.appColor,
                                                content: Text(
                                                  "Item removed successfully",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor:
                                                    Colors.redAccent,
                                                content: Text(
                                                  "Something went wrong!",
                                                  style: TextStyle(
                                                      fontFamily: AppConstant
                                                          .fontRegular),
                                                ),
                                              ),
                                            );
                                          }
                                        } else {
                                          final res =
                                              await cartBillDetailsProvider
                                                  .updateCart(
                                                      cartId: data
                                                          .cartItems[index]
                                                          .cartId,
                                                      type: "2");
                                          if (res.status!) {
                                            menuItemAddToCartProvider
                                                .decreaseMenuItemsWithQuantityProvider(
                                                    cartCountProvider:
                                                        cartCountModel,
                                                    preorderProvider:
                                                        preOrderProvider,
                                                    menuId: data
                                                        .cartItems[index]
                                                        .typeid);
                                          }

                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  AppConstant.appColor,
                                              content: Text(
                                                res.message ?? "",
                                                style: const TextStyle(
                                                    fontFamily: AppConstant
                                                        .fontRegular),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text(
                                          "-",
                                          style: AppTextStyles.titleText,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        data.cartItems[index].quantity,
                                        style: AppTextStyles.titleText,
                                      ),
                                    ),
                                    InkResponse(
                                      onTap: () async {
                                        final res =
                                            await cartBillDetailsProvider
                                                .updateCart(
                                                    cartId: data
                                                        .cartItems[index]
                                                        .cartId,
                                                    type: "1");
                                        if (res.status!) {
                                          menuItemAddToCartProvider
                                              .increaseMenuItemsWithQuantityProvider(
                                                  preorderProvider:
                                                      preOrderProvider,
                                                  kitchenName: data
                                                          .kitchenDetailData
                                                          .kitchenName ??
                                                      "",
                                                  cartCountProvider:
                                                      cartCountModel,
                                                  menuId: data
                                                      .cartItems[index].typeid);
                                        }
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                AppConstant.appColor,
                                            content: Text(
                                              res.message ?? "",
                                              style: const TextStyle(
                                                  fontFamily:
                                                      AppConstant.fontRegular),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text(
                                          "+",
                                          style: AppTextStyles.titleText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkResponse(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return RemoveCartItemDialog(
                                        typeid: data.cartItems[index].typeid,
                                        cartID: data.cartItems[index].cartId,
                                      );
                                    });
                              },
                              child: SvgPicture.asset(
                                'assets/images/trash.svg',
                                width: 16,
                                color: Color(0xD8303031),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        if (!data.cartItems[index].isTrial)
                          Row(children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (data.cartItems[index].isTrial)
                                ? Text(Helper.formattedDateTime(DateTime.parse(
                                    "${data.cartItems[index].deliveryDate}")))
                                : Expanded(
                                    child: Text(
                                        "${Helper.formattedDateTime(DateTime.parse("${data.from_date}"))} to ${Helper.formattedDateTime(DateTime.parse("${data.to_date}"))} ${Helper.getIncludesSatSun(includingSunday: data.cartItems[index].includingSunday, includingSaturday: data.cartItems[index].includingSaturday)}"),
                                  ),
                          ]),
                        const SizedBox(
                          height: 5,
                        ),
                        if (!data.cartItems[index].isTrial)
                          Row(children: [
                            const Icon(
                              Icons.watch_later,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                "${Helper.formatTime(data.cartItems[index].deliveryFromtime)} - ${Helper.formatTime(data.cartItems[index].deliveryTotime)}"),
                          ]),
                        const SizedBox(
                          height: 5,
                        ),
                        //  (data.cartItems[index].isTrial)  ?  Row(children: [
                        //   Icon(
                        //     Icons.watch_later,
                        //     size: 17,
                        //   ),
                        //   SizedBox(
                        //     width: 10,
                        //   ),
                        //   Text("Customised Time"),
                        // ]):Row(children: [
                        //    Icon(
                        //      Icons.watch_later,
                        //      size: 17,
                        //    ),
                        //    SizedBox(
                        //      width: 10,
                        //    ),
                        //    Text(data.cartItems[index].),
                        //  ]),
                        // SizedBox(
                        //   height: 5,
                        // ),
                        if (!data.cartItems[index].isTrial)
                          Row(children: [
                            const Icon(
                              Icons.fastfood,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                "${data.cartItems[index].mealtype} Pack  (${data.cart_count} days)"),
                          ]),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                });
          }
          return const SizedBox(
            height: 105,
            child: Center(
              child: SpinKitCubeGrid(
                color: AppConstant.appColor,
              ),
            ),
          );
        });
  }
}
