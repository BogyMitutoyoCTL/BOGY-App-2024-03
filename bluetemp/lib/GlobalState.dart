import 'dart:math';

import 'package:bluetemp/AlarmSetting.dart';
import 'package:bluetemp/LocaleChanger.dart';
import 'package:flutter/material.dart';
import 'dart:math' as m;

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

  ThemeMode selectedTheme = ThemeMode.system;
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
    }
    if (Einheit == "°Ra") {
      return Grad_Celsius * 1.8 + 491.67;
    }
    if (Einheit == "°Ré") {
      return Grad_Celsius * 0.8;
    }
    if (Einheit == "°K") {
      return Grad_Celsius + 273.15;
    }
    if (Einheit == "°N") {
      return Grad_Celsius * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Grad_Celsius) * 3.2;
    }
    if (Einheit == "°Rø") {
      return (Grad_Celsius * 21 / 40) + 7.5;
    }
    if (Einheit == "°Hr") {
      return (Grad_Celsius + 273.15) * 1.8;
    }
    if (Einheit == "°RD") {
      return (Grad_Celsius + 273.15) * 0.02;
    }
    if (Einheit == "°T_RS") {
      return (Grad_Celsius + 273.15) * 2.61217 * m.pow(10, 30);
    }
    if (Einheit == "°T_c") {
      return (Grad_Celsius + 273.15) * 1.081 * m.pow(10, 30);
    } else {
      return Grad_Celsius;
    }
  }

  double Temperaturumrechner_Minimum(double Minimum) {
    if (Einheit == "°F") {
      return Minimum * 1.8 + 32;
    }
    if (Einheit == "°Ra") {
      return Minimum * 1.8 + 491.67;
    }
    if (Einheit == "°Ré") {
      return Minimum * 0.8;
    }
    if (Einheit == "°K") {
      return Minimum + 273.15;
    }
    if (Einheit == "°N") {
      return Minimum * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Minimum) * 3.2;
    }
    if (Einheit == "°°Rø") {
      return (Minimum * 21 / 40) + 7.5;
    }
    if (Einheit == "°Hr") {
      return (Minimum + 273.15) * 1.8;
    }
    if (Einheit == "°RD") {
      return (Minimum + 273.15) * 0.02;
    }
    if (Einheit == "°T_RS") {
      return (Minimum + 273.15) * 2.61217 * m.pow(10, 30);
    }
    if (Einheit == "°T_c") {
      return (Minimum + 273.15) * 1.081 * m.pow(10, 30);
    } else {
      return Minimum;
    }
  }

  double Temperaturumrechner_Maximum(double Maximum) {
    if (Einheit == "°F") {
      return Maximum * 1.8 + 32;
    }
    if (Einheit == "°Ra") {
      return Maximum * 1.8 + 491.67;
    }
    if (Einheit == "°Ré") {
      return Maximum * 0.8;
    }
    if (Einheit == "°K") {
      return Maximum + 273.15;
    }
    if (Einheit == "°N") {
      return Maximum * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Maximum) * 3.2;
    }
    if (Einheit == "°°Rø") {
      return (Maximum * 21 / 40) + 7.5;
    }
    if (Einheit == "°Hr") {
      return (Maximum + 273.15) * 1.8;
    }
    if (Einheit == "°RD") {
      return (Maximum + 273.15) * 0.02;
    }
    if (Einheit == "°T_RS") {
      return (Maximum + 273.15) * 2.61217 * m.pow(10, 30);
    }
    if (Einheit == "°T_c") {
      return (Maximum + 273.15) * 1.081 * m.pow(10, 30);
    } else {
      return Maximum;
    }
  }

  double Temperaturumrechner_Durchschnitt(double Durchschnitt) {
    if (Einheit == "°F") {
      return Durchschnitt * 1.8 + 32;
    }
    if (Einheit == "°Ra") {
      return Grad_Celsius * 1.8 + 491.67;
    }
    if (Einheit == "°Ré") {
      return Durchschnitt * 0.8;
    }
    if (Einheit == "°K") {
      return Durchschnitt + 273.15;
    }
    if (Einheit == "°N") {
      return Durchschnitt * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Durchschnitt) * 3.2;
    }
    if (Einheit == "°°Rø") {
      return (Durchschnitt * 21 / 40) + 7.5;
    }
    if (Einheit == "°Hr") {
      return (Durchschnitt + 273.15) * 1.8;
    }
    if (Einheit == "°RD") {
      return (Durchschnitt + 273.15) * 0.02;
    }
    if (Einheit == "°T_RS") {
      return (Durchschnitt + 273.15) * 2.61217 * m.pow(10, 30);
    }
    if (Einheit == "°T_c") {
      return (Durchschnitt + 273.15) * 1.081 * m.pow(10, 30);
    } else {
      return Durchschnitt;
    }
  }

  String Sprache = "de";
  LocaleChanger languageChanger = LocaleChanger();
}
