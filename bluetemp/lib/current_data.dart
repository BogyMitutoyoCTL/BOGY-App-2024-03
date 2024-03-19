import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

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
      appBar: AppBar(title: Text("BlueTemp - Aktuelle Daten")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Letzte Messung vom:"),
          Text("18.03.2024"),
          Text("16:01:09"),
          Text(
            "24.7 °C",
            style: TextStyle(fontSize: 60),
          ),
          Countdown(
            controller: _controller,
            seconds: 60,
            build: (BuildContext context, double time) =>
                Text("Nächste Aktualisierung in ${time.toInt()} Sekunden"),
            interval: Duration(milliseconds: 1000),
            onFinished: timer_end,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: ElevatedButton(
                onPressed: refresh, child: Text("Jetzt aktualisieren")),
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
