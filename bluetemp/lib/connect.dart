// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => ConnectState();
}

class ConnectState extends State<Connect> {
  BluetoothAdapterState adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> adapterStateSubscription;

  @override
  void initState() {
    super.initState();
    adapterStateSubscription =
        FlutterBluePlus.adapterState.listen(onStageChange);
  }

  void onStageChange(BluetoothAdapterState state) {
    adapterState = state;
    if (mounted) {
      refreshBluetoothDeviceList();
      setState(() {});
    }
  }

  @override
  void dispose() {
    adapterStateSubscription.cancel();
    super.dispose();
  }

  List<BluetoothDevice> bluetoothDeviceList = [];

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
            onPressed: () => toggleConnection(index),
            child: Text(list[index].advName)),
        iconShowConnected
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var deviceListWidgets = ListView.builder(
        physics: ScrollPhysics(),
        itemCount: bluetoothDeviceList.length,
        itemBuilder: (context, index) {
          return createListEntry(context, bluetoothDeviceList, index);
        });

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).connect_title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).device_list),
                IconButton(
                    onPressed: refreshBluetoothDeviceList,
                    icon: Icon(Icons.refresh_rounded))
              ],
            ),
            Expanded(child: deviceListWidgets),
          ],
        ),
      ),
    );
  }

  refreshBluetoothDeviceList() async {
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
      setState(() {
        for (ScanResult r in results) {
          if (!bluetoothDeviceList.contains(r.device)) {
            bluetoothDeviceList.add(r.device);
          }
        }
      });
    } else {
      print("no devices found");
    }
  }

  toggleConnection(int btnIndex) async {
    BluetoothDevice device = bluetoothDeviceList[btnIndex];

    // Connect to device if disconnected
    var subscription =
        device.connectionState.listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        device.connect();
        print("${device.disconnectReason}");
      }
    });

    if (device.isConnected) {
      await device.disconnect();
    } else {
      await device.connect();
    }

    setState(() {});

    subscription.cancel();
  }
}
