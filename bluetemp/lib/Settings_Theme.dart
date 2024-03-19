import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          RadioListTile(
            value: ThemeMode.dark,
            groupValue: globalState.Theme_Mode,
            onChanged: Theme_Mode_dark,
            title: Text("Darkmode"),
          ),
          RadioListTile(
            value: ThemeMode.light,
            groupValue: globalState.Theme_Mode,
            onChanged: Theme_Mode_light,
            title: Text("Lightmode"),
          ),
          RadioListTile(
            value: ThemeMode.system,
            groupValue: globalState.Theme_Mode,
            onChanged: ThemeMode_System,
            title: Text("Systemstandard"),
          )
        ],
      ),
    );
  }

  void Theme_Mode_dark(ThemeMode) {
    setState(() {
      globalState.Theme_Mode = Darkmode;
    });
  }

  void Theme_Mode_light(ThemeMode) {
    setState(() {
      globalState.Theme_Mode = Lightmode;
    });
  }

  void ThemeMode_System(ThemeMode) {
    setState(() {
      globalState.Theme_Mode = Systemmode;
    });
  }
}
