// ignore_for_file: file_names

import 'package:flutter/material.dart';

// This page contains theme data for light theme and dark theme

// Dark Theme data 
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade900,
      primary: Colors.white,
      secondary: Colors.tealAccent,
      tertiary: Colors.grey.shade900,
      
    )

);

// Light Theme Data
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: Colors.white,
    tertiary: Colors.teal,
  )

);