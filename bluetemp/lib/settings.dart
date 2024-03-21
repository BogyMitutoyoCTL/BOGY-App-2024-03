import 'package:bluetemp/GlobalState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'main.dart';

class Setting_dialog extends StatefulWidget {
  const Setting_dialog({super.key});

  @override
  State<Setting_dialog> createState() => _Setting_dialogState();
}

class _Setting_dialogState extends State<Setting_dialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).appname + " - " + AppLocalizations.of(context).settings_title),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [
                Icon(Icons.language),
                Text("  Spracheinstellungen:"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: DropdownButton(
              isExpanded: true,
              value: globalState.Sprache,
              items: Sprachen_list(),
              onChanged: Sprachanederung,
              dropdownColor: globalState.selectedTheme == ThemeMode.dark ? Colors.black : Color.fromARGB(255, 230, 242, 253),
              style: TextStyle(
                color: globalState.selectedTheme == ThemeMode.dark ? Colors.white : Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [Icon(Icons.brush), Text("  Themes:")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: DropdownButton(
                isDense: true,
                isExpanded: true,
                items: Themes_list(),
                onChanged: Theme_Mode,
                dropdownColor: globalState.selectedTheme == ThemeMode.dark ? Colors.black : Color.fromARGB(255, 230, 242, 253),
                style: TextStyle(
                  color: globalState.selectedTheme == ThemeMode.dark ? Colors.white : Color.fromARGB(255, 0, 0, 0),
                ),
                value: globalState.selectedTheme),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Row(
              children: [Icon(Icons.thermostat), Text(" Temperatureinheit:")],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: DropdownButton(
              isExpanded: true,
              value: globalState.Einheit,
              items: dropdownItems(),
              onChanged: Einheits_aenderung,
              dropdownColor: globalState.selectedTheme == ThemeMode.dark ? Colors.black : Color.fromARGB(255, 230, 242, 253),
              style: TextStyle(
                color: globalState.selectedTheme == ThemeMode.dark ? Colors.white : Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          )
        ])));
  }
}

List<DropdownMenuItem<String>> dropdownItems() {
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

void Einheits_aenderung(String? value) {
  globalState.Einheit = value!;
  safe.save();
  globalState.appSettingsChanger.refreshApp();
}

List<DropdownMenuItem<ThemeMode>> Themes_list() {
  List<DropdownMenuItem<ThemeMode>> menuItems = [
    DropdownMenuItem(child: Text("Darkmode"), value: ThemeMode.dark),
    DropdownMenuItem(
      child: Text("Lightmode"),
      value: ThemeMode.light,
    ),
    DropdownMenuItem(
      child: Text("Systemstandard"),
      value: ThemeMode.system,
    ),
  ];
  return menuItems;
}

void Theme_Mode(ThemeMode? value) {
  globalState.selectedTheme = value!;
  globalState.appSettingsChanger.refreshApp();
}

List<DropdownMenuItem<String>> Sprachen_list() {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Englisch"), value: "en"),
    DropdownMenuItem(
      child: Text("Deutsch"),
      value: "de",
    )
  ];
  return menuItems;
}

void Sprachanederung(String? value) {
  globalState.Sprache = value!;
  safe.save();
  globalState.appSettingsChanger.setLanguage(value!);
}
