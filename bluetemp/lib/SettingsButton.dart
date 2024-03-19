import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  void Function() callback;
  String title;
  IconData iconData;

  SettingsButton({Key? key, required void Function() this.callback, required String this.title, required IconData this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: ElevatedButton(
          onPressed: callback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(iconData),
                  Container(
                    width: 20,
                  ),
                  Text(title),
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          )),
    );
  }
}
