import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class Setting_Theme extends StatefulWidget {
  const Setting_Theme({super.key});

  @override
  State<Setting_Theme> createState() => _Setting_ThemeState();
}

var Darkmode = ThemeMode.dark;
var Lightmode = ThemeMode.light;
var Systemmode = ThemeMode.system;

class _Setting_ThemeState extends State<Setting_Theme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Themeeinstellungen"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
        child: DropdownButton(
            isDense: true,
            isExpanded: true,
            items: dropdownItems(),
            onChanged: Theme_Mode,
            dropdownColor: Color.fromARGB(255, 211, 211, 211),
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            value: globalState.selectedTheme),
      ),
    );
  }

  List<DropdownMenuItem<ThemeMode>> dropdownItems() {
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
    setState(() {
      globalState.selectedTheme = value!;
      globalState.appSettingsChanger.refreshApp();
    });
  }
}
