//import 'dart:js_interop';

import 'dart:ffi';

import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/MainMenu.dart';
import 'dart:convert';
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
  double a_values = 0;
  for (var pair in globalState.DataList) {
    a_values = a_values + pair.temperature;
  }
  globalState.Durchschnitt = a_values / globalState.DataList.length;
  print(globalState.DataList.length);
  print(globalState.Durchschnitt);

  var l = await safe.save();
  globalState.appSettingsChanger.setLanguage(globalState.Sprache);

  runApp(const BlueTempApp());
}

int minimum_sort(List<int> l) {
  l.sort((a, b) => a.compareTo(b));
  return l.first;
}
