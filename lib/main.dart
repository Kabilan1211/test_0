// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_0/Cloud/messaging.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/pages/navbar.dart';
import 'package:test_0/pages/splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_0/pages/notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

  Future<void> handleBackgroundMessaging(RemoteMessage message) async {
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Payload: ${message.data}");
    lastTitle = message.notification!.title ?? "";
    lastBody = message.notification!.title ?? "";
  }

  String lastTitle = "";
  String lastBody = "";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _signoutUser(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const LoginPage())));
  }

  @override 
  void initState(){
    super.initState();
    NotificationClass.initiliaze(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
       backgroundColor: Colors.deepPurple.shade200,
       title: const Text("TEST"),
       actions: [IconButton(onPressed: (){_signoutUser();}, icon: const Icon(Icons.logout))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "From Now onwards, you will be receiving notifications from us",
            ),
          ],
        ),
      ),
    );
  }
}
