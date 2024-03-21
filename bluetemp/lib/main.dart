//import 'dart:js_interop';

import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/MainMenu.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:bluetemp/AlarmSetting.dart';
import 'package:path_provider/path_provider.dart';

import 'BlueTempApp.dart';

late GlobalState globalState;
late SafeGlobalState safe;
Future<void> main() async {
  safe = SafeGlobalState();
  await safe.initalize();
  //globalState = GlobalState();
  //await safe.save();
  globalState = safe.getFromStorage();
  print(globalState.Alarms);
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
    var data_list = storage.getItem("GlobalState");
    if (data_list == null) {
      return GlobalState();
    }

    print(data_list);
    for (var pair in data_list.entries) {
      print(pair.key);
      print(pair.value);
    }
    print("GLOBALSTATE STORED ON LOCALSTORAGE");
    return GlobalState.fromJson(data_list);
  }

  setInStorage() async {
    await storage.setItem("GlobalState", globalState.toJson());
  }
}
