import 'package:flutter/material.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/utils/Utils.dart';

import '../../model/profile/complete_profile_model.dart';

class NameScreenProvider extends ChangeNotifier {
  enterNameEmail(String email, String name, context) async {
    CompleteProfile? bean =
        await ApiProvider().completeProfileHttp(email, name);
    if (bean?.status == true) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      return bean;
    } else {
      Utils.showToast(
        bean!.message.toString(),
      );
    }
    return null;
  }
}
