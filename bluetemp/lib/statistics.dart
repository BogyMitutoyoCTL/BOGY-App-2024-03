import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class statistic extends StatefulWidget {
  const statistic({super.key});

  @override
  State<statistic> createState() => _statisticState();
}

class _statisticState extends State<statistic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Statistiken")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).starttime,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(child: Text("16.03.2024 14:00 Uhr")),
                color: Colors.lightBlue[50],
                height: 30,
                width: 150,
              ),
            ],
          ), //TODO: Impelemnt real Start Time
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).endtime,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(child: Text("18.03.2024 14:25 Uhr")),
                color: Colors.lightBlue[50],
                height: 30,
                width: 150,
              ),
            ],
          ), //TODO: Impelemnt real End Time
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Maximum:",
                  style: TextStyle(fontSize: 25),
                ),
                Text("32.3 °C", style: TextStyle(fontSize: 25))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Minimum:",
                  style: TextStyle(fontSize: 25),
                ),
                Text("18.2 °C", style: TextStyle(fontSize: 25))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Minimum:",
                  style: TextStyle(fontSize: 25),
                ),
                Text("15.2 °C", style: TextStyle(fontSize: 25))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: delete_statistic,
            child: Text(AppLocalizations.of(context).deletestatistics),
          )
        ],
      ),
    );
  }

  void delete_statistic() {
    //TODO: DELETE STATISTIC Question
  }
}
