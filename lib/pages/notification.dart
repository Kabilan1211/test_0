// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationClass{
 static Future initiliaze (FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async{
  var androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher');
  var initializationSettings = new InitializationSettings(android: androidInitialize);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
 }

 static Future showBigTextNotification(
 {var id = 0, required String title, required String body, var payload, required FlutterLocalNotificationsPlugin fln}
 ) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics = new AndroidNotificationDetails(
     'test_0',
     'channel_name',
     playSound: true,
     importance: Importance.max,
     priority: Priority.high
     
     );
     var noti = NotificationDetails(android: androidPlatformChannelSpecifics);
     await fln.show(0, title, body, noti);
     
 }
}