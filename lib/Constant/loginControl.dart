// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:test_0/Cloud/Auth.dart';
import 'package:test_0/main.dart';
import 'package:test_0/pages/Login.dart';

// This page is used to check the local storage for the email and password, and then it will login the user

class LoginControl extends StatefulWidget {
  const LoginControl({super.key});

  @override
  State<LoginControl> createState() => _LoginControlState();
}

class _LoginControlState extends State<LoginControl> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
   return FutureBuilder(
        future: _auth.getUserCredentials(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Check if user credentials are available
            if (snapshot.hasData && snapshot.data['email'] != "" && snapshot.data['password'] != "") {
              // It will fetch the user email and password and login the user
              emailId = snapshot.data['email'];
              password = snapshot.data['password'];
              _auth.logIn(emailId, password);
              // Once login is done, it will navigate the user to home page
              return const MyHomePage();
            } else {
              // If there is no email and password present, it will navigate the user to login page.
              return const LoginPage();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
  }
}