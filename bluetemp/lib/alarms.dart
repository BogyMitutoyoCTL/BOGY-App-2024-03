import 'package:flutter/material.dart';

class alarms extends StatefulWidget {
  const alarms({super.key});

  @override
  State<alarms> createState() => _alarmsState();
}

class _alarmsState extends State<alarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Alarme")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //TODO: Implement alarms
        children: [ElevatedButton(onPressed: goBack, child: Text("Zurück"))],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
