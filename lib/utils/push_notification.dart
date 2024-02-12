import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_app/utils/show_notification.dart';

late BuildContext ctx;

class PushNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> init(BuildContext context) async {
    ctx = context;
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.nohung_kitchen',
      'Nohung',
      description: 'nohung kitchen push notification',
      sound: RawResourceAndroidNotificationSound('subscription'),
      playSound: true,
      enableVibration: true,
      enableLights: true,
      importance: Importance.max,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/notification_icon');
    var initializationSettingsiOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsiOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        notificationClickHandle();
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((event) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("nikhil onmessga");
      firebaseMessagingBackgroundHandler(message);
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) async {
      print("nikhil getInitialMessage");

      firebaseMessagingBackgroundHandler(value!);

      final NotificationAppLaunchDetails? notificationAppLaunchDetails =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails!.didNotificationLaunchApp) {
        var payload =
            notificationAppLaunchDetails.notificationResponse!.payload;
        if (payload != null && payload.isNotEmpty) {
          Map data = jsonDecode(payload);
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<void> notificationClickHandle() async {
    print("nikhil notificationClickHandle");
  }
}
