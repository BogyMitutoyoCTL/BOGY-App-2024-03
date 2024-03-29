import 'dart:math';

import 'package:bluetemp/AlarmSetting.dart';
import 'package:bluetemp/AppSettingsChanger.dart';
import 'package:bluetemp/Safe_GlobalState.dart';
import 'package:bluetemp/SubscribedDevice.dart';
import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as m;

import 'MeasurementValue.dart';

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
      onSurface: Colors.white70);

  GlobalState() {
    appSettingsChanger.setLanguage(Sprache);
  }

  var theme = ThemeData(
    canvasColor: Color.fromARGB(255, 213, 58, 73),
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
    dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(color: Colors.black), menuStyle: MenuStyle()),
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
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(color: Colors.white, backgroundColor: Colors.purple),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.red,
        filled: true,
      ),
      menuStyle: MenuStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => Color.fromARGB(255, 255, 0, 0)),
          surfaceTintColor: MaterialStateColor.resolveWith(
              (states) => Color.fromARGB(255, 255, 0, 0))),
    ),
    useMaterial3: true,
  );

  ThemeMode selectedTheme = ThemeMode.dark;
  String DateOfLastMeasurement = "18.03.2024";
  String TimeOfLastMeasurement = "16:01:09";
  double Temperature = 24;
  MeasurementValue Minimum = MeasurementValue(23, DateTime.now());
  MeasurementValue Maximum = MeasurementValue(23, DateTime.now());
  var Durchschnitt;
  String Einheit = "°C";
  var Alarms = []; //Usage Example: AlarmSetting("20", AlarmType.lower)
  List<MeasurementValue> DataList = [];

  Map toJson() => {
        'Alarms': Alarms,
        'Einheit': Einheit,
        'selectedTheme': selectedTheme.name,
        'language': Sprache,
        'DataList': DataList
      };
  GlobalState.fromJson(Map<dynamic, dynamic> json) {
    Einheit = json["Einheit"];
    Sprache = json["language"];
    selectedTheme = ThemeMode.values.byName(json["selectedTheme"]);
    Alarms = List<AlarmSetting>.from(
        json["Alarms"].map((e) => AlarmSetting.fromJson(e)));
    DataList = List<MeasurementValue>.from(
        json["DataList"].map((e) => MeasurementValue.fromJson(e)));
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
    if (Einheit == "K") {
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

  String Sprache = "en";
  AppSettingsChanger appSettingsChanger = AppSettingsChanger();

  SubscribedDevice? subscribedDevice;
}
