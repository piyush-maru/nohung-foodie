import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'constants/app_constants.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  String pay = jsonEncode({
    'deeplink': message.data['deeplink'].toString(),
    'deeplinkId': message.data['deeplink_id'].toString(),
    'messageId': message.messageId
  });

  print(message.data);
  print(pay);
  print(message.notification);
  showNotification(message.data, pay, flutterLocalNotificationsPlugin);
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print("nikhil notificationTapBackground");
}

void showNotification(message, payload, flutterLocalNotificationsPlugin) async {
  final BigTextStyleInformation bigTextStyleInformation =
      BigTextStyleInformation(message['message'],
          htmlFormatTitle: true,
          htmlFormatBigText: true,
          htmlFormatContent: true,
          contentTitle: "Nohung Kitchen",
          htmlFormatContentTitle: true,
          summaryText: message['category'] == "trial"
              ? "New Order"
              : message['category'] == "package"
                  ? "New Subscription"
                  : "Upcoming Order",
          htmlFormatSummaryText: true);
  var androidPlatformChannelSpecifics =
      new AndroidNotificationDetails('com.nohung_kitchen', 'Nohung',
          channelDescription: 'nohung kitchen push notification',
          playSound: true,
          enableVibration: true,
          autoCancel: false,
          ongoing: true,
          category: AndroidNotificationCategory.call,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          sound: RawResourceAndroidNotificationSound('subscription'),
          importance: Importance.max,
          icon: "@mipmap/notification_icon",
          color: AppConstant.appColor,
          // additionalFlags: Int32List.fromList(<int>[4]),
          priority: Priority.max,
          enableLights: true,
          actions: [
            AndroidNotificationAction(
              "replyButtonId",
              "Close",
            ),
          ],
          styleInformation: bigTextStyleInformation);

  var platformChannelSpecifics =
      new NotificationDetails(android: androidPlatformChannelSpecifics);
  final microsecondsSinceEpoch = DateTime.now().microsecondsSinceEpoch;
  final randomUniqueChannelID = microsecondsSinceEpoch % 10000;
  await flutterLocalNotificationsPlugin.show(randomUniqueChannelID,
      "Nohung Kitchen", message['message'], platformChannelSpecifics,
      payload: payload);
}
