import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_app/model/orders/invoice_model.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../model/login.dart';
import '../../utils/Utils.dart';

class InvoiceModel extends ChangeNotifier {
  InvoiceModelClass? invoiceModel;
  final log = Logger();

  List<InvoiceData?> invoice = [];

  Future<InvoiceModelClass> getInvoice(String orderID) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    final http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.getInvoice}"), body: {
      "token": "123456789",
      "user_id": userPersonalInfo.id,
      "order_id": orderID
    });
    log.f(jsonDecode(response.body));

    if (response.statusCode == 200) {
      InvoiceModelClass invoiceModelClass =
          InvoiceModelClass.fromJson(jsonDecode(response.body));
      invoice.clear();
      invoice.addAll(invoiceModelClass.data);
      log.f(invoiceModelClass.data.first.subscriptionPeriod);
      return invoiceModelClass;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
