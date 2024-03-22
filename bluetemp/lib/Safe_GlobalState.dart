import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'GlobalState.dart';

late GlobalState globalState;
late SafeGlobalState safe;

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
