import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bluetemp/GlobalState.dart';
import 'SettingsButton.dart';
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
          title: Center(
            child: Text(AppLocalizations.of(context).settings_title),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: DropdownButton(
              isExpanded: true,
              value: globalState.Sprache,
              items: Sprachen_list(),
              onChanged: Sprachanederung,
              dropdownColor: Color.fromARGB(255, 211, 211, 211),
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: DropdownButton(
                isDense: true,
                isExpanded: true,
                items: Themes_list(),
                onChanged: Theme_Mode,
                dropdownColor: Color.fromARGB(255, 211, 211, 211),
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                value: globalState.selectedTheme),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: DropdownButton(
              isExpanded: true,
              value: globalState.Einheit,
              items: dropdownItems(),
              onChanged: Einheits_aenderung,
              dropdownColor: Color.fromARGB(255, 211, 211, 211),
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
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
  globalState.appSettingsChanger.setLanguage(value!);
}
