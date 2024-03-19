import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).starttime,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(child: Text("16.03.2024 14:00 Uhr")),
                color: Colors.lightBlue[50],
                height: 30,
                width: 150,
              ),
            ],
          ), //TODO: Impelemnt real Start Time
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).endtime,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(child: Text("18.03.2024 14:25 Uhr")),
                color: Colors.lightBlue[50],
                height: 30,
                width: 150,
              ),
            ],
          ), //TODO: Impelemnt real End Time
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Maximum:",
                  style: TextStyle(fontSize: 25),
                ),
                Text("32.3 °C", style: TextStyle(fontSize: 25))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Minimum:",
                  style: TextStyle(fontSize: 25),
                ),
                Text("18.2 °C", style: TextStyle(fontSize: 25))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Minimum:",
                  style: TextStyle(fontSize: 25),
                ),
                Text("15.2 °C", style: TextStyle(fontSize: 25))
              ],
            ),
          ),
          ElevatedButton(
            onPressed: sure_to_delete_statistics,
            child: Text(AppLocalizations.of(context).deletestatistics),
          )
        ],
      ),
    );
  }

  void sure_to_delete_statistics() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(AppLocalizations.of(context).sure_button_text),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(AppLocalizations.of(context).sure_button),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: delete_all_statistics,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Text(AppLocalizations.of(context).close_button),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void delete_all_statistics() {
    //TODO: Delete all statistics
    Navigator.pop(context);
  }
}
