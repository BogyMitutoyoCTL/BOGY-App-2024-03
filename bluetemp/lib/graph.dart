import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Safe_GlobalState.dart';
import 'main.dart';

class graphs extends StatefulWidget {
  const graphs({super.key});

  @override
  State<graphs> createState() => _graphsState();
}

class _graphsState extends State<graphs> {
  List<FlSpot> chartData = [];

  @override
  Widget build(BuildContext context) {
    addData();
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context).temperature_graph)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).temp_scale),
              ],
            ),
            Container(
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: LineChart(
                LineChartData(
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(spots: chartData),
                    ],
                    titlesData: FlTitlesData(
                        topTitles: AxisTitles(axisNameWidget: null),
                        rightTitles: AxisTitles(axisNameWidget: null))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(AppLocalizations.of(context).time_scale),
              ],
            )
          ],
        ),
      ),
    );
  }

  addData() {
    for (var entrie in globalState.DataList) {
      DateTime a = globalState.DataList[0].time;
      DateTime b = entrie.time;
      double delta = b.difference(a).inSeconds.toDouble();
      chartData.add(FlSpot(delta, entrie.temperature));
    }
  }
}
