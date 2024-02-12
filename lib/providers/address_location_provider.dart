import 'package:flutter/material.dart';

class AddressLocationProvider extends ChangeNotifier {
  String _area = "Home";
  String _address = "Address";
  String get getArea => _area;
  String get getAddress => _address;
  void updateArea(String newArea) {
    _area = newArea;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    _address = newAddress;
    notifyListeners();
  }
}
