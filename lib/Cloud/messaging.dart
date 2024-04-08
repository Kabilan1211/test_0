// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_0/Cloud/database.dart';
import 'package:test_0/main.dart';
import 'package:test_0/pages/notification.dart';

// This page contains code to display the notification

// Function used to get the push notification token and to display the notification in the application.

String title1 = "";
String title2 = "";
String title3 = "";
String title4 = "";
String title5 = "";
String body1 = "";
String body2 = "";
String body3 = "";
String body4 = "";
String body5 = "";
String time1 = "";
String time2 = "";
String time3 = "";
String time4 = "";
String time5 = "";

    void _handleApp(RemoteMessage message) {
      print("On Message Opened");
      fetchLast5Data();
      navigatorKey.currentState?.pushNamed('/help');
    }

class FirebaseApijob {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void NotificationSetting() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User Granted permission: ${settings.authorizationStatus}');
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");

    // final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen(_handleApp);
    FirebaseMessaging.onBackgroundMessage((handleBackgroundMessaging));
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        lastTitle = message.notification!.title ?? "";
        lastBody = message.notification!.body ?? "";
        lastTime = DateTime.now().toString();
        await NotificationClass.showBigTextNotification(
          title: message.notification!.title ?? "",
          body: message.notification!.body ?? "",
          fln: flutterLocalNotificationsPlugin,
        );
        fetchLast5Data();
        playSound();
      } else {
        print("Message doesn't contains any notification");
      }
    });


  }
}
