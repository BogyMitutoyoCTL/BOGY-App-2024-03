// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/cupertino.dart';
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
      //refreshBluetoothDeviceList();
      setState(() {});
    }
  }

  @override
  void dispose() {
    clearDeviceList();

    adapterStateSubscription.cancel();
    super.dispose();
  }

  List<DeviceWithHandler> deviceList = [];

  Row createListEntry(
      BuildContext context, List<DeviceWithHandler> list, int index) {
    Icon iconShowConnected;
    if (list[index].device.isConnected) {
      iconShowConnected = Icon(Icons.bluetooth_connected_rounded);
    } else {
      iconShowConnected = Icon(Icons.bluetooth_disabled_rounded);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () => toggleConnection(index),
            child: Text(list[index].device.advName)),
        iconShowConnected
      ],
    );
  }

  bool refreshing = false;

  @override
  Widget build(BuildContext context) {
    var deviceListWidgets = ListView.builder(
        physics: ScrollPhysics(),
        itemCount: deviceList.length,
        itemBuilder: (context, index) {
          return createListEntry(context, deviceList, index);
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
                Visibility(
                    visible: !refreshing,
                    child: IconButton(
                        onPressed: refreshBluetoothDeviceList,
                        icon: Icon(Icons.refresh_rounded)))
              ],
            ),
            Expanded(child: deviceListWidgets),
          ],
        ),
      ),
    );
  }

  refreshBluetoothDeviceList() async {
    setState(() {
      refreshing = true;
      clearDeviceList();
      List<BluetoothDevice> connectedDevices = FlutterBluePlus.connectedDevices;
      for (BluetoothDevice device in connectedDevices) {
        deviceList.add(DeviceWithHandler(device, onConnectionChanged));
      }
    });

    var subscription = FlutterBluePlus.onScanResults.listen(onScanResult,
        onError: (e) => print(e),
        onDone: () => setState(() {
              refreshing = false;
            }),
        cancelOnError: true);

    FlutterBluePlus.cancelWhenScanComplete(subscription);

    await FlutterBluePlus.startScan(
        withServices: [Guid("05811a0b-f418-488e-87b9-bf47ee64fda3")],
        timeout: Duration(seconds: 5));
  }

  void clearDeviceList() {
    for (var handledDevice in deviceList) {
      handledDevice.dispose();
    }

    deviceList.clear();
  }

  void onScanResult(List<ScanResult> results) {
    if (results.isNotEmpty) {
      setState(() {
        for (ScanResult r in results) {
          if (!handledDeviceListContains(r.device)) {
            deviceList.add(DeviceWithHandler(r.device, onConnectionChanged));
          }
        }
      });
    } else {
      print("no devices found");
    }
  }

  toggleConnection(int btnIndex) async {
    DeviceWithHandler handledDevice = deviceList[btnIndex];

    if (handledDevice.device.isConnected) {
      await handledDevice.device.disconnect();
    } else {
      await handledDevice.device.connect();
    }
  }

  void onConnectionChanged(bool isConnected, BluetoothDevice device) {
    setState(() {
      //Update the whole list
    });
  }

  bool handledDeviceListContains(BluetoothDevice device) {
    bool result = false;
    for (DeviceWithHandler r in deviceList) {
      if (r.device == device) {
        result = true;
        break;
      }
    }
    return result;
  }
}

class DeviceWithHandler {
  late BluetoothDevice device;
  late StreamSubscription<BluetoothConnectionState> subscription;
  late void Function(bool, BluetoothDevice) callBack;

  DeviceWithHandler(BluetoothDevice bluetoothDevice, this.callBack) {
    device = bluetoothDevice;
    subscription = device.connectionState.listen(onConnectionChange);
  }

  void onConnectionChange(BluetoothConnectionState state) {
    callBack(state == BluetoothConnectionState.connected, device);
  }

  void dispose() {
    subscription.cancel();
  }
}
