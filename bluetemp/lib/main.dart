//import 'dart:js_interop';

import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/MainMenu.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

import 'BlueTempApp.dart';

late GlobalState globalState;
late final LocalStorage storage;
Future<void> main() async {
  globalState = GlobalState();
  storage = LocalStorage('storage.json');
  // TODO: maybe load the state from a file here
  await WidgetsFlutterBinding.ensureInitialized();
  safeGlobalState safe = safeGlobalState();
  await safe.save();
  runApp(const BlueTempApp());
}

class safeGlobalState {
  //final LocalStorage storage = LocalStorage('storage.json');
  Future<void> save() async {
    await storage.ready;
    await setInStorage("GlobalState", globalState.toJson());
    print("GLOBALSTATE STORED ON LOCALSTORAGE");

    storage.dispose();
  }

  void load() {}
}

getFromStorage(var value) {
  return storage.getItem("GlobalState"[value]);
}

setInStorage(var storeIn, var value) async {
  await storage.setItem(storeIn, value);
}

deleteStorage(var value) async {
  await storage.deleteItem(value);
}
