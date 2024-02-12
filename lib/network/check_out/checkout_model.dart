import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/model/customized_package_detail.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/login.dart';
import '../../utils/Utils.dart';
import '../end_points.dart';

class CheckOutModel extends ChangeNotifier {
  var isLoading = false;
  final ApiProvider _apiProvider = ApiProvider();
  BeanCustomizedPackageDetail? _customizedPackageDetail;

  BeanCustomizedPackageDetail get customizedPackageDetail =>
      _customizedPackageDetail!;
  CustomizeData? _customizedPackageDetailData;

  CustomizeData? get customizedPackageDetailData =>
      _customizedPackageDetailData;

  Future<BeanCustomizedPackageDetail?> customizedPackageDetailHttp(
    String packageId,
  ) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    print({
      'token': "123456789",
      'package_id': packageId,
      'user_id': userPersonalInfo.id
    });
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getCustomisedPackageDetail}"),
        body: {
          'token': "123456789",
          'package_id': packageId,
          'user_id': userPersonalInfo.id
        });

    if (response.statusCode == 200) {
      Logger().f(jsonDecode(response.body));
      BeanCustomizedPackageDetail data =
          BeanCustomizedPackageDetail.fromJson(jsonDecode(response.body));

      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
