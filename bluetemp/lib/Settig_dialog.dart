import 'package:bluetemp/Setting_Sprachen.dart';
import 'package:bluetemp/Settings_Theme.dart';
import 'package:flutter/material.dart';
import 'Setting_Einheiten.dart';

void main() {}

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
          child: Text("Einstellungen"),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: Sprachen_Settings,
              child: Row(
                children: [
                  Icon(Icons.language),
                  Text("Sprache"),
                  Container(
                    width: 150,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              )),
          Container(
            height: 5,
          ),
          ElevatedButton(
              onPressed: Theme_Setting,
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  Text("Theme"),
                  Container(
                    width: 160,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              )),
          Container(
            height: 5,
          ),
          ElevatedButton(
              onPressed: Einheiten_Settings,
              child: Row(
                children: [
                  Icon(Icons.send_rounded),
                  Text(
                    "Einheiten",
                  ),
                  Container(
                    width: 145,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ))
        ],
      ),
    );
  }

  void Sprachen_Settings() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Setting_Sprache()));
  }

  void Theme_Setting() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Setting_Theme()));
  }

  void Einheiten_Settings() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Einheiten_Dialog()));
  }
}
