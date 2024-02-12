import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/utils/constants/app_constants.dart';
import 'package:food_app/utils/pref_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/login.dart';

class Utils {
/*
  /// REQUEST AUDIO PERMISSION
  Future<bool> requestAudioPermission(BuildContext context) async {
    /// status can either be: granted, denied, restricted or permanentlyDenied
    var status = await Permission.audio.status;
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      if (await Permission.audio.request().isGranted) {
        return true;
      }
    }
    if (await Permission.audio.request().isPermanentlyDenied) {
      openAppSettings();

      Navigator.pop(context);
      return false;
    }
    return false;
  }
*/

  static LinearGradient gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.05, 0.9],
      colors: [Color(0xffEFEFEF)]);

  static shareContent(String msg) {
    Share.share(msg, subject: 'Look at this!!');
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  static Widget getLoader() {
    return const CircularProgressIndicator();
  }

  static void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => "${match.group(0)}");
  }

  static Future<UserPersonalInfo> getUser() async {
    var data = await PrefManager.getString(AppConstant.userProfile);
    printWrapped(json.encode(data));
    return UserPersonalInfo.fromJson(json.decode(data));
  }
}
