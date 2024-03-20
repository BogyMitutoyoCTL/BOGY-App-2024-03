import 'package:bluetemp/AlarmSetting.dart';
import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class alarms extends StatefulWidget {
  const alarms({super.key});

  @override
  State<alarms> createState() => _alarmsState();
}

class _alarmsState extends State<alarms> {
  var text = "";
  var icon;
  Container createListEntry(
      BuildContext context, List<dynamic> list, int index) {
    if (list[index].typ == AlarmType.lower) {
      text = "Alarm < ${list[index].value}°C";
      icon = Icons.brightness_7;
    } else {
      text = "Alarm > ${list[index].value}°C";
      icon = Icons.severe_cold;
    }
    return Container(
      margin: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () => manage_alarms(list[index]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), Icon(icon)],
        ),
      ),
    );
  }

  var Alarmlist = globalState.Alarms;
  @override
  Widget build(BuildContext context) {
    var alarmListWidgets = ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: globalState.Alarms.length,
        itemBuilder: (context, index) {
          return createListEntry(context, Alarmlist, index);
        });
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).appname +
              " - " +
              AppLocalizations.of(context).alarms_text)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).alarms_text,
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(AppLocalizations.of(context).current_alarms),
          ),
          Expanded(child: alarmListWidgets),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: goBack,
                  child: Text(AppLocalizations.of(context).back_button)),
              ElevatedButton(
                  onPressed: add_alarm,
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(AppLocalizations.of(context).add_alarm_button)
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  void goBack() {
    globalState.Alarms.add(AlarmSetting(50, AlarmType.lower));
    globalState.Alarms.add(AlarmSetting(70, AlarmType.higher));
    globalState.Alarms.add(AlarmSetting(90, AlarmType.lower));
    globalState.Alarms.map((e) => print(e.typ)).toList();

    Navigator.of(context).pop();
  }

  void manage_alarms(var value) {
    globalState.Alarms.remove(value);
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(AppLocalizations.of(context).delete_alarm_message),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Text(AppLocalizations.of(context).close_button),
                        onPressed: () => setState(() {
                          Navigator.pop(context);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void add_alarm() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                          AppLocalizations.of(context).add_alarm_modal_text)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            Text(AppLocalizations.of(context).add_alarm_button),
                          ],
                        ),
                        onPressed: () => setState(() {
                          Navigator.pop(context);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
