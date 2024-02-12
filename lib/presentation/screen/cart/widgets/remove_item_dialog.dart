import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../model/cart_count_provider/cart_count_provider.dart';
import '../../../../model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import '../../../../network/cart_repo/cart_screen_model.dart';
import '../../../../network/pre_order/pre_order_provider.dart';
import '../../../../utils/constants/ui_constants.dart';

class RemoveCartItemDialog extends StatefulWidget {
  final String cartID;
  final String typeid;
  const RemoveCartItemDialog({
    Key? key,
    required this.cartID,
    required this.typeid,
  }) : super(key: key);

  @override
  State<RemoveCartItemDialog> createState() => _RemoveCartItemDialogState();
}

class _RemoveCartItemDialogState extends State<RemoveCartItemDialog> {
  @override
  Widget build(BuildContext context) {
    final menuItemAddToCartProvider = Provider.of<MenuItemAddToCartProvider>(
      context,
    );
    final cartCountProvider =
        Provider.of<CartCountModel>(context, listen: false);
    final preOrderProvider = Provider.of<PreorderProvider>(context);

    final screenWidth = MediaQuery.sizeOf(context).width;
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Builder(builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/icon_delete_address.svg',
                width: screenWidth * 0.4,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Are you sure you want to delete the item?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: AppConstant.fontRegular, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "NO",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kYellowColor,
                      ),
                      onPressed: () async {
                        var cartScreenModel = Provider.of<CartScreenModel>(
                            context,
                            listen: false);

                        ///REMOVE CART FIRST
                        final isRemoveSuccessful = await cartScreenModel
                            .removeCartItem(cartID: widget.cartID);
                        if (isRemoveSuccessful) {
                          preOrderProvider.updateTime('');
                          preOrderProvider.updateTimeFinal('');
                          preOrderProvider.updateDate('');
                          menuItemAddToCartProvider
                              .decreaseMenuItemsWithQuantityProvider(
                                  preorderProvider: preOrderProvider,
                                  menuId: widget.typeid,
                                  cartCountProvider: cartCountProvider,
                                  toRemove: true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppConstant.appColor,
                              content: Text(
                                "Item removed successfully",
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(
                                "Something went wrong!",
                                style: TextStyle(
                                    fontFamily: AppConstant.fontRegular),
                              ),
                            ),
                          );
                        }
                        Navigator.pop(context);

                        if (!mounted) {
                          return;
                        }
                      },
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
