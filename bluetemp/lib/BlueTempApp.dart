import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'LocaleChanger.dart';
import 'SplashScreenWidget.dart';

class BlueTempApp extends StatelessWidget {
  const BlueTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageChanger = ChangeNotifierProvider(
      create: (context) => globalState.languageChanger,
      child: Consumer<LocaleChanger>(builder: (context, localeModel, child) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeModel.locale,
          title: "BlueTemp - the Bluetooth temperature monitoring app",
          theme: globalState.theme,
          darkTheme: globalState.darkTheme,
          themeMode: globalState.selectedTheme,
          home: const SplashScreenWidget(),
        );
      }),
    );

    return languageChanger;
  }
}
