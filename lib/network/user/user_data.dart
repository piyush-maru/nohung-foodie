// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:food_app/network/api_provider.dart';
// import 'package:food_app/network/end_points.dart';
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
//
// import '../../model/login.dart';
// import '../../model/user/user_class.dart';
// import '../../utils/Utils.dart';
// import '../../utils/constants/app_constants.dart';
//
// class UserModel extends ChangeNotifier {
//   UserClass? userClass;
//   final List<UserClass> _userData = [];
//
//   List<UserClass> userData() => _userData;
//
//   Future<UserClass?> getUserData() async {
//     userClass ??= (await Hive.openBox<UserClass>(UserBoxName))
//         .get(UserKey, defaultValue: null);
//
//     return userClass;
//   }
//
//   Future<void> cacheUser(UserClass userClass) async {
//     await Hive.box<UserClass>(UserBoxName).put(UserKey, userClass);
//   }
//
//   Future<UserClass> user() async {
//     UserPersonalInfo userPersonalInfo = await Utils.getUser();
//     final http.Response response = await http.post(
//         Uri.parse("$baseUrl/${EndPoints.getMyProfile}"),
//         body: {"token": "123456789", "user_id": userPersonalInfo.id});
//     if (response.statusCode == 200) {
//       UserClass user0 = UserClass.fromJson(jsonDecode(response.body));
//
//       return user0;
//     } else {
//       throw Exception("Something went wrong");
//     }
//   }
// }
