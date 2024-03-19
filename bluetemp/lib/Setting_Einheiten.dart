import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Einheiten_Dialog extends StatefulWidget {
  const Einheiten_Dialog({super.key});

  @override
  State<Einheiten_Dialog> createState() => _Einheiten_DialogState();
}

String F = "°F";
String C = "°C";
String Einheit = C;

class _Einheiten_DialogState extends State<Einheiten_Dialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Einheiten Einstellung")),
      ),
      body: Column(children: [
        RadioListTile(
          value: C,
          groupValue: Einheit,
          onChanged: Einheit_aenderungV,
          title: Text("Celsius"),
        ),
        RadioListTile(
          value: F,
          groupValue: Einheit,
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
      Einheit = C;
    });
  }

  void Einheit_aenderungF(String) {
    setState(() {
      Einheit = F;
    });
  }

  //void nothing() {
  //print("ccc ${Einheit}");
}
//}
