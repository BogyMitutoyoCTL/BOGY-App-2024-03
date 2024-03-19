import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final void Function() callback;

  const MainMenuButton({Key? key, required void Function() this.callback, required String this.text, required IconData this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), Icon(iconData)],
        ),
      ),
    );
  }
}
