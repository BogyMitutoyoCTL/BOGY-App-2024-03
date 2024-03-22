import 'package:bluetemp/GlobalState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Safe_GlobalState.dart';
import 'main.dart';

class Setting_dialog extends StatefulWidget {
  const Setting_dialog({super.key});

  @override
  State<Setting_dialog> createState() => _Setting_dialogState();
}

class _Setting_dialogState extends State<Setting_dialog> {
  @override
  Widget build(BuildContext context) {
    var verticalSpacing = Container(
      height: 40,
    );
    var horizontalSpacing = Container(
      width: 14,
    );
    var dropdownBackground = globalState.selectedTheme == ThemeMode.dark
        ? Colors.black
        : Color.fromARGB(255, 230, 242, 253);
    var dropdownForeground = TextStyle(
      color: globalState.selectedTheme == ThemeMode.dark
          ? Colors.white
          : Color.fromARGB(255, 0, 0, 0),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).appname +
              " - " +
              AppLocalizations.of(context).settings_title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Row(
                  children: [
                    Icon(Icons.language),
                    horizontalSpacing,
                    Text(AppLocalizations.of(context).setting_language),
                  ],
                ),
                DropdownButton(
                  isExpanded: true,
                  value: globalState.Sprache,
                  items: buildLanguages(),
                  onChanged: onChangeLanguage,
                  dropdownColor: dropdownBackground,
                  style: dropdownForeground,
                ),
                verticalSpacing,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.brush),
                    horizontalSpacing,
                    Text(AppLocalizations.of(context).setting_theme)
                  ],
                ),
                DropdownButton(
                    isExpanded: true,
                    items: buildThemes(),
                    onChanged: onChangeTheme,
                    dropdownColor: dropdownBackground,
                    style: dropdownForeground,
                    value: globalState.selectedTheme),
                verticalSpacing,
                Row(
                  children: [
                    Icon(Icons.thermostat),
                    horizontalSpacing,
                    Text(AppLocalizations.of(context).setting_temperature_unit)
                  ],
                ),
                DropdownButton(
                  isExpanded: true,
                  value: globalState.Einheit,
                  items: buildUnits(),
                  onChanged: onChangeUnit,
                  dropdownColor: dropdownBackground,
                  style: dropdownForeground,
                )
              ])),
        ));
  }

  List<DropdownMenuItem<String>> buildUnits() {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Celsius"), value: "°C"),
      DropdownMenuItem(child: Text("Kelvin"), value: "K"),
      DropdownMenuItem(child: Text("Fahrenheit"), value: "°F"),
      DropdownMenuItem(child: Text("Newton"), value: "°N"),
      DropdownMenuItem(child: Text("Rankine"), value: "°Ra"),
      DropdownMenuItem(child: Text("Réaumur"), value: "°Ré"),
      DropdownMenuItem(child: Text("Delisle"), value: "°De"),
      DropdownMenuItem(child: Text("Rømer"), value: "°Rø"),
    ];
    return menuItems;
  }

  void onChangeUnit(String? value) {
    globalState.Einheit = value!;
    safe.save();
    globalState.appSettingsChanger.refreshApp();
  }

  List<DropdownMenuItem<ThemeMode>> buildThemes() {
    List<DropdownMenuItem<ThemeMode>> menuItems = [
      DropdownMenuItem(
          child: Text(AppLocalizations.of(context).setting_theme_dark),
          value: ThemeMode.dark),
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context).setting_theme_light),
        value: ThemeMode.light,
      ),
      DropdownMenuItem(
        child: Text(AppLocalizations.of(context).setting_theme_system),
        value: ThemeMode.system,
      ),
    ];
    return menuItems;
  }

  void onChangeTheme(ThemeMode? value) {
    globalState.selectedTheme = value!;
    globalState.appSettingsChanger.refreshApp();
  }

  List<DropdownMenuItem<String>> buildLanguages() {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("English"), value: "en"),
      DropdownMenuItem(
        child: Text("Deutsch"),
        value: "de",
      )
    ];
    return menuItems;
  }

  void onChangeLanguage(String? value) {
    globalState.Sprache = value!;
    safe.save();
    globalState.appSettingsChanger.setLanguage(value!);
  }
}
