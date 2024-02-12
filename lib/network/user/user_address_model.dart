import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/address/default_address.dart';
import '../../model/address/get_user_address_details.dart';
import '../../model/login.dart';
import '../../model/user/user_address_list.dart';
import '../../utils/Utils.dart';

class UserAddressModel extends ChangeNotifier {
  String _addressType = "";
  String _address = "";
  String get getAddressType => _addressType;
  String get getAddress => _address;
  void updateAddressType(String newAddressType) {
    _addressType = newAddressType;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    _address = newAddress;
    notifyListeners();
  }

  /// GET AND SET DEFAULT ADDRESS IN PROVIDER SO WE DON'T HAVE TO FETCH IT AGAIN AND AGAIN
  Future<void> storeDefaultAddress() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getDefaultAddress}"),
        body: {"token": "123456789", "user_id": userPersonalInfo.id});
    if (response.statusCode == 200) {
      if (json.decode(response.body)['data'].length == 0) {
      } else {
        final formattedResponse =
            DefaultAddress.fromJson(json.decode(response.body));
        updateAddress(formattedResponse.data.first.address);
        updateAddressType(formattedResponse.data.first.addressType);
      }
    } else {
      throw Exception("Something went wrong");
    }
  }

  UserAddressList? getUserAddressDetails;
  final List<UserAddressList> _addressDetails = [];

  List<UserAddressList> address() => _addressDetails;

  Future<UserAddressList> getUserAddress() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getAddressList}"),
        body: {"token": "123456789", "user_id": userPersonalInfo.id});

    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body);

      if (!resBody["status"]) {
        return UserAddressList(
            data: UserAddressListData(home: [], office: [], other: []),
            message: resBody["message"],
            status: resBody["status"]);
      }

      UserAddressList addressDetails =
          UserAddressList.fromJson(jsonDecode(response.body));
      _addressDetails.clear();

      return addressDetails;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<List<UserLocationTypes>> searchAddress(String searchQuery) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getAddressList}"),
        body: {"token": "123456789", "user_id": userPersonalInfo.id});

    if (response.statusCode == 200) {
      final resBody = jsonDecode(response.body);
      final log = Logger();
      if (!resBody["status"]) {
        final List<UserLocationTypes> userLocationTypes = [];
        return userLocationTypes;
      }

      UserAddressList addressDetails =
          UserAddressList.fromJson(jsonDecode(response.body));
      final List<UserLocationTypes> userLocationTypes = [
        ...addressDetails.data.other,
        ...addressDetails.data.office,
        ...addressDetails.data.home
      ];
      final List<UserLocationTypes> searchedAddressDetails = userLocationTypes
          .where((e) =>
              e.address.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      log.f(searchedAddressDetails);
      return searchedAddressDetails;
    } else {
      throw Exception("Something went wrong");
    }
    notifyListeners();
  }

  Future deleteAddress(String addressId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    print("$baseUrl/${EndPoints.deleteAddress}");
    print({
      "userid": userPersonalInfo.id,
      "token": "123456789",
      'address_id': addressId
    });
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.deleteAddress}"), body: {
      "userid": userPersonalInfo.id,
      "token": "123456789",
      'address_id': addressId
    });
    if (response.statusCode == 200) {
      notifyListeners();
      return json.decode(response.body);
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<GetUserAddressDetails> getAddressInDetail(String addressId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getAddressDetails}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "address_id": addressId
    });
    if (response.statusCode == 200) {
      GetUserAddressDetails addressDetails =
          GetUserAddressDetails.fromJson(jsonDecode(response.body));
      _addressDetails.clear();
      //_addressDetails.addAll(addressDetails.details ?? []);
      notifyListeners();
      return addressDetails;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<DefaultAddress> getDefaultAddress() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getDefaultAddress}"),
        body: {"token": "123456789", "user_id": userPersonalInfo.id});
    if (response.statusCode == 200) {
      if (json.decode(response.body)['data'].length == 0) {
        return DefaultAddress(
            status: json.decode(response.body)['status'],
            message: json.decode(response.body)['message'],
            data: []);
      }
      return DefaultAddress.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> makeAddressDefault(String addressId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    print({
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "address_id": addressId
    });

    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.setDefaultAddress}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "address_id": addressId
    });

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception("Something went wrong");
    }
    return response;
  }
}
