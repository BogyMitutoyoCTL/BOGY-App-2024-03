import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Icon(Icons.menu), Text('About'), Icon(Icons.person)],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 30,
            ),
            Image.asset(height: 450, scale: 2, 'assets/Images/BlueTempAppIco.png'),
            Text(
              AppLocalizations.of(context).appname,
              style: TextStyle(fontSize: 25),
            ),
            Text(
              "Version 1.0",
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
