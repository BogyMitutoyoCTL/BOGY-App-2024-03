import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Setting_Sprache extends StatefulWidget {
  const Setting_Sprache({super.key});

  @override
  State<Setting_Sprache> createState() => _Setting_SpracheState();
}

class _Setting_SpracheState extends State<Setting_Sprache> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).languageSetting),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: DropdownButton(
              isExpanded: true,
              value: globalState.Sprache,
              items: dropdownItems(),
              onChanged: Sprachanederung,
            ),
          ),
          ElevatedButton(onPressed: nnn, child: Text("hhh"))
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> dropdownItems() {
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
      globalState.appSettingsChanger.refreshApp();
    });
  }

  void nnn() {
    print(globalState.Sprache);
  }
}
