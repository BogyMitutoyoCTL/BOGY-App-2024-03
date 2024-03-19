import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Setting_Sprache extends StatefulWidget {
  const Setting_Sprache({super.key});

  @override
  State<Setting_Sprache> createState() => _Setting_SpracheState();
}

String en = "en";
String de = "de";

class _Setting_SpracheState extends State<Setting_Sprache> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spracheinstellungen"),
      ),
      body: Column(
        children: [
          RadioListTile(value: de, groupValue: globalState.Sprache, onChanged: zudeutsch, title: Text("Deutsch")),
          RadioListTile(value: en, groupValue: globalState.Sprache, onChanged: zuenglisch, title: Text("Englisch"))
        ],
      ),
    );
  }

  void zudeutsch(String) {
    setState(() {
      globalState.Sprache = de;
      globalState.languageChanger.set(de);
    });
  }

  void zuenglisch(String) {
    setState(() {
      globalState.Sprache = en;
      globalState.languageChanger.set(en);
    });
  }
}
