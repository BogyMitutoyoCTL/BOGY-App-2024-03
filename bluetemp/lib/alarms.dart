import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class alarms extends StatefulWidget {
  const alarms({super.key});

  @override
  State<alarms> createState() => _alarmsState();
}

class _alarmsState extends State<alarms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Alarme verwalten")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Alarme verwalten",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          ElevatedButton(onPressed: goBack, child: Text("Zurück"))
        ],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
