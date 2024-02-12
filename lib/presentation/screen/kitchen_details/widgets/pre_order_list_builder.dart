import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/network/cart_repo/cart_screen_model.dart';
import 'package:food_app/network/kitchen_details/kitchen_details_model.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/constants/ui_constants.dart';
import 'package:provider/provider.dart';

import '../../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../../model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import '../../../../network/pre_order/pre_order_provider.dart';
import '../../../../utils/pref_manager.dart';

class PreOrderListBuilder extends StatefulWidget {
  final List<MenuItem> menuItemList;
  final KitchenDetailsData kitchenDetails;
  final bool isPeOrderAvaialble;

  const PreOrderListBuilder({
    super.key,
    required this.menuItemList,
    required this.kitchenDetails,
    required this.isPeOrderAvaialble,
  });

  @override
  State<PreOrderListBuilder> createState() => _PreOrderListBuilderState();
}

class _PreOrderListBuilderState extends State<PreOrderListBuilder> {
  @override
  Widget build(BuildContext context) {
    return (widget.menuItemList.isEmpty)
        ? const Center(child: Text("Nothing in the menu"))
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.menuItemList.length,
            padding: EdgeInsets.symmetric(horizontal: 7),
            itemBuilder: (context, index) {
              return PreOrderCard(
                menuItem: widget.menuItemList[index],
                isPeOrderAvaialble: widget.isPeOrderAvaialble,
                kitchenDetails: widget.kitchenDetails,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
          );
  }
}

class PreOrderCard extends StatefulWidget {
  const PreOrderCard({
    super.key,
    required this.menuItem,
    required this.kitchenDetails,
    required this.isPeOrderAvaialble,
  });
  final MenuItem menuItem;
  final KitchenDetailsData kitchenDetails;
  final bool isPeOrderAvaialble;
  @override
  State<PreOrderCard> createState() => _PreOrderCardState();
}

class _PreOrderCardState extends State<PreOrderCard> {
  Future<void> _showCartErrorDialog(
      {required BuildContext context,
      required String message,
      required MenuItem menuItem,
      required PreorderProvider preOrderProvider,
      required CartCountModel cartCountProvider}) async {
    await showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          final menuItemAddToCartProvider =
              Provider.of<MenuItemAddToCartProvider>(
            context,
          );
          var cartModelProvider =
              Provider.of<CartScreenModel>(context, listen: false);
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
                      if (message == "Your cart contains items from other kitchen. Reset your cart for add items from this kitchen."|| message =="Already added package in cart. Reset your cart for add trial meal in cart.")
                        Text("Item already in cart",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBoldText
                              .copyWith(color: Colors.black54, fontSize: 18),
                        ),
                      if (message == "Kitchen is closed. Please try after open the kitchen.")
                        Text("Kitchen is closed",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBoldText
                              .copyWith(color: Colors.black54, fontSize: 18),
                        ),
                      if (message == "Kitchen is not available.")
                        Text("Unavailable for Pre Orders",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.semiBoldText
                              .copyWith(color: Colors.black54, fontSize: 18),
                        ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.normalText
                            .copyWith(color: Colors.black38, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (message == "Your cart contains items from other kitchen. Reset your cart for add items from this kitchen." || message =="Already added package in cart. Reset your cart for add trial meal in cart.")
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
                                  ///RESET CART

                                  cartModelProvider.resetCart().then((value) {
                                    menuItemAddToCartProvider
                                        .clearMenuItemsWithQuantityList();
                                    menuItemAddToCartProvider
                                        .addToMenuItemsWithQuantity(
                                            preorderProvider: preOrderProvider,
                                            price:
                                                int.parse(menuItem.itemPrice),
                                            kitchenName: widget
                                                .kitchenDetails.kitchenName,
                                            menuId: menuItem.menuId,
                                            kitchenId:
                                                widget.kitchenDetails.kitchenId,
                                            cartCountProvider:
                                                cartCountProvider,
                                            cartModelProvider:
                                                cartModelProvider)
                                        .then((value) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: AppConstant.appColor,
                                        content: Text(
                                            'Cart is reset and Item added successfully'),
                                      ));
                                    });
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppConstant.appColor,
                                ),
                                child: Text(
                                  "Yes, Reset Cart",
                                  style: AppTextStyles.semiBoldText.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ]),
                      if (message == "Kitchen is closed. Please try after open the kitchen.")
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Close",
                            style: AppTextStyles.semiBoldText
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                        ),
                    ]),
              ));
        });
  }

  var isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final menuItemAddToCartProvider = Provider.of<MenuItemAddToCartProvider>(
      context,
    );
    final preOrderProvider = Provider.of<PreorderProvider>(context);

    final cartCountProvider =
        Provider.of<CartCountModel>(context, listen: false);
    var cartModelProvider =
        Provider.of<CartScreenModel>(context, listen: false);
    return Container(
      height: isExpanded ? 125 : 100,
      padding: const EdgeInsets.only(top: 10, bottom: 7, left: 10, right: 10),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.menuItem.itemType == "veg"
                  ?SvgPicture.asset('assets/images/leaf.svg',width: 12, height: 12)
                  : widget.menuItem.itemType == "nonveg"
                  ?SvgPicture.asset('assets/images/chicken.svg',width: 12, height: 12)
                  :SvgPicture.asset('assets/images/both.svg',width: 12, height: 12),
             // SvgPicture.asset('assets/images/leaf.svg', width: 12, height: 12),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: 150,
               // color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.menuItem.itemName!.length > 33) {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                             // color: Colors.red,
                              height: isExpanded ? 70 : 40,
                              child: poppinsText(
                                txt: widget.menuItem.itemName ?? "",
                                fontSize: 14,
                                maxLines: isExpanded ? 4 : 2,
                                weight: FontWeight.w400,
                                color: kTextPrimary,
                              ),
                            ),
                          ),
                          if (widget.menuItem.itemName!.length > 33)
                            poppinsText(
                              txt: isExpanded ? "" : "more",
                              fontSize: 11,
                              weight: FontWeight.w400,
                              color: kgrey,
                            ),
                        ],
                      ),
                    ),
                    Spacer(),
                    poppinsText(
                      txt: widget.menuItem.description ?? "",
                      fontSize: 10,
                      weight: FontWeight.w400,
                      color: kTextPrimary,
                    ),
                    const Spacer(),
                    poppinsText(
                      txt: "₹ ${widget.menuItem.itemPrice}",
                      fontSize: 15,
                      weight: FontWeight.w400,
                      color: kTextPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          (widget.menuItem.image == null || widget.menuItem.image.length == 0)
              ? IgnorePointer(
                  ignoring: !widget.isPeOrderAvaialble,
                  child: Center(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final isLoggedIn =
                                await PrefManager.getBool(AppConstant.session);
                            if (isLoggedIn) {
                              (menuItemAddToCartProvider
                                          .getCountOfParticularMenuItemWithQuantity(
                                              menuId:
                                                  widget.menuItem.menuId)) ==
                                      0
                                  ? null
                                  : menuItemAddToCartProvider
                                      .decreaseMenuItemsWithQuantity(
                                          preorderProvider: preOrderProvider,
                                          menuId: widget.menuItem.menuId,
                                          kitchenId:
                                              widget.kitchenDetails.kitchenId,
                                          cartCountProvider: cartCountProvider,
                                          cartModelProvider: cartModelProvider);
                            }
                            else {
                              (menuItemAddToCartProvider
                                          .getCountOfParticularMenuItemWithQuantity(
                                              menuId:
                                                  widget.menuItem.menuId)) ==
                                      0
                                  ? null
                                  : menuItemAddToCartProvider
                                      .decreaseMenuItemsWithQuantityWithoutLogin(
                                          preorderProvider: preOrderProvider,
                                          menuId: widget.menuItem.menuId,
                                          kitchenId:
                                              widget.kitchenDetails.kitchenId,
                                          cartCountProvider: cartCountProvider,
                                          cartModelProvider: cartModelProvider);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 16),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0x3F2F3443),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: SvgPicture.asset(
                                'assets/icons/icon_minus.svg',
                                color: widget.isPeOrderAvaialble
                                    ? Colors.black
                                    : Colors.grey,
                                width: 12),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          child: poppinsText(
                            txt:
                                '${menuItemAddToCartProvider.getCountOfParticularMenuItemWithQuantity(menuId: widget.menuItem.menuId)}',
                            fontSize: 15,
                            color: widget.isPeOrderAvaialble
                                ? Color(0xFF2F3443)
                                : Colors.grey,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final isLoggedIn =
                                await PrefManager.getBool(AppConstant.session);
                            if ((menuItemAddToCartProvider.getCountOfParticularMenuItemWithQuantity(menuId: widget.menuItem.menuId)) == 0) {
                              if (!isLoggedIn) {
                                menuItemAddToCartProvider
                                    .addToMenuItemsWithQuantityWithoutLogin(
                                        preorderProvider: preOrderProvider,
                                        price: int.parse(
                                            widget.menuItem.itemPrice),
                                        kitchenName:
                                            widget.kitchenDetails.kitchenName,
                                        menuId: widget.menuItem.menuId,
                                        kitchenId:
                                            widget.kitchenDetails.kitchenId,
                                        cartCountProvider: cartCountProvider,
                                        cartModelProvider: cartModelProvider);
                              }
                              else {
                                menuItemAddToCartProvider
                                    .addToMenuItemsWithQuantity(
                                        preorderProvider: preOrderProvider,
                                        price: int.parse(
                                            widget.menuItem.itemPrice),
                                        kitchenName:
                                            widget.kitchenDetails.kitchenName,
                                        menuId: widget.menuItem.menuId,
                                        kitchenId:
                                            widget.kitchenDetails.kitchenId,
                                        cartCountProvider: cartCountProvider,
                                        cartModelProvider: cartModelProvider)
                                    .then((value) {
                                  if (!value.status!) {
                                    print("------------------------1=>${preOrderProvider}");
                                    print("------------------------2=>${value.message!}");
                                    print("------------------------3=>${cartCountProvider}");
                                    print("------------------------4=>${widget.menuItem}");

                                    _showCartErrorDialog(
                                        preOrderProvider: preOrderProvider,
                                        context: context,
                                        message: value.message!,
                                        cartCountProvider: cartCountProvider,
                                        menuItem: widget.menuItem);
                                  }
                                });
                              }
                            } else {
                              isLoggedIn
                                  ? menuItemAddToCartProvider
                                      .increaseMenuItemsWithQuantity(
                                          preorderProvider: preOrderProvider,
                                          kitchenName:
                                              widget.kitchenDetails.kitchenName,
                                          kitchenId:
                                              widget.kitchenDetails.kitchenId,
                                          cartCountProvider: cartCountProvider,
                                          cartModelProvider: cartModelProvider,
                                          menuId: widget.menuItem.menuId)
                                  : menuItemAddToCartProvider
                                      .increaseMenuItemsWithQuantityWithoutLogin(
                                          preorderProvider: preOrderProvider,
                                          kitchenName:
                                              widget.kitchenDetails.kitchenName,
                                          kitchenId:
                                              widget.kitchenDetails.kitchenId,
                                          cartCountProvider: cartCountProvider,
                                          cartModelProvider: cartModelProvider,
                                          menuId: widget.menuItem.menuId);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 11, vertical: 13),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: Color(0x3F2F3443),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: SvgPicture.asset('assets/icons/icon_add.svg',
                                color: widget.isPeOrderAvaialble
                                    ? Colors.black
                                    : Colors.grey,
                                width: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : IgnorePointer(
                  ignoring: !widget.isPeOrderAvaialble,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 7),
                        child:  Container(
                          color: Colors.red,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                               widget.menuItem.image ?? "",
                                fit: BoxFit.fill,
                                height: 90,
                                width: 95,
                              ),
                            ),
                        ),
                      ),
                      (menuItemAddToCartProvider.getCountOfParticularMenuItemWithQuantity(
                          menuId: widget.menuItem.menuId)) == 0
                          ? Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                  onTap: () async {
                                    final isLoggedIn =
                                        await PrefManager.getBool(
                                            AppConstant.session);
                                    if (!isLoggedIn) {
                                      menuItemAddToCartProvider
                                          .addToMenuItemsWithQuantityWithoutLogin(
                                              preorderProvider:
                                                  preOrderProvider,
                                              price: int.parse(
                                                  widget.menuItem.itemPrice),
                                              kitchenName: widget
                                                  .kitchenDetails.kitchenName,
                                              menuId: widget.menuItem.menuId,
                                              kitchenId: widget
                                                  .kitchenDetails.kitchenId,
                                              cartCountProvider:
                                                  cartCountProvider,
                                              cartModelProvider:
                                                  cartModelProvider);
                                    } else {
                                      menuItemAddToCartProvider
                                          .addToMenuItemsWithQuantity(
                                              preorderProvider:
                                                  preOrderProvider,
                                              price: int.parse(
                                                  widget.menuItem.itemPrice),
                                              kitchenName: widget
                                                  .kitchenDetails.kitchenName,
                                              menuId: widget.menuItem.menuId,
                                              kitchenId: widget
                                                  .kitchenDetails.kitchenId,
                                              cartCountProvider:
                                                  cartCountProvider,
                                              cartModelProvider:
                                                  cartModelProvider)
                                          .then((value) {
                                        if (!value.status!) {
                                          _showCartErrorDialog(
                                              preOrderProvider:
                                                  preOrderProvider,
                                              context: context,
                                              message: value.message!,
                                              cartCountProvider:
                                                  cartCountProvider,
                                              menuItem: widget.menuItem);
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.all(12),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x25000000),
                                          blurRadius: 4,
                                          offset: Offset(0, 1),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/icon_add.svg',
                                        color: widget.isPeOrderAvaialble
                                            ? Colors.black
                                            : Colors.grey,
                                        width: 12),
                                  )),
                            )
                          : Container(
                              // width: 70,
                              // height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x26000000),
                                    blurRadius: 8,
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn =
                                          await PrefManager.getBool(
                                              AppConstant.session);
                                      if (!isLoggedIn) {
                                        menuItemAddToCartProvider
                                            .decreaseMenuItemsWithQuantityWithoutLogin(
                                                preorderProvider:
                                                    preOrderProvider,
                                                menuId: widget.menuItem.menuId,
                                                kitchenId: widget
                                                    .kitchenDetails.kitchenId,
                                                cartCountProvider:
                                                    cartCountProvider,
                                                cartModelProvider:
                                                    cartModelProvider);
                                      } else {
                                        menuItemAddToCartProvider
                                            .decreaseMenuItemsWithQuantity(
                                                preorderProvider:
                                                    preOrderProvider,
                                                menuId: widget.menuItem.menuId,
                                                kitchenId: widget
                                                    .kitchenDetails.kitchenId,
                                                cartCountProvider:
                                                    cartCountProvider,
                                                cartModelProvider:
                                                    cartModelProvider);
                                      }
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          topLeft: Radius.circular(16),
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                          right: 13.0,
                                          left: 13,
                                          top: 13,
                                          bottom: 13),
                                      child: SvgPicture.asset(
                                          'assets/icons/icon_minus.svg',
                                          color: widget.isPeOrderAvaialble
                                              ? Colors.black
                                              : Colors.grey,
                                          width: 12),
                                    ),
                                  ),
                                  poppinsText(
                                    txt:
                                        '${menuItemAddToCartProvider.getCountOfParticularMenuItemWithQuantity(menuId: widget.menuItem.menuId)}',
                                    fontSize: 15,
                                    color: widget.isPeOrderAvaialble
                                        ? Color(0xFF2F3443)
                                        : Colors.grey,
                                    textAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final isLoggedIn = await PrefManager.getBool(AppConstant.session);
                                      if (!isLoggedIn) {
                                        menuItemAddToCartProvider.increaseMenuItemsWithQuantityWithoutLogin(
                                                preorderProvider: preOrderProvider,
                                                kitchenName: widget.kitchenDetails.kitchenName,
                                                kitchenId: widget.kitchenDetails.kitchenId,
                                                cartCountProvider: cartCountProvider,
                                                cartModelProvider: cartModelProvider,
                                                menuId: widget.menuItem.menuId
                                        );
                                      } else {
                                        menuItemAddToCartProvider.increaseMenuItemsWithQuantity(
                                                preorderProvider: preOrderProvider,
                                                kitchenName: widget.kitchenDetails.kitchenName,
                                                kitchenId: widget.kitchenDetails.kitchenId,
                                                cartCountProvider: cartCountProvider,
                                                cartModelProvider: cartModelProvider,
                                                menuId: widget.menuItem.menuId
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          topLeft: Radius.circular(16),
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(
                                          right: 13.0,
                                          left: 13,
                                          top: 13,
                                          bottom: 13),
                                      child: SvgPicture.asset(
                                          'assets/icons/icon_add.svg',
                                          color: widget.isPeOrderAvaialble
                                              ? Colors.black
                                              : Colors.grey,
                                          width: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
