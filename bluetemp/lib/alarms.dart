import 'package:bluetemp/AlarmSetting.dart';
import 'package:bluetemp/GlobalState.dart';
import 'package:bluetemp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localstorage/localstorage.dart';

import 'Safe_GlobalState.dart';

class alarms extends StatefulWidget {
  const alarms({super.key});

  @override
  State<alarms> createState() => _alarmsState();
}

class _alarmsState extends State<alarms> {
  var text = "";
  var icon = Icons.delete;
  String tempValue = "";
  String editValue = "";
  TextEditingController textController = TextEditingController();
  TextEditingController editController = TextEditingController();

  @override
  void initState() {
    textController.text = tempValue;
    textController.addListener(() {
      setState(() {
        tempValue = textController.text;
      });
    });
    editController.text = tempValue;
    editController.addListener(() {
      setState(() {
        editValue = editController.text;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    editController.dispose();
    textController.dispose();
    super.dispose();
  }

  AlarmType selected_typ_value = AlarmType.lower;
  AlarmType selected_typ_value_edit = AlarmType.lower;
  Container createListEntry(
      BuildContext context, List<dynamic> list, int index) {
    if (list[index].typ == AlarmType.lower) {
      text = "Alarm > ${list[index].value}${globalState.Einheit}";
    } else {
      text = "Alarm < ${list[index].value}${globalState.Einheit}";
    }
    return Container(
      margin: EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          manage_alarms(list[index]);
          setState(() {});
        },
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
        physics: PageScrollPhysics(),
        itemCount: globalState.Alarms.length,
        itemBuilder: (context, index) {
          return createListEntry(context, Alarmlist, index);
        });
    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).appname +
              " - " +
              AppLocalizations.of(context).alarms_text)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context).current_alarms),
            Expanded(child: alarmListWidgets),
            ElevatedButton(
                onPressed: add_alarm,
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text(AppLocalizations.of(context).add_alarm_button)
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void manage_alarms(var value) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
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
                            backgroundColor: Colors.red),
                        child: Text(AppLocalizations.of(context).sure_button),
                        onPressed: () => setState(() {
                          globalState.Alarms.remove(value);
                          safe.save();
                          Navigator.pop(context);
                        }),
                      ),
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(AppLocalizations.of(context).edit_alarm_text),
                  ),
                  DropdownButton(
                      items: alarm_typ_item,
                      dropdownColor: Color.fromARGB(500, 211, 211, 211),
                      style: TextStyle(color: Colors.black),
                      onChanged: (AlarmType? newType) {
                        setState(() {
                          selected_typ_value_edit = newType!;
                        });
                      },
                      value: selected_typ_value_edit),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: editController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(new RegExp("^-?\\d*"))
                    ],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 11, top: 11, right: 15),
                        hintText: AppLocalizations.of(context)
                            .enter_temp_placeholder),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          globalState.Alarms.remove(value);
                          safe.save();
                          setState(() {});
                          edit_alarm();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            Text(
                                AppLocalizations.of(context).edit_alarm_button),
                          ],
                        ),
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
          return StatefulBuilder(builder: build_alarm_type_modal);
        });
  }

  Widget build_alarm_type_modal(BuildContext context, StateSetter setState) {
    return Container(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(12),
                child: Text(AppLocalizations.of(context).add_alarm_modal_text)),
            DropdownButton(
                items: alarm_typ_item,
                dropdownColor: Color.fromARGB(500, 211, 211, 211),
                style: TextStyle(color: Colors.black),
                onChanged: (AlarmType? newType) {
                  setState(() {
                    selected_typ_value = newType!;
                  });
                },
                value: selected_typ_value),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: textController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(new RegExp("^-?\\d*"))
              ],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText:
                      AppLocalizations.of(context).enter_temp_placeholder),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    add_alarm_to_list();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(AppLocalizations.of(context).add_alarm_button),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  add_alarm_to_list() async {
    if (tempValue == "") {
      return Navigator.pop(context);
    }
    globalState.Alarms.add(AlarmSetting(tempValue, selected_typ_value));
    safe.save();
    /*final LocalStorage storage = LocalStorage('storage.json');
    storage.setItem("GlobalState", globalState.toJson());*/
    globalState.Alarms.map((e) => print(e.typ)).toList();
    setState(() {
      Navigator.pop(context);
      tempValue = "";
    });
  }

  edit_alarm() async {
    globalState.Alarms.add(AlarmSetting(editValue, selected_typ_value_edit));
    safe.save();
    /*final LocalStorage storage = LocalStorage('storage.json');
    storage.setItem("GlobalState", globalState.toJson());*/
    globalState.Alarms.map((e) => print(e.typ)).toList();
    setState(() {
      Navigator.pop(context);
      tempValue = "";
    });
  }
}

List<DropdownMenuItem<AlarmType>> get alarm_typ_item {
  List<DropdownMenuItem<AlarmType>> menuItems = [
    DropdownMenuItem(child: Text("Alarm >"), value: AlarmType.lower),
    DropdownMenuItem(child: Text("Alarm <"), value: AlarmType.higher),
  ];
  return menuItems;
}
