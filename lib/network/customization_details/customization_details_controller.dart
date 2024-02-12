import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';

import '../../model/customization_details/customization_details.dart';

class CustomizationDetailsController extends ChangeNotifier {
  var isLoading = false;
  final ApiProvider _apiProvider = ApiProvider();
  int numberOfItems = 0;

  List<CustomizationData> _customizationData = [];

  List<CustomizationData> get customizationData => _customizationData;

  CustomizationDetails? _customizationDetails;

  CustomizationDetails? get customizationDetails => _customizationDetails!;

  List<MenuitemsOfData> menuItems = [];

  addToMenuItemToShow(item) {
    menuItems2.add(item);
    notifyListeners();
  }

  List<MenuitemsOfData> menuItems2 = [];

  remove(index) {
    menuItems2.remove(index);
    notifyListeners();
  }

  clear() {
    menuItems2.clear();
    finalMenuItem.clear();
    notifyListeners();
  }

  updateItem() {
    for (var a = 0; a < customizationData[0].menuitems.length; a++) {
      if (customizationData[0].menuitems[a].qty >= 1) {
        menuItems2.add(customizationData[0].menuitems[a]);
        sendListToApi();
        notifyListeners();
      }
    }
  }

  getPackageCustomizableItemHttp(
    packageId,
    weeklyPackageId,
  ) async {
    isLoading = true;
    notifyListeners();
    List<CustomizationData> data = await _apiProvider
        .getPackageCustomizableItemHttp(
      packageId,
      weeklyPackageId,
    )
        .then((value) {
      value!.data;
      if (value.data.isNotEmpty) {
        _customizationData = value.data;
        notifyListeners();
        menuItems = value.data[0].menuitems;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
      return value.data;
    });
  }

  var finalMenuItem = [];

  sendListToApi() {
    for (var a = 0; a < menuItems2.length; a++) {
      Map<String, dynamic> sendingListItemsData = {
        "menu_id": menuItems2[a].menuId.toString(),
        "itemname": menuItems2[a].itemName.toString(),
        "itemprice": menuItems2[a].itemPrice.toString(),
        "quantity": menuItems2[a].qty,
      };
      if (finalMenuItem.contains(sendingListItemsData)) {
      } else {
        finalMenuItem.add(sendingListItemsData);
        notifyListeners();
      }
    }
  }

  addCustomizedPackageItemHttp(packageId, weeklyPackageId, menuItems) async {
    isLoading = true;
    notifyListeners();

    _apiProvider
        .addCustomizedPackageItemHttp(packageId, weeklyPackageId, finalMenuItem)
        .then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  increase(i, index) {
    customizationData[i].menuitems[index].qty++;
    notifyListeners();
    menuItems2.add(customizationData[i].menuitems[index]);
    notifyListeners();
    sendListToApi();
  }

  decrease(i, index) {
    if (customizationData[i].menuitems[index].qty == 0) {
      customizationData[i].menuitems[index].qty = 0;
      notifyListeners();
    } else {
      customizationData[i].menuitems[index].qty--;
      notifyListeners();
      sendListToApi();
      if (customizationData[i].menuitems[index].qty == 0) {
        if (menuItems2.contains(customizationData[i].menuitems[index])) {
          menuItems2.remove(customizationData[i].menuitems[index]);
          finalMenuItem.remove(customizationData[i].menuitems[index]);
          notifyListeners();
        }
      }
    }
  }
}
