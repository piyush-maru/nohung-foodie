import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/address/get_address_list.dart';
import 'package:food_app/model/address/get_user_address.dart';
import 'package:food_app/model/location_screen/location_screen_modal.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as locationValues;

import '../../model/address/confirm_location.dart';
import '../../model/login.dart';
import '../../utils/Utils.dart';
import '../end_points.dart';

class FoodieLocationsModel extends ChangeNotifier {
  var isLoading = false;
  final ApiProvider _apiProvider = ApiProvider();
  PickResult? selectedPlace;
  List<AutocompletePrediction> predictions = [];
  final List<LocationType> _homeLocationData = [];

  List<LocationType> get homeLocationData => _homeLocationData;
  final List<LocationType> _officeLocation = [];

  List<LocationType> get officeLocation => _officeLocation;
  final List<LocationType> _otherLocation = [];

  List<LocationType> get otherLocation => _otherLocation;

  UserLocationsClass? _location;

  var selectedAddress = '';

  UserLocationsClass get location => _location!;
  late GooglePlace googlePlace;
  List<GetAddressListData> addressList = [];
  LatLng? currentPosition;
  bool loading = true;
  bool error = false;
  Future? future;
  LoginModel? user;
  String? address;
  var visible = false;
  var apiKey = "AIzaSyCBZ1E4AGu6xP_VV4GWr_qjnOte9sFmh0A";

  updateVisible() {
    visible = true;
    notifyListeners();
  }

  updateAddress(i) {
    selectedAddress = i.toString();
    notifyListeners();
  }

  changeVisible() {
    visible = !visible;
    notifyListeners();
    predictions.clear();
    notifyListeners();
  }

  clear() {
    visible = false;
    notifyListeners();
  }

  Future<GetUserAddress?> getAddressUserAddress() async {
    GetUserAddress? bean =
        await _apiProvider.getUserAddressHttp().then((value) {
      return value;
    });

    return bean;
  }

  Future getLocation() async {
    locationValues.Location location = locationValues.Location();
    locationValues.LocationData pos = await location.getLocation();
    currentPosition = LatLng(pos.latitude!, pos.longitude!);
  }

  Future<GetAddressList?> getAddress() async {
    GetAddressList? bean = await ApiProvider().getUserAddressListHttp();

    error = false;
    notifyListeners();
    loading = false;
    notifyListeners();

    if (bean!.status == true) {
      addressList = bean.data!;
      notifyListeners();

      return bean;
    } else {
      addressList = [];
      notifyListeners();
    }

    return null;
  }

  Future<BeanConfirmLocation?> saveLocation(
      String selectedPlace,
      String pinCode,
      double latitude,
      double longitude,
      String street,
      String landmark,
      String address) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    print("$baseUrl/${EndPoints.confirmLocation}");
    print({
      'token': "123456789",
      'userid': userPersonalInfo.id,
      'location': selectedPlace,
      'pincode': pinCode,
      'latitude': latitude,
      'longitude': longitude,
      'street': street,
      'landmark': landmark,
      'address_type': address
    });
    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.confirmLocation}"), body: {
      'token': "123456789",
      'userid': userPersonalInfo.id,
      'location': selectedPlace,
      'pincode': pinCode,
      'latitude': latitude,
      'longitude': longitude,
      'street': street,
      'landmark': landmark,
      'address_type': address
    });

    if (response.statusCode == 200) {
      BeanConfirmLocation data =
          BeanConfirmLocation.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    currentPosition = LatLng(position.latitude, position.longitude);

    Placemark place = placeMarks[0];

    address =
        '${place.street}, ${place.subLocality},${place.locality} ${place.postalCode}, ${place.country}';
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    notifyListeners();
    if (result != null && result.predictions != null) {
      predictions = result.predictions!;
      notifyListeners();
    }
  }

  updateSelectedPlace(result) {
    selectedPlace = result;
    notifyListeners();
  }
}
