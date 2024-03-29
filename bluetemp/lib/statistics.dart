import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'Safe_GlobalState.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  var maximum = maximum_sort(globalState.DataList);
  var minimum = minimum_sort(globalState.DataList);
  var average = durchschnitt(globalState.DataList);
  var starttime = minimum_Time(globalState.DataList);
  var endtime = maximum_Time(globalState.DataList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context).statistics_title)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).starttime,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("${DateFormat("dd.MM.yyyy  hh:mm").format(starttime)} Uhr",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall), //TODO: Implement real Start Time
            Text(
              AppLocalizations.of(context).endtime,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text("${DateFormat("dd.MM.yyyy  hh:mm").format(endtime)} Uhr",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall), //TODO: Implement real End Time
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).statistics_maximum,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        AppLocalizations.of(context).statistics_average,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        AppLocalizations.of(context).statistics_minimum,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                          "${globalState.Temperaturumrechnen(maximum.temperature).toStringAsFixed(2)} ${globalState.Einheit}",
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(
                          "${globalState.Temperaturumrechnen(average).toStringAsFixed(2)} ${globalState.Einheit}",
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(
                          "${globalState.Temperaturumrechnen(minimum.temperature).toStringAsFixed(2)} ${globalState.Einheit}",
                          style: Theme.of(context).textTheme.headlineMedium)
                    ],
                  )
                ],
              ),
            ),

            ElevatedButton(
              onPressed: sure_to_delete_statistics,
              child: Text(AppLocalizations.of(context).deletestatistics),
            )
          ],
        ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: delete_all_statistics,
                          child: Text(AppLocalizations.of(context).sure_button),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          child:
                              Text(AppLocalizations.of(context).close_button),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void delete_all_statistics() {
    globalState.DataList.removeRange(0, globalState.DataList.length);
    safe.save();
    maximum = maximum_sort(globalState.DataList);
    minimum = minimum_sort(globalState.DataList);
    average = durchschnitt(globalState.DataList);
    setState(() {});
    Navigator.pop(context);
  }
}
