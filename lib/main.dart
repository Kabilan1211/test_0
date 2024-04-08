// ignore_for_file: avoid_print, unused_import, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_0/Cloud/Auth.dart';
import 'package:test_0/Cloud/database.dart';
import 'package:test_0/Cloud/messaging.dart';
import 'package:test_0/Model/UserModel.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/pages/help.dart';
import 'package:test_0/pages/navbar.dart';
import 'package:test_0/pages/splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_0/pages/notification.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/link.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApijob().initNotifications();
  runApp(const MyApp());
  fetchLast5Data();
}

final FirebaseApijob firebaseApi = FirebaseApijob();
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
String lastTitle = "";
String lastBody = "";
String lastTime = "";

Future<void> playSound() async {
  AudioCache cache = AudioCache();
  const soundPath = "alert.mp3"; // Provide the path to your audio file
  await cache.play(soundPath);
}

Future<void> handleBackgroundMessaging(RemoteMessage message) async {
  await Firebase.initializeApp();
  lastTime = DateTime.now().toString();
  lastTitle = message.notification!.title ?? "";
  lastBody = message.notification!.title ?? "";
  NotificationClass.showBigTextNotification(
      title: lastTitle, body: lastBody, fln: flutterLocalNotificationsPlugin);
  playSound();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/home': (context) => const MyHomePage(),
        '/help': (context) => const HelpPage()
      },
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
  final AuthService _auth = AuthService();
  final UserRepo userRepo = UserRepo();

  void homeRoute() {
    navigatorKey.currentState?.pushNamed('/home');
  }

  Future<void> refresh() {
    return Future.delayed(const Duration(seconds: 1), homeRoute);
  }

  void _signoutUser() {
    _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => const LoginPage())));
  }

  @override
  void initState() {
    super.initState();
    NotificationClass.initiliaze(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text("TEST"),
        actions: [
          IconButton(
              onPressed: () {
                _signoutUser();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: ListView(
            padding: EdgeInsets.fromLTRB(
                10, MediaQuery.of(context).size.height * 0.175, 10, 50),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  content(title1, body1, time1),
                  const SizedBox(
                    height: 20,
                  ),
                  content(title2, body2, time2),
                  const SizedBox(
                    height: 20,
                  ),
                  content(title3, body3, time3),
                  const SizedBox(
                    height: 20,
                  ),
                  content(title4, body4, time4),
                  const SizedBox(
                    height: 20,
                  ),
                  content(title5, body5, time5),
                  const SizedBox(
                    height: 20,
                  ),

                  // // Used for Debugging purposes
                  // ElevatedButton(onPressed: (){
                  // //   UserModel user = UserModel(name: "Kabilan S", email: "test@gmail.com", password: "123456789@Ii", resetPassState: 1);
                  // //   fetchData("kabisaravanan12@gmail.com");
                  // //   updateData();
                  // //   userRepo.createUser(user);
                  // //   fetchLast5Data();

                  // }, child: const Text("Add User"))
                ],
              ),
            ]),
      ),
    );
  }

  Widget content(String title, String body, var time) {
    if (title != "") {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(time.toString(), style: const TextStyle(color: Colors.blue))
          ]),
        ),
        Card(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          elevation: 2,
          child: ListTile(
            tileColor: Colors.blue.shade100,
            minVerticalPadding: 20,
            title: Text(title),
            onTap: () async {
              await launchUrlString(body, mode: LaunchMode.externalApplication);
            },
          ),
        ),
      ]);
    } else {
      return const SizedBox(
        height: 0,
      );
    }
  }
}
