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
  String Ra = "°Ra";
  String Re = "°Ré";
  String K = "°K";
  String De = "°De";
  String N = "°N";

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
          onChanged: Einheit_aenderungC,
          title: Text("Celsius"),
        ),
        RadioListTile(
          value: F,
          groupValue: globalState.Einheit,
          onChanged: Einheit_aenderungF,
          title: Text("Fahrenheit"),
        ),
        RadioListTile(
          value: Ra,
          groupValue: globalState.Einheit,
          onChanged: Einheit_aenderungR,
          title: Text("Rankine"),
        ),
        RadioListTile(
          value: Re,
          groupValue: globalState.Einheit,
          onChanged: Einheit_aenderungRe,
          title: Text("Réaumur"),
        ),
        RadioListTile(
          value: K,
          groupValue: globalState.Einheit,
          onChanged: Einheit_aenderungK,
          title: Text("Kelvin"),
        ),
        RadioListTile(
          value: N,
          groupValue: globalState.Einheit,
          onChanged: Einheit_aenderungN,
          title: Text("Newton"),
        )
        // ElevatedButton(
        //   onPressed: nothing,  //--> Test für Einheiten (// bei void nothing auch entfernen
        //    child: Text("hhh"),
        //)
      ]),
    );
  }

  void Einheit_aenderungC(String) {
    setState(() {
      globalState.Einheit = C;
      print(globalState.Einheit);
    });
  }

  void Einheit_aenderungF(String) {
    setState(() {
      globalState.Einheit = F;
      print(globalState.Einheit);
    });
  }

  void Einheit_aenderungR(String) {
    setState(() {
      globalState.Einheit = Ra;
      print(globalState.Einheit);
    });
  }

  void Einheit_aenderungRe(String) {
    setState(() {
      globalState.Einheit = Re;
      print(globalState.Einheit);
    });
  }

  void Einheit_aenderungK(String) {
    setState(() {
      globalState.Einheit = K;
      print(globalState.Einheit);
    });
  }

  void Einheit_aenderungN(String) {
    setState(() {
      globalState.Einheit = N;
      print(globalState.Einheit);
    });
  }

  //void nothing() {
  //print("ccc ${Einheit}");
}
//}
