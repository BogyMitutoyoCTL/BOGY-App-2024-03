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
                children: [],
              ))
        ],
      ),
    );
  }

  void nothing() {}
}
