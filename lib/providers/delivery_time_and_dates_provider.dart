import 'package:flutter/material.dart';

class DeliveryTimeDateProvider extends ChangeNotifier {
  String _selectedTime = "";
  String _selectedDate = "";
  String get selectedDate => _selectedDate;
  String get selectedTime => _selectedTime;
  bool _isSatSelected = true;
  bool _isSunSelected = true;
  bool get isSatSelected => _isSatSelected;
  bool get isSunSelected => _isSunSelected;
  void updateDate(String newDate) {
    _selectedDate = newDate;
    notifyListeners();
  }

  void updateTime(String newTime) {
    _selectedTime = newTime;
    notifyListeners();
  }

  void updateIsSatSelected(bool value) {
    _isSatSelected = value;
    notifyListeners();
  }

  void updateIsSunSelected(bool value) {
    _isSunSelected = value;
    notifyListeners();
  }
}
