import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class graphs extends StatefulWidget {
  const graphs({super.key});

  @override
  State<graphs> createState() => _graphsState();
}

class _graphsState extends State<graphs> {
  List<FlSpot> chartData = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 10),
    FlSpot(3, 7),
    FlSpot(4, 12),
    FlSpot(5, 13),
    FlSpot(6, 17),
    FlSpot(7, 15),
    FlSpot(8, 20),
    FlSpot(8.1, 16),
    FlSpot(8.2, 13),
    FlSpot(8.3, 10),
    FlSpot(9.3, 7),
    FlSpot(20.4, 12),
    FlSpot(25, 9),
    FlSpot(26, 6),
    FlSpot(27, 4),
    FlSpot(28, 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).temperature_graph)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).temperature_graph,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).temp_scale),
              ],
            ),
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: LineChart(
                LineChartData(
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(spots: chartData),
                    ],
                    titlesData: FlTitlesData(topTitles: AxisTitles(axisNameWidget: null), rightTitles: AxisTitles(axisNameWidget: null))),
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
}
