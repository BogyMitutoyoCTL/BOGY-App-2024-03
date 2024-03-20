import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/MainMenu.dart';
import 'package:flutter/material.dart';

import 'BlueTempApp.dart';

late GlobalState globalState;
void main() {
  globalState = GlobalState();
  // TODO: maybe load the state from a file here

  runApp(const BlueTempApp());
}
