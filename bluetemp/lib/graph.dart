import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Graphen")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Temperatur in °C"),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: 300,
            child: LineChart(
              LineChartData(
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(spots: chartData),
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Zeit in m"),
            ],
          )
        ],
      ),
    );
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
