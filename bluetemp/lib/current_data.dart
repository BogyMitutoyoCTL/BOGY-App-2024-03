import 'package:flutter/material.dart';

class current_data extends StatefulWidget {
  const current_data({super.key});

  @override
  State<current_data> createState() => _current_dataState();
}

class _current_dataState extends State<current_data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Aktuelle Daten")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //TODO: Implement current_data
        children: [ElevatedButton(onPressed: goBack, child: Text("Zurück"))],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
