import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mitprogramierer extends StatefulWidget {
  const Mitprogramierer({super.key});

  @override
  State<Mitprogramierer> createState() => _MitprogramiererState();
}

class _MitprogramiererState extends State<Mitprogramierer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Us")),
      ),
      body: CupertinoScrollbar(
        controller: TrackingScrollController(),
        thumbVisibility: true,
        child: Column(
          children: [
            Image.asset(
                height: 450, scale: 0.75, 'assets/Images/Picture_2.png'),
            Text("Name"),

            /// TODO NAME EINTRAGEN
            Container(
              height: 40,
            ),
            Text("Name"),

            /// TODO NAME EINTRAGEN
            Container(
              height: 40,
            ),
            Text("Name"),

            /// TODO NAME EINTRAGEN
            Container(
              height: 40,
            ),
            Text("Aryan Saibel"),
            Container(
              height: 40,
            ),
            Text("Name")

            /// TODO NAME EINTRAGEN
          ],
        ),
      ),
    );
  }
}
