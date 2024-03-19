import 'package:bluetemp/Setting_Sprachen.dart';
import 'package:flutter/material.dart';
import 'Setting_Einheiten.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {}

class Setting_dialog extends StatefulWidget {
  const Setting_dialog({super.key});

  @override
  State<Setting_dialog> createState() => _Setting_dialogState();
}

class _Setting_dialogState extends State<Setting_dialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppLocalizations.of(context).settings_title),
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: Sprachen_Settings,
              child: Row(
                children: [
                  Icon(Icons.language),
                  Text(AppLocalizations.of(context).settings_item_language),
                  Container(
                    width: 150,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              )),
          Container(
            height: 5,
          ),
          ElevatedButton(
              onPressed: Theme_Setting,
              child: Row(
                children: [
                  Icon(Icons.info_outline),
                  Text(AppLocalizations.of(context).settings_item_theme),
                  Container(
                    width: 160,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              )),
          Container(
            height: 5,
          ),
          ElevatedButton(
              onPressed: Einheiten_Settings,
              child: Row(
                children: [
                  Icon(Icons.send_rounded),
                  Text(
                    AppLocalizations.of(context).settings_item_units,
                  ),
                  Container(
                    width: 145,
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ))
        ],
      ),
    );
  }

  void Sprachen_Settings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Setting_Sprache()));
  }

  void Theme_Setting() {
    //   Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) =>Theme_Setting ()));
  }

  void Einheiten_Settings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Einheiten_Dialog()));
  }
}
