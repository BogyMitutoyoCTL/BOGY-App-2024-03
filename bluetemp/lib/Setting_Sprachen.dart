import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Setting_Sprache extends StatefulWidget {
  const Setting_Sprache({super.key});

  @override
  State<Setting_Sprache> createState() => _Setting_SpracheState();
}

String Sprache = "de";
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
          RadioListTile(
              value: de,
              groupValue: Sprache,
              onChanged: zudeutsch,
              title: Text("Deutsch")),
          RadioListTile(
              value: en,
              groupValue: Sprache,
              onChanged: zuenglisch,
              title: Text("Englisch")),
        ],
      ),
    );
  }

  void zudeutsch(String) {
    setState(() {
      Sprache = de;
    });
  }

  void zuenglisch(String) {
    setState(() {
      Sprache = en;
    });
  }
}
