import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Einheiten_Dialog extends StatefulWidget {
  const Einheiten_Dialog({super.key});

  @override
  State<Einheiten_Dialog> createState() => _Einheiten_DialogState();
}

class _Einheiten_DialogState extends State<Einheiten_Dialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Einheiten Einstellung")),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: DropdownButton(
              isExpanded: true,
              value: globalState.Einheit,
              items: dropdownItems(),
              onChanged: Einheits_aenderung),
        )
      ]),
    );
  }

  List<DropdownMenuItem<String>> dropdownItems() {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Celsius"), value: "°C"),
      DropdownMenuItem(child: Text("Kelvin"), value: "K"),
      DropdownMenuItem(child: Text("Fahrenheit"), value: "°F"),
      DropdownMenuItem(child: Text("Newton"), value: "°N"),
      DropdownMenuItem(child: Text("Rankine"), value: "°Ra"),
      DropdownMenuItem(child: Text("Réaumur"), value: "°Ré"),
      DropdownMenuItem(child: Text("Delisle"), value: "°De"),
      DropdownMenuItem(child: Text("Rømer"), value: "°Rø"),
    ];
    return menuItems;
  }
}

void Einheits_aenderung(String? value) {
  globalState.Einheit = value!;
}
