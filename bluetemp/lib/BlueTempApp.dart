import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'SplashScreenWidget.dart';

class BlueTempApp extends StatelessWidget {
  const BlueTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: "BlueTemp - the Bluetooth temperature monitoring app",
      theme: globalState.theme,
      darkTheme: globalState.darkTheme,
      themeMode: globalState.selectedTheme,
      home: SplashScreenWidget(),
    );
  }
}
