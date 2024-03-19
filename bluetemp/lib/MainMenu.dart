import 'package:flutter/material.dart';
import 'package:bluetemp/connect.dart';
import 'package:bluetemp/current_data.dart';
import 'package:bluetemp/statistics.dart';
import 'package:bluetemp/alarms.dart';
import 'package:bluetemp/graph.dart';
import 'package:bluetemp/About_Dialog.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlueTemp"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: verbindung,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Verbindung herstellen"), Icon(Icons.wifi)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: aktuelle_daten,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Aktuelle Daten anzeigen"),
                  Icon(Icons.bar_chart)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: statistik,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Statistik anzeigen"),
                  Icon(Icons.moving_sharp)
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: alarme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Alarme verwalten"), Icon(Icons.alarm)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: graph,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Graph anzeiegen"), Icon(Icons.auto_graph)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: about,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Über Uns"), Icon(Icons.info)],
              ),
            ),
          )
        ],
      ),
    );
  }

  void verbindung() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => connect()));
  }

  void aktuelle_daten() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => current_data()));
  }

  void statistik() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => statistic()));
  }

  void alarme() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => alarms()));
  }

  void graph() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => graphs()));
  }

  void about() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => About_Dialog()));
  }
}
