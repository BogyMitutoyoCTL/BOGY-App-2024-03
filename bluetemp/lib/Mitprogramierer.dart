import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        centerTitle: true,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: Text(AppLocalizations.of(context).appname +
                      " - " +
                      AppLocalizations.of(context).about_us_title))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
                height: 450, scale: 0.75, 'assets/Images/Picture_2.png'),
            Text("Dieter Blocher"),

            Container(
              height: 40,
            ),
            Text("Thomas Weller"),

            Container(
              height: 40,
            ),
            Text("Simon Schlegel"),

            /// TODO NAME EINTRAGEN
            Container(
              height: 40,
            ),
            Text("Aryan Saibel"),
            Container(
              height: 40,
            ),
            Text("Tim Porger")
          ],
        ),
      ),
    );
  }
}
