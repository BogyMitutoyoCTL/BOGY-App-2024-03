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
  final CountdownController _controller = new CountdownController(autoStart: true);
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
            "${globalState.Temperaturumrechnen(globalState.Grad_Celsius)} ${globalState.Einheit}",
            style: TextStyle(fontSize: 60),
          ),
          Countdown(
            controller: _controller,
            seconds: 60,
            build: (BuildContext context, double time) => Text(AppLocalizations.of(context).nextRefresh(time.toInt())),
            interval: Duration(milliseconds: 1000),
            onFinished: timer_end,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: ElevatedButton(onPressed: refresh, child: Text(AppLocalizations.of(context).refresh)),
          ))
        ],
      ),
    );
  }

  void refresh() {
    setState(() {
      _controller.restart();
    });
  }

  void timer_end() {
    //TODO: Reload Temp
    _controller.restart(); //Restarts the Countdwon
  }
}
