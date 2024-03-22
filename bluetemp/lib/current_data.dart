import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Safe_GlobalState.dart';

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
    var maybeValue = globalState.DataList.lastOrNull;
    String temperatureText = "";
    String DateOfLastMeasurement = "";
    String TimeOfLastMeasurement = "";
    if (maybeValue == null) {
      temperatureText = "There is currently no data";
      DateOfLastMeasurement = temperatureText;
      TimeOfLastMeasurement = temperatureText;
    } else {
      double lastTemp = globalState.Temperaturumrechnen(maybeValue.temperature);
      temperatureText = lastTemp.toStringAsFixed(2);
      DateOfLastMeasurement =
          "${DateFormat("dd.MM.yyyy").format(maybeValue.time)}";
      TimeOfLastMeasurement =
          "${DateFormat("hh.mm.ss").format(maybeValue.time)}";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appname +
            " - " +
            AppLocalizations.of(context).current_data_title),
      ),
      body: Center(
        child: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).current_data_last_measurement,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                DateOfLastMeasurement,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                TimeOfLastMeasurement,
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "${temperatureText} ${globalState.Einheit}",
                style: TextStyle(fontSize: 60),
              ),
              Countdown(
                controller: _controller,
                seconds: 60,
                build: (BuildContext context, double time) => Text(
                    AppLocalizations.of(context).nextRefresh(time.toInt())),
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
        ),
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
      _controller.restart();
    });
  }
}
