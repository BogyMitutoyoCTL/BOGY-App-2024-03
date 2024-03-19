import 'package:bluetemp/sync_time.dart';
import 'package:flutter/material.dart';
import 'package:bluetemp/connect.dart';
import 'package:bluetemp/current_data.dart';
import 'package:bluetemp/statistics.dart';
import 'package:bluetemp/alarms.dart';
import 'package:bluetemp/graph.dart';
import 'package:bluetemp/About_Dialog.dart';
import 'package:bluetemp/Settig_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(AppLocalizations.of(context).appname),
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
                children: [Text(AppLocalizations.of(context).connect), Icon(Icons.wifi)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: aktuelle_daten,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(AppLocalizations.of(context).showCurrentData), Icon(Icons.bar_chart)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: statistik,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(AppLocalizations.of(context).showStatistics), Icon(Icons.moving_sharp)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: alarme,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(AppLocalizations.of(context).manageAlarms), Icon(Icons.alarm)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: graph,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(AppLocalizations.of(context).showGraph), Icon(Icons.auto_graph)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: about,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(AppLocalizations.of(context).aboutUs), Icon(Icons.info)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: settings,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(AppLocalizations.of(context).settings), Icon(Icons.settings)],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: time_sync,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Zeit Synchronisieren"), Icon(Icons.hourglass_top)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void time_sync() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => sync_time()));
  }

  void verbindung() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => connect()));
  }

  void aktuelle_daten() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => current_data()));
  }

  void statistik() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => statistic()));
  }

  void alarme() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => alarms()));
  }

  void graph() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => graphs()));
  }

  void about() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => About_Dialog()));
  }

  void settings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Setting_dialog()));
  }
}
