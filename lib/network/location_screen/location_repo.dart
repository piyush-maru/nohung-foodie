import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:food_app/network/location_screen/search_location_class.dart';
import 'package:http/http.dart' as http;

import '../../model/location_screen/location_screen_modal.dart';
import '../../model/login.dart';
import '../../model/user/user_address_list.dart';
import '../../utils/Utils.dart';

class UserLocations extends ChangeNotifier {
  SearchLocationClass? searchLocationClass;
  String _addressType = "Home";
  String get addressType => _addressType;
  UserLocationTypes? _mostRecentSavedAddress;
  UserLocationTypes? get mostRecentSavedAddress => _mostRecentSavedAddress;
  void updateAddressType(String newAddressType) {
    _addressType = newAddressType;
    notifyListeners();
  }

  void updateMostRecentSavedAddress(UserLocationTypes address) {
    _mostRecentSavedAddress = UserLocationTypes(
      id: address.id,
      address: address.address,
      addressType: address.addressType,
      landmark: address.landmark,
      street: address.street,
      latitude: address.latitude,
      longitude: address.longitude,
      isDefault: address.isDefault,
    );
    notifyListeners();
  }

  Future<SearchLocationClass> searchLocation() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    print({"token": "123456789", "userid": "${userPersonalInfo.id}"});
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.searchLocation}"),
        body: {"token": "123456789", "userid": "${userPersonalInfo.id}"});
    if (response.statusCode == 200) {
      SearchLocationClass locationClass =
          SearchLocationClass.fromJson(json.decode(response.body));
      return locationClass;
    } else {
      throw Exception("something went wrong");
    }
  }

  Future<UserLocationsClass?> getUserAddressList() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getAddressList}"),
        body: {'token': "123456789", 'user_id': userPersonalInfo.id});

    if (response.statusCode == 200) {
      UserLocationsClass data =
          UserLocationsClass.fromMap(json.decode(response.body));

      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future editLocation(
      {required String addressId,
      required String location,
      required String latitude,
      required String isDefault,
      required String longitude,
      required String street,
      required String landmark,
      required String addressType}) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.editAddress}"), body: {
      "token": "123456789",
      "userid": userPersonalInfo.id,
      "address_id": addressId,
      "location": location,
      "latitude": latitude,
      "longitude": longitude,
      "street": street,
      "landmark": landmark,
      "address_type": addressType,
      "is_default_addrees": isDefault == "n" ? '0' : "1",
    });
    if (response.statusCode == 200) {
      notifyListeners();
      print(response.body);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future addNewAddress(
      {required String location,
      required bool isDefaultAddress,
      required String latitude,
      required String longitude,
      required String street,
      required String landmark,
      required String addressType}) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response =
        await http.post(Uri.parse("$baseUrl/${EndPoints.addAddress}"), body: {
      "token": "123456789",
      "userid": userPersonalInfo.id,
      "location": location,
      "latitude": latitude,
      "longitude": longitude,
      "street": street,
      "landmark": landmark,
      "address_type": addressType,
      "is_default_addrees": isDefaultAddress ? "1" : "0",
    });
    if (response.statusCode == 200) {
      notifyListeners();
      print(response.body);
    } else {
      throw Exception("Something went wrong");
    }
  }
}
