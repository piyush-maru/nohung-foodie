import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/menu_item_add_to_cart_provider/menu_item_add_to_cart_provider.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/ui_constants.dart';
import '../../../../utils/pref_manager.dart';
import '../../Cart/cart_screen.dart';
import '../../authentication_screens/login/login_with_mobile_screen.dart';

class BottomFloatingSnackBar extends StatefulWidget {
  const BottomFloatingSnackBar({super.key});

  @override
  State<BottomFloatingSnackBar> createState() => _BottomFloatingSnackBarState();
}

class _BottomFloatingSnackBarState extends State<BottomFloatingSnackBar> {
  @override
  Widget build(BuildContext context) {
    final menuItemAddToCartProvider = Provider.of<MenuItemAddToCartProvider>(
      context,
    );
    return (menuItemAddToCartProvider.menuItemsWithQuantity.isNotEmpty)
        ? Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                15,
              ),
            ),
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 25, right: 10, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppConstant.appColor,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        poppinsText(
                            txt: '${menuItemAddToCartProvider.kitchenName}',
                            color: Colors.white,
                            fontSize: 16,
                            weight: FontWeight.bold),
                        Row(
                          children: [
                            poppinsText(
                                txt:
                                    '${menuItemAddToCartProvider.getCartTotalItemCount()} items   ',
                                color: Colors.white,
                                fontSize: 14,
                                weight: FontWeight.w500),
                            poppinsText(
                                txt:
                                    '${AppConstant.rupee}${menuItemAddToCartProvider.getCartTotalPrice()} ',
                                color: Colors.white,
                                fontSize: 14,
                                weight: FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                    InkResponse(
                      onTap: () async {
                        final isLoggedIn =
                            await PrefManager.getBool(AppConstant.session);
                        if (isLoggedIn) {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  const CartScreen(isFromPreOrderFlow: true),
                              transitionDuration:
                                  const Duration(milliseconds: 1500), //500
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween(
                                          begin: const Offset(0.0, -1.0),
                                          end: Offset.zero)
                                      .animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginWithMobileScreen()),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            color: AppConstant.appColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          )
        : SizedBox();
  }
}
