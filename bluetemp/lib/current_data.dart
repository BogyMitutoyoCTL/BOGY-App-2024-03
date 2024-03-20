import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main.dart';

class current_data extends StatefulWidget {
  const current_data({super.key});

  @override
  State<current_data> createState() => _current_dataState();
}

class _current_dataState extends State<current_data> {
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appname),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context).current_data_last_measurement),
          Text(globalState.DateOfLastMeasurement),
          Text(globalState.TimeOfLastMeasurement),
          Text(
            "${double.parse((globalState.Temperaturumrechnen(globalState.Temperature)).toStringAsFixed(2))} ${globalState.Einheit}",
            style: TextStyle(fontSize: 60),
          ),
          Countdown(
            controller: _controller,
            seconds: 60,
            build: (BuildContext context, double time) =>
                Text(AppLocalizations.of(context).nextRefresh(time.toInt())),
            interval: Duration(milliseconds: 1000),
            onFinished: refresh,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: ElevatedButton(
                onPressed: refresh,
                child: Text(AppLocalizations.of(context).refresh)),
          ))
        ],
      ),
    );
  }

  var rng = Random();
  void refresh() {
    setState(() {
      // TODO: replace fake data by real data
      DateTime now = new DateTime.now();
      globalState.DateOfLastMeasurement = "${now.day}.${now.month}.${now.year}";
      globalState.TimeOfLastMeasurement =
          "${now.hour}:${now.minute}:${now.second}";
      globalState.Temperature += rng.nextDouble() * 6 - 3;
      _controller.restart();
    });
  }
}
