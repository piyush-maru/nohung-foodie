import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_app/model/login.dart';
import 'package:food_app/network/api_provider.dart';
import 'package:food_app/network/end_points.dart';
import 'package:http/http.dart' as http;

import '../../model/customer_chat/receiver_messages.dart';
import '../../model/customer_chat/sender_message_model.dart';
import '../../utils/Utils.dart';

class ChatModel extends ChangeNotifier {
  ChatReceiverModel? chatReceiverModel;
  List<ChatReceiverModel> messages = [];
  Future<ChatReceiverModel> receiveMessage() async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();
    http.Response response = await http.post(
        Uri.parse("$baseUrl/${EndPoints.getMessage}"),
        body: {"token": "123456789", "userid": userPersonalInfo.id});
    if (response.statusCode == 200) {
      ChatReceiverModel receiverModel =
          ChatReceiverModel.fromJson(json.decode(response.body));

      //chatReceiverModel!.data.sort((a,b)=>b.createdDate.compareTo(a.createdDate));

      notifyListeners();
      return receiverModel;
    } else {
      throw Exception("Something went wrong");
    }
  }

  Future<ChatSenderModel> sendMessage(message) async {
    UserPersonalInfo userPersonalInfo = await Utils.getUser();

    http.Response response = await http
        .post(Uri.parse("$baseUrl/${EndPoints.sendMessage}"), body: {
      "token": "123456789",
      "userid": userPersonalInfo.id,
      "message": message
    });
    if (response.statusCode == 200) {
      ChatSenderModel chatSenderModel =
          ChatSenderModel.fromJson(json.decode(response.body));
      notifyListeners();
      return chatSenderModel;
    } else {
      throw Exception("Something went wrong");
    }
  }
}
