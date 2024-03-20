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
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).appname +
              " - " +
              AppLocalizations.of(context).alarms_text)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).alarms_text,
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
          Text(AppLocalizations.of(context).current_alarms),
          Padding(
            padding: const EdgeInsets.all(120.0),
            child: ElevatedButton(
                onPressed: goBack,
                child: Text(AppLocalizations.of(context).back_button)),
          )
        ],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
