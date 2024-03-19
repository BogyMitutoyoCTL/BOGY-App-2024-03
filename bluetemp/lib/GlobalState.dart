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
  double Grad_Celsius = 24;
  double Minimum = 10;
  double Maximum = 30;
  double Durchschnitt = 20;
  String Einheit = "°C";
  double Temperaturumrechnen(double Grad_Celsius) {
    if (Einheit == "°F") {
      return Grad_Celsius * 1.8 + 32;
    } else {
      return Grad_Celsius;
    }
  }

  double Temperaturumrechner_Minimum(double Minimum) {
    if (Einheit == "°F") {
      return Minimum * 1.8 + 32;
    } else {
      return Minimum;
    }
  }

  double Temperaturumrechner_Maximum(double Maximum) {
    if (Einheit == "°F") {
      return Maximum * 1.8 + 32;
    } else {
      return Maximum;
    }
  }

  double Temperaturumrechner_Durchschnitt(double Durchschnitt) {
    if (Einheit == "°F") {
      return Durchschnitt * 1.8 + 32;
    } else {
      return Durchschnitt;
    }
  }
}
