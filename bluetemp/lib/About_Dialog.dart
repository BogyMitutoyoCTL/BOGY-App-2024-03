import 'package:flutter/material.dart';

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
            children: [
              Icon(Icons.menu_book),
              Text('About'),
              Icon(Icons.colorize_sharp)
            ],
          ),
        ),
      ),
    );
  }
}
