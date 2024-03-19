import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class sync_time extends StatefulWidget {
  const sync_time({super.key});

  @override
  State<sync_time> createState() => _sync_timeState();
}

class _sync_timeState extends State<sync_time> {
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Zeit Synchronisieren")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).current_phone_time,
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Container(
            color: Colors.lightBlue[50],
            child: Column(
              children: [
                Text("${DateFormat('dd.mm.yyyy').format(now)}"),
                Text("${DateFormat('kk:mm:ss').format(now)}"),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).current_sensor_time,
                style: TextStyle(fontSize: 25),
              )
            ],
          ),
          Container(
            color: Colors.lightBlue[50],
            child: Column(
              children: [
                Text(
                    "${DateFormat('dd.mm.yyyy').format(now)}"), //TODO: Implement current sensor time
                Text("${DateFormat('kk:mm:ss').format(now)}"),
              ],
            ),
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
