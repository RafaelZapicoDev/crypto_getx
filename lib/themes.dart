import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primaryColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Colors.green),
    bodyLarge: TextStyle(color: Colors.black),
  ),
);

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.green,
  scaffoldBackgroundColor: Colors.grey,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: Colors.green,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 56, 57, 63),
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
  ),
);
