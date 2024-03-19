import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class Setting_Theme extends StatefulWidget {
  const Setting_Theme({super.key});

  @override
  State<Setting_Theme> createState() => _Setting_ThemeState();
}

class _Setting_ThemeState extends State<Setting_Theme> {
  var qqq;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Themeeinstellungen"),
      ),
      body: Column(
        children: [
          RadioListTile(
            value: qqq,
            groupValue: qqq,
            onChanged: qqq,
            title: Text("Darkmode"),
          ),
          RadioListTile(
            value: qqq,
            groupValue: qqq,
            onChanged: qqq,
            title: Text("Brightmode"),
          )
        ],
      ),
    );
  }
}
