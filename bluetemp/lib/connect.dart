import 'package:flutter/material.dart';

class connect extends StatefulWidget {
  const connect({super.key});

  @override
  State<connect> createState() => _connectState();
}

class _connectState extends State<connect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Connect")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //TODO: Implement Connect
        children: [ElevatedButton(onPressed: goBack, child: Text("Zurück"))],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
