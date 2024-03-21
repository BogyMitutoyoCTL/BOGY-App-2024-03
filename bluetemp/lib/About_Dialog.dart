import 'package:bluetemp/Mitprogramierer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MaterialApp(
    home: About_Dialog(),
  ));
}

class About_Dialog extends StatefulWidget {
  const About_Dialog({super.key});

  @override
  State<About_Dialog> createState() => _About_DialogState();
}

class _About_DialogState extends State<About_Dialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appname + " - " + AppLocalizations.of(context).about_us_title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(scale: 5, 'assets/Images/BlueTempAppIco.png'),
              Text(
                AppLocalizations.of(context).appname,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                "Version 1.0",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ElevatedButton(onPressed: Mitprogramierende, child: Icon(Icons.person))
            ],
          ),
        ),
      ),
    );
  }

  void Mitprogramierende() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mitprogramierer()));
  }
}
