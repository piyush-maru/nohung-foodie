import 'package:flutter/material.dart';

import '../../model/update_pre_order_date_time/update_pre_order_date_time_model.dart';
import '../../presentation/widgets/snack_bar/custom_snackbar.dart';
import '../cart_repo/pre_order_model.dart';

class PreorderProvider extends ChangeNotifier {
  String _selectedTime = "";
  String _finalTime = "";
  String _selectedDate = "";
  String _selectedUnformattedDate = "";
  String _kitchenID = "";
  bool _isKitchenCloseToday = false;
  String get selectedDate => _selectedDate;
  String get selectedUnformattedDate => _selectedUnformattedDate;
  String get kitchenID => _kitchenID;
  bool get isKitchenCloseToday => _isKitchenCloseToday;
  String get selectedTime => _selectedTime;
  String get finalTime => _finalTime;
  void updateDate(String newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void resetData() {
    print('nikhilzzzz');
    _selectedTime = '';

    _selectedDate = '';

    _selectedUnformattedDate = '';
  }

  void updateUnformattedDate(String newDate) {
    _selectedUnformattedDate = newDate;
    notifyListeners();
  }

  void updateIsKitchenOffline(bool value) {
    _isKitchenCloseToday = value;
    notifyListeners();
  }

  void updateTime(String newTime) {
    _selectedTime = newTime;
    notifyListeners();
  }

  void updateTimeFinal(String newTime) {
    _finalTime = newTime;
  }

  void updateKitchenID(String id) {
    _kitchenID = id;
    notifyListeners();
  }

  Future<void> updatePreOrderDateAndTime(
      {required String kitchenId,
      required String deliveryTime,
      required BuildContext context}) async {
    List<String> timeStrings = deliveryTime.split("-");

    String startTime = timeStrings[0];
    String endTime = timeStrings[1];
    UpdatePreOrderDateTime response = await PreOrderModel()
        .updatePreOrderDateAndTime(
            kitchenId: kitchenId,
            deliveryDate: _selectedUnformattedDate,
            deliveryFromTime: startTime,
            deliveryToTime: endTime);

    if (response.status!) {
      // ScaffoldMessenger.of(context).clearSnackBars();
      // CustomSnackBarMsg(text: response.message!, context: context, time: 2);
    } else {
      // ScaffoldMessenger.of(context).clearSnackBars();
      // CustomErrorSnackBarMsg(
      //     text: response.message!, context: context, time: 2);
      // return response;
    }
  }
  // void updateIsDateAndTimeSelected(bool newValue) {
  //   _isDateAndTimeSelected = newValue;
  //   notifyListeners();
  // }
}
