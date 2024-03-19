import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Einheiten_Dialog extends StatefulWidget {
  const Einheiten_Dialog({super.key});

  @override
  State<Einheiten_Dialog> createState() => _Einheiten_DialogState();
}

class _Einheiten_DialogState extends State<Einheiten_Dialog> {
  String F = "°F";
  String C = "°C";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Einheiten Einstellung")),
      ),
      body: Column(children: [
        RadioListTile(
          value: C,
          groupValue: globalState.Einheit,
          onChanged: Einheit_aenderungV,
          title: Text("Celsius"),
        ),
        RadioListTile(
          value: F,
          groupValue: globalState.Einheit,
          onChanged: Einheit_aenderungF,
          title: Text("Fahrenheit"),
        ),
        // ElevatedButton(
        //   onPressed: nothing,  //--> Test für Einheiten (// bei void nothing auch entfernen
        //    child: Text("hhh"),
        //)
      ]),
    );
  }

  void Einheit_aenderungV(String) {
    setState(() {
      globalState.Einheit = C;
    });
  }

  void Einheit_aenderungF(String) {
    setState(() {
      globalState.Einheit = F;
    });
  }

  //void nothing() {
  //print("ccc ${Einheit}");
}
//}
