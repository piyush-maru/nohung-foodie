import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../model/login.dart';
import '../../model/orders/get_order_history_detail.dart';
import '../../model/orders/update_order_items_model.dart';
import '../../model/user/user_address_list.dart';
import '../../utils/Utils.dart';
import '../api_provider.dart';
import '../end_points.dart';

class UpdateActiveOrdersCustomizationMenuItemsModel extends ChangeNotifier {
  UpdateOrderItemDetailsModel? updateOrderItemDetailsModel;

  Future<http.Response> updateOrderItems(
      {required OrderDetailsModel orderDetailsModel,
      UserLocationTypes? userLocation}) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response;
    if (userLocation != null) {
      response = await http.post(
          Uri.parse("$baseUrl/${EndPoints.updateOrderItemsDetails}"),
          body: {
            "token": "123456789",
            "user_id": userPersonalInfo.id,
            "order_id": orderDetailsModel.orderId,
            "order_item_id": orderDetailsModel.items?.first.orderItemId,//orderDetailsModel.orderItemsId
            "delivery_address": "",//orderDetailsModel.deliveryAddress
            "delivery_latitude": userLocation.latitude,
            "delivery_longitude": userLocation.longitude,
            "delivery_fromtime": orderDetailsModel.items?.first.deliveryFromtime,//orderDetailsModel.deliveryFromTime
            "delivery_totime": orderDetailsModel.items?.first.deliveryTotime,//orderDetailsModel.deliveryToTime
            "description": "",//orderDetailsModel.description
            // "customisable_items": jsonEncode(customizationItems),
            // "iswalletchecked": isWalletChecked,
          });
    } else {
      response = await http.post(
          Uri.parse("$baseUrl/${EndPoints.updateOrderItemsDetails}"),
          body: {
            "token": "123456789",
            "user_id": userPersonalInfo.id,
            "order_id": orderDetailsModel.orderId,
            "order_item_id": orderDetailsModel.items?.first.orderItemId,//orderDetailsModel.orderItemsId
            "delivery_address": "",//orderDetailsModel.deliveryAddress
            "delivery_fromtime": orderDetailsModel.items?.first.deliveryFromtime,
            "delivery_totime": orderDetailsModel.items?.first.deliveryTotime,
            "description": "",//orderDetailsModel.description
          });
    }

    if (response.statusCode == 200) {
      print(response.body);
      // UpdateOrderItemDetailsModel itemDetailsModel =
      //     UpdateOrderItemDetailsModel.fromJson(jsonDecode(response.body));

      return response;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<http.Response> createTransaction(
      String orderId,
      String orderNumber,
      String transactionId,
      String amount,
      String paymentType,
      String postData,
      String paymentMethod) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.createTransaction}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "order_id": orderId,
      "ordernumber": orderNumber,
      "transaction_id": transactionId,
      "amount": amount,
      "payment_type": paymentType,
      "post_data": postData,
      "payment_method": paymentMethod,
    });

    if (response.statusCode == 200) {
    } else {
      throw Exception("Something went wrong");
    }
    return response;
  }

  Future<http.Response> transactionSuccess(String transactionId) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.successTransaction}"), body: {
      "token": "123456789",
      "txnid": transactionId,
      "user_id": userPersonalInfo.id
    });
    if (response.statusCode == 200) {
    } else {
      throw Exception("Something went wrong");
    }
    return response;
  }
}
