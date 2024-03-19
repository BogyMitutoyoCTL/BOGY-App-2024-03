import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';

import 'About_Dialog.dart';
import 'SplashScreenWidget.dart';
import 'discover.dart';

class BlueTempApp extends StatelessWidget {
  const BlueTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlueTemp - the Bluetooth temperature monitoring app',
      theme: globalState.theme,
      darkTheme: globalState.darkTheme,
      themeMode: globalState.selectedTheme,
      home: const MainMenu(),
    );
  }
}
