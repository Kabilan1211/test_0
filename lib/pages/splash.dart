import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:test_0/Constant/wrapper.dart';

// Tihs is a splash screen which returns the user to the wrapper function

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Text("Welcome", 
      style: TextStyle(color: Colors.blue.shade200, fontSize: 50, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      duration: 2000,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: const Wrapper());
  }
}