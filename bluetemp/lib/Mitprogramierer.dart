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
        title: Text(AppLocalizations.of(context).appname + " - " + AppLocalizations.of(context).about_us_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(scale: 4, 'assets/Images/Picture_2.png'),
              Text("Dieter Blocher"),
              Text("Thomas Weller"),
              Text("Simon Schlegel"),
              Text("Aryan Saibel"),
              Text("Tim Porger")
            ],
          ),
        ),
      ),
    );
  }
}
