import 'dart:math';

import 'package:bluetemp/AlarmSetting.dart';
import 'package:bluetemp/AppSettingsChanger.dart';
import 'package:flutter/material.dart';
import 'dart:math' as m;

class GlobalState {
  static var lightColor = ColorScheme(
    brightness: Brightness.light,
    background: Colors.black45,
    onBackground: Colors.white70,
    error: Color.fromARGB(255, 180, 0, 0),
    onError: Colors.white70,
    primary: Color.fromARGB(255, 98, 195, 255),
    onPrimary: Colors.black,
    secondary: Color.fromARGB(255, 45, 141, 68),
    onSecondary: Colors.white70,
    surface: Color.fromARGB(255, 149, 177, 183),
    onSurface: Colors.black,
  );
  // ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 7, 66, 234));
  static var darkColor = ColorScheme(
    brightness: Brightness.dark,
    background: Colors.black45,
    onBackground: Colors.white70,
    error: Color.fromARGB(255, 180, 0, 0),
    onError: Colors.white70,
    primary: Color.fromARGB(255, 0, 106, 173),
    onPrimary: Colors.white70,
    secondary: Color.fromARGB(255, 45, 141, 68),
    onSecondary: Colors.white70,
    surface: Color.fromARGB(255, 128, 128, 128),
    onSurface: Colors.white70,
  );

  GlobalState() {
    appSettingsChanger.setLanguage(Sprache);
  }

  var theme = ThemeData(
    colorScheme: lightColor,
    brightness: Brightness.light,
    radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
            (states) => Color.fromARGB(255, 7, 66, 234))),
    appBarTheme: AppBarTheme(
        backgroundColor: lightColor.primary,
        foregroundColor: lightColor.onPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 0, 0, 0))),
    scaffoldBackgroundColor: Color.fromARGB(255, 232, 244, 255),
    useMaterial3: true,
  );

  var darkTheme = ThemeData(
    colorScheme: darkColor,
    brightness: Brightness.dark,
    radioTheme: RadioThemeData(
        fillColor: MaterialStateColor.resolveWith(
            (states) => Color.fromARGB(255, 7, 66, 234))),
    appBarTheme: AppBarTheme(
        backgroundColor: darkColor.primary,
        foregroundColor: darkColor.onPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(foregroundColor: Colors.white70)),
    scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 78),
    useMaterial3: true,
  );

  ThemeMode selectedTheme = ThemeMode.system;
  String DateOfLastMeasurement = "18.03.2024";
  String TimeOfLastMeasurement = "16:01:09";
  double Temperature = 24;
  double Minimum = 10;
  double Maximum = 30;
  double Durchschnitt = 20;
  String Einheit = "°C";
  var Alarms = []; //Usage Example: AlarmSetting("20", AlarmType.lower)

  Map toJson() => {
        'Alarms': Alarms,
        'Einheit': Einheit,
        'selectedTheme': selectedTheme.name,
        'language': Sprache
      };
  GlobalState.fromJson(Map<dynamic, dynamic> json) {
    Einheit = json["Einheit"];
    Sprache = json["language"];
    selectedTheme = ThemeMode.values.byName(json["selectedTheme"]);
    Alarms = List<AlarmSetting>.from(
        json["Alarms"].map((e) => AlarmSetting.fromJson(e)));
  }

  double Temperaturumrechnen(double Temperature) {
    if (Einheit == "°F") {
      return Temperature * 1.8 + 32;
    }
    if (Einheit == "°Ra") {
      return Temperature * 1.8 + 491.67;
    }
    if (Einheit == "°Ré") {
      return Temperature * 0.8;
    }
    if (Einheit == "°K") {
      return Temperature + 273.15;
    }
    if (Einheit == "N") {
      return Temperature * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Temperature) * 3.2;
    }
    if (Einheit == "°Rø") {
      return (Temperature * 21 / 40) + 7.5;
    }
    /* if (Einheit == "°Hr") {
      return (Temperature + 273.15) * 1.8;
    }
    if (Einheit == "°RD") {
      return (Temperature + 273.15) * 0.02;
    }
    if (Einheit == "°T_RS") {
      return (Temperature + 273.15) * 2.61217 * m.pow(10, 30);
    }
    if (Einheit == "°T_c") {
      return (Temperature + 273.15) * 1.081 * m.pow(10, 30);
    }*/
    else {
      return Temperature;
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
    if (Einheit == "N") {
      return Minimum * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Minimum) * 3.2;
    }
    if (Einheit == "°°Rø") {
      return (Minimum * 21 / 40) + 7.5;
    }
    /* if (Einheit == "°Hr") {
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
    } */
    else {
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
    if (Einheit == "N") {
      return Maximum * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Maximum) * 3.2;
    }
    if (Einheit == "°Rø") {
      return (Maximum * 21 / 40) + 7.5;
    }
    /* if (Einheit == "°Hr") {
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
    }*/
    else {
      return Maximum;
    }
  }

  double Temperaturumrechner_Durchschnitt(double Durchschnitt) {
    if (Einheit == "°F") {
      return Durchschnitt * 1.8 + 32;
    }
    if (Einheit == "°Ra") {
      return Temperature * 1.8 + 491.67;
    }
    if (Einheit == "°Ré") {
      return Durchschnitt * 0.8;
    }
    if (Einheit == "K") {
      return Durchschnitt + 273.15;
    }
    if (Einheit == "°N") {
      return Durchschnitt * 33 / 100;
    }

    if (Einheit == "°De") {
      return (100 - Durchschnitt) * 3.2;
    }
    if (Einheit == "°Rø") {
      return (Durchschnitt * 21 / 40) + 7.5;
    }
    /* if (Einheit == "°Hr") {
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
    }*/
    else {
      return Durchschnitt;
    }
  }

  String Sprache = "en";
  AppSettingsChanger appSettingsChanger = AppSettingsChanger();
}
