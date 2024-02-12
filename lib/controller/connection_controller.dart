// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
//
// class InternetConnection extends ChangeNotifier {
//   var failed = false;
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//
//   update() {
//     initConnectivity();
//     _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     notifyListeners();
//   }
//
//   Future initConnectivity() async {
//     late ConnectivityResult result;
//     result = await _connectivity.checkConnectivity();
//     return _updateConnectionStatus(result);
//   }
//
//   Future _updateConnectionStatus(ConnectivityResult result) async {
//     _connectionStatus = result;
//     notifyListeners();
//     if(result.name.toString()=='none'){
//       failed = true;
//       notifyListeners();
//     }else{
//       failed = false;
//       notifyListeners();
//
//     }
//
//   }
// }
