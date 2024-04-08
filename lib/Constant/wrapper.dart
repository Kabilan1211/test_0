// ignore: library_prefixes
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_0/Constant/loginControl.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/pages/splash.dart';
import 'package:test_0/widgets/user.dart';

// This page contains data to provide correct stream control based on the user UID

// Used to redirect the user based on their login state
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context, listen: false);

     print(user);
    if (user == null) {
      return const LoginControl();
    } else {
      return const Splash();
    }
  }
}
