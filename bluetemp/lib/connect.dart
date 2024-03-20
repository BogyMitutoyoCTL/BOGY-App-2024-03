// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => ConnectState();
}

class ConnectState extends State<Connect> {
  BluetoothAdapterState adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      adapterState = state;
      if (mounted) {
        fetch();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    adapterStateStateSubscription.cancel();
    super.dispose();
  }

  List<DeviceData> deviceDataList = [
    /*
    DeviceData(
        bluetoothDevice: BluetoothDevice(remoteId: DeviceIdentifier("test")),
        isConnected: true,
        deviceName: "0"),
    DeviceData(
        bluetoothDevice: BluetoothDevice(remoteId: DeviceIdentifier("test")),
        isConnected: true,
        deviceName: "1"),
    DeviceData(
        bluetoothDevice: BluetoothDevice(remoteId: DeviceIdentifier("test")),
        isConnected: true,
        deviceName: "2")
  */
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
        ElevatedButton(
            onPressed: () => connect(index), child: Text(list[index].name)),
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
          ],
        ),
      ),
    );
  }

  fetch() async {
    deviceDataList.clear();

    var subscription = FlutterBluePlus.onScanResults.listen(
      scanCallback,
      onError: (e) => print(e),
    );

    await FlutterBluePlus.startScan(
      withServices: [Guid("05811a0b-f418-488e-87b9-bf47ee64fda3")],
      timeout: Duration(seconds: 15),
    );

    FlutterBluePlus.cancelWhenScanComplete(subscription);
  }

  void scanCallback(results) {
    if (results.isNotEmpty) {
      for (ScanResult r in results) {
        deviceDataList.add(DeviceData(
            bluetoothDevice: r.device,
            isConnected: false,
            deviceName: r.advertisementData.advName));
      }
      setState(() {});
    } else {
      print("no devices found");
    }
  }

  connect(int btnIndex) async {
    print("Button $btnIndex was pressed");

    BluetoothDevice device = deviceDataList[btnIndex].device;

    // Connect to device if disconnected
    var subscription =
        device.connectionState.listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        device.connect();
        print("${device.disconnectReason}");
      }
    });

    await device.connect();

    if (device.isConnected) {
      deviceDataList[btnIndex].connected = true;

      print("device connected");
    } else {
      deviceDataList[btnIndex].connected = false;
      print("device not connected");
    }

    setState(() {});

    //TODO create option to disconnect from the device

    subscription.cancel();
  }
}

class DeviceData {
  late bool connected;
  late String name;
  late BluetoothDevice device;

  DeviceData(
      {required BluetoothDevice bluetoothDevice,
      required bool isConnected,
      required String deviceName}) {
    device = bluetoothDevice;
    connected = isConnected;
    name = deviceName;
  }
}
