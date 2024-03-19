import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class connect extends StatefulWidget {
  const connect({super.key});

  @override
  State<connect> createState() => _connectState();
}

class _connectState extends State<connect> {
  var deviceDataList = [
    DeviceData(isConnected: false, deviceName: "deviceName"),
    DeviceData(isConnected: true, deviceName: "hilgsafgarjhdf"),
    DeviceData(isConnected: true, deviceName: "Das ist ein device")
  ];

  Row createListEntry(BuildContext context, List<DeviceData> list, int index) {
    Icon iconShowConnected;
    if (list[index].connected) {
      iconShowConnected = Icon(Icons.bluetooth_connected_rounded);
    } else {
      iconShowConnected = Icon(Icons.bluetooth_disabled_rounded);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(onPressed: connect, child: Text(list[index].name)),
        iconShowConnected
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceListWidgets = ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: deviceDataList.length,
        itemBuilder: (context, index) {
          return createListEntry(context, deviceDataList, index);
        });

    return Scaffold(
      appBar: AppBar(title: Text("BlueTemp - Connect")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //TODO: Implement Connect
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Geräteliste"),
                IconButton(onPressed: fetch, icon: Icon(Icons.refresh_rounded))
              ],
            ),
            Expanded(child: deviceListWidgets),
            ElevatedButton(onPressed: goBack, child: Text("Zurück"))
          ],
        ),
      ),
    );
  }

  void fetch() {}

  void connect() {}

  void goBack() {
    Navigator.of(context).pop();
  }
}

class DeviceData {
  bool connected = false;
  String name = "";

  DeviceData({required bool isConnected, required String deviceName}) {
    connected = isConnected;
    name = deviceName;
  }
}
