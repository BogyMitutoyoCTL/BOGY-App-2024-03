import 'package:bluetemp/Setting_Sprachen.dart';
import 'package:bluetemp/Settings_Theme.dart';
import 'package:flutter/material.dart';
import 'Setting_Einheiten.dart';
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
          DropdownButton(
            isExpanded: true,
            value: globalState.Sprache,
            items: Sprachen_list(),
            onChanged: Sprachanederung,
            dropdownColor: Color.fromARGB(255, 211, 211, 211),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ])));
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
    setState(() {
      globalState.Sprache = value!;
      globalState.appSettingsChanger.setLanguage(value!);
    });
  }
}
