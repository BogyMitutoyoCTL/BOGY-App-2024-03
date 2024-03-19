import 'package:flutter/material.dart';

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
        //TODO: Implement statistic
        children: [ElevatedButton(onPressed: goBack, child: Text("Zurück"))],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
