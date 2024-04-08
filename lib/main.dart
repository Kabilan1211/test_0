// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_0/Cloud/Auth.dart';
import 'package:test_0/Cloud/database.dart';
import 'package:test_0/Cloud/messaging.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/pages/help.dart';
import 'package:test_0/pages/navbar.dart';
import 'package:test_0/pages/splash.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_0/pages/notification.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:audioplayers/audioplayers.dart';

void main() async {

  // This function will ensure these functions are working before the application is started
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApijob().initNotifications();
  runApp(const MyApp());
  fetchLast5Data();
}

final FirebaseApijob firebaseApi = FirebaseApijob();
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

String lastTitle = "";
String lastBody = "";
String lastTime = "";

// This is the source code for playing the sound. By calling this function, the sound will be played
Future<void> playSound() async {
  AudioCache cache = AudioCache();
  const soundPath = "alert.mp3"; // Provide the path to your audio file
  await cache.play(soundPath);
}

// This is the function which handles the background notification
Future<void> handleBackgroundMessaging(RemoteMessage message) async {
  await Firebase.initializeApp();

  // This line triggers the notification
  NotificationClass.showBigTextNotification(
      title: lastTitle, body: lastBody, fln: flutterLocalNotificationsPlugin);
  // This function is used to play the sound
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

  // This function is used to navigate the user to homepage whenever this function is called
  void homeRoute() {
    navigatorKey.currentState?.pushNamed('/home');
  }

  // This function will run when the screen is refreshed
  Future<void> refresh() {
    return Future.delayed(const Duration(seconds: 1), homeRoute);
  }

  // This function will be used to signout the user whenever this function is called and navigate the user to log out
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

    // This is the front end design of the home page
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

                  // Used for Debugging purposes
                  // ElevatedButton(onPressed: (){
                  //   UserModel user = UserModel(name: "Kabilan S", email: "test@gmail.com", password: "123456789@Ii", resetPassState: 1);
                  //   fetchData("kabisaravanan12@gmail.com");
                  //   updateData();
                  //   userRepo.createUser(user);
                  //   fetchLast5Data();

                  // }, child: const Text("Add User"))
                ],
              ),
            ]),
      ),
    );
  }

  // This is function which returns the widget, this widget is used to display the user details in a tile
  Widget content(String title, String body, String time) {

    // If this condition is true, then it will return the tile. Else it will return nothing
    if (title != "") {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(time, style: const TextStyle(color: Colors.blue))
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

              // This code is used to navigate the user to the specific url when the user touched the tile
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
