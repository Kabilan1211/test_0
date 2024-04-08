// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_0/Cloud/database.dart';
import 'package:test_0/main.dart';
import 'package:test_0/pages/notification.dart';

// This page contains code to display the notification


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

// It is the class which contains the functions used to get the push notification token and to display the notification in the application.
class FirebaseApijob {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Function to check the notification permission for the application
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

  // This function is used to initialize the FCM service
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token: $fCMToken");

    // This function is used to display the notification when the application is in background
    FirebaseMessaging.onBackgroundMessage((handleBackgroundMessaging));

    // This function is used to display the notification when the application is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        // Function which trigger the notification
        await NotificationClass.showBigTextNotification(
          title: message.notification!.title ?? "",
          body: message.notification!.body ?? "",
          fln: flutterLocalNotificationsPlugin,
        );

        // Updating the last 5 alerts
        fetchLast5Data();

        // playing the alarm sound
        playSound();
      } else {
        print("Message doesn't contains any notification");
      }
    });
  }
}
