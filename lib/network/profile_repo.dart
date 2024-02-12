import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/model/login.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/Profile/get_profile.dart';
import '../model/update_profile_model.dart';
import '../utils/Utils.dart';
import '../utils/constants/app_constants.dart';
import '../utils/pref_manager.dart';
import 'api_provider.dart';
import 'end_points.dart';

class ProfileModel extends ChangeNotifier {
  final log = Logger();
  Future<GetProfile?> getProfile() async {
    UserPersonalInfo beanLogin = await Utils.getUser();
    print("  beanlogin ${beanLogin.id}");
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getMyProfile}"),
        body: {"user_id": beanLogin.id, "token": "123456789"});

    if (response.statusCode == 200) {
      GetProfile profile = GetProfile.fromJson(
        json.decode(response.body),
      );
      final userPersonalInfo = UserPersonalInfo(
          id: profile.data!.first.userId,
          username: profile.data!.first.username,
          mobilenumber: profile.data!.first.mobileNumber,
          email: profile.data!.first.email,
          referalCode: profile.data!.first.referralCode);
      PrefManager.putString(
        AppConstant.userProfile,
        jsonEncode(userPersonalInfo),
      );

      return profile;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<UpdateProfileModel?> updateProfile(
      String email, String name, String mobileNumber, String image) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    var request =
        http.MultipartRequest("POST", Uri.parse("$baseUrl/update_profile.php"));
    print("$baseUrl/update_profile.php");
    print(request.fields['user'] = name);
    print(request.fields['user_id'] = userPersonalInfo.id.toString());
    print(request.fields['email'] = email);
    print(request.fields["mobile_number"] = mobileNumber);
    request.fields['user'] = name;
    request.fields['token'] = "123456789";
    request.fields['user_id'] = userPersonalInfo.id.toString();
    request.fields['email'] = email;
    request.fields["mobile_number"] = mobileNumber;
    request.files.add(http.MultipartFile('profile_image',
        File(image).readAsBytes().asStream(), File(image).lengthSync(),
        filename: image.split("/").last));
    request.send().then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        // return UpdateProfileModel.fromJson(
        //   json.decode(response.),
        // );
        return response;
      } else {
        throw Exception("Something went wrong");
      }
    });
    return null;
  }
}
