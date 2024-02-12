import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../network/cart_repo/cart_screen_model.dart';
import '../../network/pre_order/pre_order_provider.dart';
import '../cart_count_provider/cart_count_provider.dart';
import '../cart_screen_class/add_cart.dart';

class MenuItemWithQuantityModel {
  final String menuId;
  int quantity;
  int price;
  MenuItemWithQuantityModel({
    required this.quantity,
    required this.price,
    required this.menuId,
  });
}

class MenuItemAddToCartProvider extends ChangeNotifier {
  final log = Logger();
  List<MenuItemWithQuantityModel> _menuItemsWithQuantity =
      <MenuItemWithQuantityModel>[];
  List<MenuItemWithQuantityModel> get menuItemsWithQuantity =>
      _menuItemsWithQuantity;
  String _kitchenName = '';
  String get kitchenName => _kitchenName;

  void prints() {
    List<String> lisst = [];
    menuItemsWithQuantity.forEach((element) {
      lisst.add('menuId = ${element.menuId} , qty = ${element.quantity}');
    });
  }

  void updateKitchenName({required String newKitchenName}) {
    _kitchenName = newKitchenName;
  }

  int getCartTotalItemCount() {
    int total = 0;
    for (var item in _menuItemsWithQuantity) {
      total += item.quantity;
    }
    return total;
  }

  int getCartTotalPrice() {
    int total = 0;
    for (var item in _menuItemsWithQuantity) {
      total += item.quantity * item.price;
    }
    return total;
  }

  Future<BeanAddCart> addToMenuItemsWithQuantity({
    required String menuId,
    required String kitchenId,
    required int price,
    required String kitchenName,
    required CartCountModel cartCountProvider,
    required PreorderProvider preorderProvider,
    required CartScreenModel cartModelProvider,
  }) async {
    final res = await cartModelProvider.addToCart(
      quantityType: "1",
      kitchenId: kitchenId,
      menuID: menuId,
    );
    if (res.status!) {
      _menuItemsWithQuantity.add(
        MenuItemWithQuantityModel(quantity: 1, menuId: menuId, price: price),
      );
      updateKitchenName(newKitchenName: kitchenName);
      cartCountProvider.checkCartCount(provider: preorderProvider);

      prints();
      notifyListeners();
      return res;
    }
    return res;
  }

  Future<BeanAddCart> addToMenuItemsWithQuantityWithoutLogin({
    required String menuId,
    required String kitchenId,
    required int price,
    required String kitchenName,
    required CartCountModel cartCountProvider,
    required PreorderProvider preorderProvider,
    required CartScreenModel cartModelProvider,
  }) async {
    final res = await cartModelProvider.addToCartWithoutLogin(
      mealPlan: "trial",
      quantityType: "1",
      kitchenId: kitchenId,
      forSubscription: false,
      menuID: menuId,
    );
    if (res.status!) {
      _menuItemsWithQuantity.add(
        MenuItemWithQuantityModel(quantity: 1, menuId: menuId, price: price),
      );
      updateKitchenName(newKitchenName: kitchenName);
      cartCountProvider.checkCartCount(provider: preorderProvider);

      prints();
      notifyListeners();
      return res;
    }
    return res;
  }

  int getCountOfParticularMenuItemWithQuantity({
    required String menuId,
  }) {
    int quantity = 0;
    for (var item in menuItemsWithQuantity) {
      if (item.menuId == menuId) {
        quantity = item.quantity;
        break;
      }
    }
    return quantity;
  }

  void increaseMenuItemsWithQuantity({
    required String menuId,
    required String kitchenId,
    required String kitchenName,
    required CartCountModel cartCountProvider,
    required PreorderProvider preorderProvider,
    required CartScreenModel cartModelProvider,
  }) async {
    final res = await cartModelProvider.addToCart(
      quantityType: "1",
      kitchenId: kitchenId,
      menuID: menuId,
    );
    if (res.status!) {
      menuItemsWithQuantity.forEach((item) {
        if (item.menuId == menuId) {
          item.quantity =
              item.quantity + 1; // Update the quantity to your desired value
        }
      });
      updateKitchenName(newKitchenName: kitchenName);

      cartCountProvider.checkCartCount(provider: preorderProvider);
    }

    prints();
    notifyListeners();
  }

