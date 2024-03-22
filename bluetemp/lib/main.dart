//import 'dart:js_interop';

import 'package:bluetemp/MeasurementValue.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:bluetemp/AlarmSetting.dart';
import 'package:path_provider/path_provider.dart';

import 'BlueTempApp.dart';
import 'dart:math';

import 'Safe_GlobalState.dart';

Future<void> main() async {
  safe = SafeGlobalState();

  await safe.initalize();
  //globalState = GlobalState();
  //await safe.save();
  globalState = safe.getFromStorage();

  globalState.Minimum = minimum_sort(globalState.DataList);
  print(globalState.Minimum);
  globalState.Maximum = maximum_sort(globalState.DataList);
  print(globalState.Maximum);

  print(globalState.DataList.length);
  print(globalState.Durchschnitt);

  var l = await safe.save();
  globalState.appSettingsChanger.setLanguage(globalState.Sprache);

  runApp(const BlueTempApp());
}

MeasurementValue minimum_sort(List<MeasurementValue> c) {
  if (c.isEmpty) return MeasurementValue(0, DateTime(2000, 0, 0, 0, 0, 0, 0));
  c.sort((a, b) => a.temperature.compareTo(b.temperature));
  return c.first;
}

MeasurementValue maximum_sort(List<MeasurementValue> l) {
  if (l.isEmpty) return MeasurementValue(0, DateTime(2000, 0, 0, 0, 0, 0, 0));
  l.sort((b, a) => a.temperature.compareTo(b.temperature));
  return l.first;
}

double durchschnitt(List<MeasurementValue> l) {
  if (l.isEmpty) return 0;
  double a_values = 0;
  for (var pair in l) {
    a_values = a_values + pair.temperature;
  }
  return a_values / l.length;
}

DateTime minimum_Time(List<MeasurementValue> c) {
  if (c.isEmpty) return DateTime(2000, 0, 0, 0, 0, 0, 0);
  return c.first.time;
}

DateTime maximum_Time(List<MeasurementValue> c) {
  if (c.isEmpty) return DateTime(2000, 0, 0, 0, 0, 0, 0);
  return c.last.time;
}
