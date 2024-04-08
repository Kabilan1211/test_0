// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:test_0/Cloud/Auth.dart';
import 'package:test_0/main.dart';
import 'package:test_0/pages/Login.dart';

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
              // Auto-login with saved credentials
              return const MyHomePage();
            } else {
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