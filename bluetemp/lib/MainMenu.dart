import 'package:flutter/material.dart';
import 'package:bluetemp/sync_time.dart';
import 'package:bluetemp/connect.dart';
import 'package:bluetemp/current_data.dart';
import 'package:bluetemp/statistics.dart';
import 'package:bluetemp/alarms.dart';
import 'package:bluetemp/graph.dart';
import 'package:bluetemp/About_Dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bluetemp/settings.dart';

import 'MainMenuButton.dart';

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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MainMenuButton(callback: verbindung, text: AppLocalizations.of(context).connect, iconData: Icons.wifi),
            MainMenuButton(callback: aktuelle_daten, text: AppLocalizations.of(context).showCurrentData, iconData: Icons.bar_chart),
            MainMenuButton(callback: statistik, text: AppLocalizations.of(context).showStatistics, iconData: Icons.moving_sharp),
            MainMenuButton(callback: alarme, text: AppLocalizations.of(context).manageAlarms, iconData: Icons.alarm),
            MainMenuButton(callback: time_sync, text: AppLocalizations.of(context).syncTime, iconData: Icons.hourglass_top),
            MainMenuButton(callback: graph, text: AppLocalizations.of(context).showGraph, iconData: Icons.auto_graph),
            MainMenuButton(callback: about, text: AppLocalizations.of(context).aboutUs, iconData: Icons.info),
            MainMenuButton(callback: settings, text: AppLocalizations.of(context).settings, iconData: Icons.settings)
          ],
        ),
      ),
    );
  }

  void time_sync() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => sync_time()));
  }

  void verbindung() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Connect()));
  }

  void aktuelle_daten() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => current_data()));
  }

  void statistik() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StatisticPage()));
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
