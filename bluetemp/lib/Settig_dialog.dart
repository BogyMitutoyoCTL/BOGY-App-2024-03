import 'package:bluetemp/Setting_Sprachen.dart';
import 'package:bluetemp/Settings_Theme.dart';
import 'package:flutter/material.dart';
import 'Setting_Einheiten.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'SettingsButton.dart';

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
          SettingsButton(callback: Sprachen_Settings, title: AppLocalizations.of(context).settings_item_language, iconData: Icons.language),
          SettingsButton(callback: Theme_Setting, title: AppLocalizations.of(context).settings_item_theme, iconData: Icons.info_outline),
          SettingsButton(callback: Einheiten_Settings, title: AppLocalizations.of(context).settings_item_units, iconData: Icons.send_rounded),
        ],
      ),
    );
  }

  void Sprachen_Settings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Setting_Sprache()));
  }

  void Theme_Setting() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Setting_Theme()));
  }

  void Einheiten_Settings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Einheiten_Dialog()));
  }
}
