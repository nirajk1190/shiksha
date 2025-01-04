import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  Stream<String>? tokenStream;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future initialise() async {
    // Setup Firebase
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .requestPermission(alert: true, badge: true, sound: true);
    }

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        debugPrint(
            'AppPush ===================getInitialMessage : ${message.data}');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('AppPush ===================onMessage : ${message.data}');
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'AppPush ===================onMessageOpenedApp : ${message.data}');
    });


    tokenStream = FirebaseMessaging.instance.onTokenRefresh;
  }
  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

}
