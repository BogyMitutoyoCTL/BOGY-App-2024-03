import 'package:flutter/material.dart';

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
              onPressed: nothing,
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
          ElevatedButton(
              onPressed: nothing_2,
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
          ElevatedButton(
              onPressed: nothing_3,
              child: Row(
                children: [
                  Icon(Icons.send_rounded),
                  Text(
                    "Einheitet",
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

  void nothing() {}

  void nothing_2() {}

  void nothing_3() {}
}
