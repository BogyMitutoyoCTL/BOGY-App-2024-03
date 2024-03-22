//import 'dart:js_interop';

import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/MainMenu.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:bluetemp/AlarmSetting.dart';
import 'package:path_provider/path_provider.dart';

import 'BlueTempApp.dart';
import 'dart:math';

late GlobalState globalState;
late SafeGlobalState safe;
Future<void> main() async {
  safe = SafeGlobalState();
  await safe.initalize();
  //globalState = GlobalState();
  //await safe.save();
  globalState = safe.getFromStorage();
  // TODO: maybe load the state from a file here
  await safe.save();
  globalState.appSettingsChanger.setLanguage(globalState.Sprache);
  runApp(const BlueTempApp());
}

class SafeGlobalState {
  final LocalStorage storage = LocalStorage('storage.json');
  initalize() async {
    await WidgetsFlutterBinding.ensureInitialized();
    await storage.ready;
  }

  Future<void> save() async {
    await setInStorage();
  }

  void load() {}

  GlobalState getFromStorage() {
    var globalStateString = storage.getItem("GlobalState");
    if (globalStateString == null) {
      return GlobalState();
    }
    print("GLOBALSTATE STORED ON LOCALSTORAGE");
    return GlobalState.fromJson(globalStateString);
  }

  setInStorage() async {
    await storage.setItem("GlobalState", globalState.toJson());
  }
}
