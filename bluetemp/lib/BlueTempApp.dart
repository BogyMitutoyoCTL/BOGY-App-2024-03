import 'package:bluetemp/Store.dart';
import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'AppSettingsChanger.dart';
import 'Safe_GlobalState.dart';
import 'SplashScreenWidget.dart';

class BlueTempApp extends StatelessWidget {
  const BlueTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageChanger = ChangeNotifierProvider(
      create: (context) => globalState.appSettingsChanger,
      child:
          Consumer<AppSettingsChanger>(builder: (context, localeModel, child) {
        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          onGenerateTitle: (context) => AppLocalizations.of(context).apptitle,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeModel.locale,
          theme: globalState.theme,
          darkTheme: globalState.darkTheme,
          themeMode: globalState.selectedTheme,
          home: SplashScreenWidget(),
        );
      }),
    );

    return languageChanger;
  }
}
