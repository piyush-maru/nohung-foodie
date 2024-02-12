import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  bool _isWalletActive = false;
  bool get isWalletActive => _isWalletActive;

  void updateWhetherWalletActive({bool? value}) {
    _isWalletActive = value ?? !_isWalletActive;
    notifyListeners();
  }
}
