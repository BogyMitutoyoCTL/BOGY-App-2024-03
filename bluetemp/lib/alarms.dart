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
  var message = "";
  Row createListEntry(BuildContext context, List<dynamic> list, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () => manage_alarms(list[index]),
            child: Row(
              children: [
                Text(list[index].value.toString()),
                Text(list[index].typ.toString()),
              ],
            )),
      ],
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
        mainAxisAlignment: MainAxisAlignment.start,
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
          Text(AppLocalizations.of(context).current_alarms),
          Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          Expanded(child: alarmListWidgets),
          Padding(
            padding: const EdgeInsets.all(120.0),
          ),
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
}
