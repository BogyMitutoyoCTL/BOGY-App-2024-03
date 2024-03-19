import 'package:flutter/material.dart';

class graphs extends StatefulWidget {
  const graphs({super.key});

  @override
  State<graphs> createState() => _graphsState();
}

class _graphsState extends State<graphs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Graphen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //TODO: Implement graphs
        children: [ElevatedButton(onPressed: goBack, child: Text("Zurück"))],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
