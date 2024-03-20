import 'dart:math';

import 'package:bluetemp/AlarmSetting.dart';
import 'package:bluetemp/LocaleChanger.dart';
import 'package:flutter/material.dart';

class GlobalState {
  static var lightColor =
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 7, 66, 234));
  static var darkColor =
      ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 35, 41, 64));

  GlobalState() {
    languageChanger.set(Sprache);
  }

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
  var Theme_Mode = ThemeMode.system;
  ThemeMode selectedTheme = ThemeMode.light;
  String DateOfLastMeasurement = "18.03.2024";
  String TimeOfLastMeasurement = "16:01:09";
  double Grad_Celsius = 24;
  double Minimum = 10;
  double Maximum = 30;
  double Durchschnitt = 20;
  String Einheit = "°C";
  var Alarms = []; //Usage Example: AlarmSetting(20, AlarmType.minimum)

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

  String Sprache = "de";
  LocaleChanger languageChanger = LocaleChanger();
}
