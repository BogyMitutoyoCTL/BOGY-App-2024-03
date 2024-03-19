import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class sync_time extends StatefulWidget {
  const sync_time({super.key});

  @override
  State<sync_time> createState() => _sync_timeState();
}

class _sync_timeState extends State<sync_time> {
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  DateTime now = DateTime.now();
  var dayformatted = DateFormat('dd.mm.yyyy').format(DateTime.now());
  var hourformatted = DateFormat('hh:mm:ss').format(DateTime.now());
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
                Text(dayformatted),
                Text(hourformatted),
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
                Text("${dayformatted}"), //TODO: Implement current sensor time
                Text("${hourformatted}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
                onPressed: sync_time_data,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Sync Time & Data"), Icon(Icons.sync)],
                )),
          ),
          Countdown(
            controller: _controller,
            seconds: 3,
            build: (BuildContext context, double time) =>
                Text("Next refresh in ${time.toInt()} secounds"),
            interval: Duration(milliseconds: 1000),
            onFinished: timer_end,
          ),
        ],
      ),
    );
  }

  void sync_time_data() {
    //TODO: Implement Sync Time fetaure
    setState(() {
      dayformatted = DateFormat('dd.mm.yyyy').format(DateTime.now());
      hourformatted = DateFormat('hh:mm:ss').format(DateTime.now());
    });
    _controller.restart();
  }

  timer_end() {
    setState(() {
      dayformatted = DateFormat('dd.mm.yyyy').format(DateTime.now());
      hourformatted = DateFormat('hh:mm:ss').format(DateTime.now());
    });

    _controller.restart();
  }
}
