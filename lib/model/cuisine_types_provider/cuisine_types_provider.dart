import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:http/http.dart' as http;

import '../../network/end_points.dart';
import '../cuisine_types_model/cuisine_types_model.dart';

class CuisineTypesProvider extends ChangeNotifier {
  Future<CuisineTypesModel> getAllCuisineTypes() async {
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getAllCuisineTypes}"), body: {
      'token': "123456789",
    });
    if (response.statusCode == 200) {
      CuisineTypesModel data =
          CuisineTypesModel.fromJson(jsonDecode(response.body));

      return data;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
