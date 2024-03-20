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

  List<BluetoothDevice> bluetoothDeviceList = [
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

  Row createListEntry(
      BuildContext context, List<BluetoothDevice> list, int index) {
    Icon iconShowConnected;
    if (list[index].isConnected) {
      iconShowConnected = Icon(Icons.bluetooth_connected_rounded);
    } else {
      iconShowConnected = Icon(Icons.bluetooth_disabled_rounded);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () => connect(index), child: Text(list[index].advName)),
        iconShowConnected
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceListWidgets = ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: bluetoothDeviceList.length,
        itemBuilder: (context, index) {
          return createListEntry(context, bluetoothDeviceList, index);
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
    bluetoothDeviceList.clear();

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
        bluetoothDeviceList.add(r.device);
      }
      setState(() {});
    } else {
      print("no devices found");
    }
  }

  connect(int btnIndex) async {
    print("Button $btnIndex was pressed");

    BluetoothDevice device = bluetoothDeviceList[btnIndex];

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
      print("device connected");
    } else {
      print("device not connected");
    }

    setState(() {});

    //TODO create option to disconnect from the device

    subscription.cancel();
  }
}
