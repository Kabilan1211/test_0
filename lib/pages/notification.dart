// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_0/main.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[WidgetCard(title: lastTitle, body: lastBody)],
          ),
        ),
      ),
    );
  }
}

class WidgetCard extends StatefulWidget {
  const WidgetCard({super.key, required this.title, required this.body});
  final String title;
  final String body;

  @override
  State<WidgetCard> createState() => _WidgetCardState();
}

class _WidgetCardState extends State<WidgetCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2, margin: const EdgeInsets.all(2), child: content());
  }

  Widget content() {
    DatabaseReference title = FirebaseDatabase.instance.ref().child('Title');
    title.onValue.listen(((event) {
      DatabaseReference body = FirebaseDatabase.instance.ref().child('Body');
      body.onValue.listen(((event) {
        setState(() {
          lastBody = event.snapshot.value.toString();
        });
      }));
      setState(() {
        lastTitle = event.snapshot.value.toString();
      });
      NotificationClass.showBigTextNotification(title: lastTitle, body: lastBody, fln: flutterLocalNotificationsPlugin);
    }));
    return ListTile(
      title: Text(lastTitle),
      subtitle: Text(lastBody),
    );
  }
}

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
    //  sound: RawResourceAndroidNotificationSound('notification'),
     importance: Importance.max,
     priority: Priority.high
     
     );
     var noti = NotificationDetails(android: androidPlatformChannelSpecifics);
     await fln.show(0, title, body, noti);
 }
}