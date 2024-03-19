import 'package:flutter/material.dart';

class GlobalState {
  static var lightColor =
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 7, 66, 234));
  static var darkColor =
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 35, 41, 64));

  var theme = ThemeData(
    colorScheme: lightColor,
    appBarTheme: AppBarTheme(
        backgroundColor: lightColor.primary,
        foregroundColor: lightColor.onPrimary),
    useMaterial3: true,
  );

  var darkTheme = ThemeData(
    colorScheme: darkColor,
    appBarTheme: AppBarTheme(
        backgroundColor: darkColor.primary,
        foregroundColor: darkColor.onPrimary),
    useMaterial3: true,
  );

  var selectedTheme = ThemeMode.dark;

  String Einheit = "°C";
  double Temperaturumrechnen(double Grad_Celsius) {
    if (Einheit == "°F") {
      return Grad_Celsius * 1.8 + 32;
    } else {
      return Grad_Celsius;
    }
  }
}
