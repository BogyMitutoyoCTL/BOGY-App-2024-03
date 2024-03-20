import 'dart:js_interop';

import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/MainMenu.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'BlueTempApp.dart';

late GlobalState globalState;
Future<void> main() async {
  safeGlobalState safe = safeGlobalState();
  await safe.save();
  globalState = GlobalState();
  // TODO: maybe load the state from a file here

  runApp(const BlueTempApp());
}

class safeGlobalState {
  final LocalStorage storage = LocalStorage('storage');
  Future<void> save() async {
    print("im safe");
    //await storage.ready;
    await storage.setItem("GlobalState", "test");
    //final info = json.encode({'name': 'Darush', 'family': 'Roshanzami'});
    //await storage.setItem('info', info);
    //await storage.ready;
    storage.dispose();
  }

  safeGlobalState() {}

  void load() {}
}