  void increaseMenuItemsWithQuantityWithoutLogin({
    required String menuId,
    required String kitchenId,
    required String kitchenName,
    required CartCountModel cartCountProvider,
    required PreorderProvider preorderProvider,
    required CartScreenModel cartModelProvider,
  }) async {
    final res = await cartModelProvider.addToCartWithoutLogin(
      mealPlan: 'trial',
      quantityType: "1",
      kitchenId: kitchenId,
      menuID: menuId,
      forSubscription: false,
    );
    if (res.status!) {
      menuItemsWithQuantity.forEach((item) {
        if (item.menuId == menuId) {
          item.quantity =
              item.quantity + 1; // Update the quantity to your desired value
        }
      });
      updateKitchenName(newKitchenName: kitchenName);

      cartCountProvider.checkCartCount(provider: preorderProvider);
    }

    prints();
    notifyListeners();
  }
  //

  void increaseMenuItemsWithQuantityProvider({
    required String menuId,
    required String kitchenName,
    required CartCountModel cartCountProvider,
    required PreorderProvider preorderProvider,
  }) async {
    menuItemsWithQuantity.forEach((item) {
      if (item.menuId == menuId) {
        item.quantity =
            item.quantity + 1; // Update the quantity to your desired value
      }
    });
    cartCountProvider.checkCartCount(provider: preorderProvider);

    prints();
    notifyListeners();
  }

  //
  void clearMenuItemsWithQuantityList() async {
    _menuItemsWithQuantity.clear();
    updateKitchenName(newKitchenName: '');

    notifyListeners();
  }

  void decreaseMenuItemsWithQuantity({
    required String menuId,
    required String kitchenId,
    required CartCountModel cartCountProvider,
    required CartScreenModel cartModelProvider,
    required PreorderProvider preorderProvider,
  }) async {
    final res = await cartModelProvider.addToCart(
      quantityType: "2",
      kitchenId: kitchenId,
      menuID: menuId,
    );

    if (res.status!) {
      List<MenuItemWithQuantityModel> copyList =
          List.from(menuItemsWithQuantity);

      for (var item in copyList) {
        if (item.menuId == menuId) {
          if (item.quantity == 1) {
            menuItemsWithQuantity
                .removeWhere((element) => element.menuId == item.menuId);
          } else {
            item.quantity =
                item.quantity - 1; // Update the quantity to your desired value
          }

          cartCountProvider.checkCartCount(provider: preorderProvider);
        }
      }
      prints();

      notifyListeners();
    }
  }

  void decreaseMenuItemsWithQuantityWithoutLogin({
    required String menuId,
    required String kitchenId,
    required CartCountModel cartCountProvider,
    required CartScreenModel cartModelProvider,
    required PreorderProvider preorderProvider,
  }) async {
    final res = await cartModelProvider.addToCartWithoutLogin(
      mealPlan: 'trial',
      quantityType: "2",
      kitchenId: kitchenId,
      forSubscription: false,
      menuID: menuId,
    );

    if (res.status!) {
      List<MenuItemWithQuantityModel> copyList =
          List.from(menuItemsWithQuantity);

      for (var item in copyList) {
        if (item.menuId == menuId) {
          if (item.quantity == 1) {
            menuItemsWithQuantity
                .removeWhere((element) => element.menuId == item.menuId);
          } else {
            item.quantity =
                item.quantity - 1; // Update the quantity to your desired value
          }

          cartCountProvider.checkCartCount(provider: preorderProvider);
        }
      }
      prints();

      notifyListeners();
    }
  }

  void decreaseMenuItemsWithQuantityProvider({
    required String menuId,
    bool toRemove = false,
    required CartCountModel cartCountProvider,
    required PreorderProvider preorderProvider,
  }) async {
    List<MenuItemWithQuantityModel> copyList = List.from(menuItemsWithQuantity);

    for (var item in copyList) {
      if (item.menuId == menuId) {
        if (item.quantity == 1 || toRemove) {
          menuItemsWithQuantity
              .removeWhere((element) => element.menuId == item.menuId);
        } else {
          item.quantity =
              item.quantity - 1; // Update the quantity to your desired value
        }
        cartCountProvider.checkCartCount(provider: preorderProvider);
      }
    }
    prints();

    notifyListeners();
  }
}
