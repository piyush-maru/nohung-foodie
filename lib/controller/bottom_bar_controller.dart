import 'package:flutter/cupertino.dart';

class BottomBarController extends ChangeNotifier{

  int selectedIndex = 0;
  update(index){
    selectedIndex = index;
    notifyListeners();
  }
}