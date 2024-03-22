// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bluetemp/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'SubscribedDevice.dart';

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => ConnectState();
}

class ConnectState extends State<Connect> {
  BluetoothAdapterState adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> adapterStateSubscription;
  List<SubscribedDevice> deviceList = [];
  bool isRefreshing = false;

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
    clearDeviceList(Clear.totally);
    adapterStateSubscription.cancel();
    super.dispose();
  }

  Row createListEntry(
      BuildContext context, List<SubscribedDevice> list, int index) {
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

  @override
  Widget build(BuildContext context) {
    var deviceListWidgets = ListView.builder(
        physics: ScrollPhysics(),
        itemCount: deviceList.length,
        itemBuilder: (context, index) {
          return createListEntry(context, deviceList, index);
        });

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).appname +
              " - " +
              AppLocalizations.of(context).connect_title)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).device_list),
                Visibility(
                    visible: !isRefreshing,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: IconButton(
                        onPressed: refreshBluetoothDeviceList,
                        icon: Icon(Icons.refresh_rounded)))
              ],
            ),
            Expanded(child: deviceListWidgets),
            ElevatedButton(onPressed: testingMethod, child: Text("Test"))
          ],
        ),
      ),
    );
  }

  void testingMethod() {
    for (SubscribedDevice entry in deviceList) {
      if (entry.device.isConnected) {
        entry.listenToTempCharacteristic();
      }
    }
  }

  refreshBluetoothDeviceList() async {
    setState(() {
      isRefreshing = true;
      clearDeviceList(Clear.keepConnected);
    });

    var subscription = FlutterBluePlus.onScanResults
        .listen(onScanResult, onError: (e) => debugPrint(e));

    FlutterBluePlus.cancelWhenScanComplete(subscription);

    FlutterBluePlus.startScan(
      withServices: [Guid("05811a0b-f418-488e-87b9-bf47ee64fda3")],
      timeout: Duration(seconds: 5),
    );
    FlutterBluePlus.isScanning.listen((event) {
      if (event == false) {
        setState(() {
          isRefreshing = false;
        });
      }
    });
  }

  void clearDeviceList(Clear how) {
    for (var handledDevice in deviceList) {
      handledDevice.dispose();
    }
    deviceList.clear();

    if (how == Clear.keepConnected) {
      for (var device in FlutterBluePlus.connectedDevices) {
        deviceList.add(SubscribedDevice(device, onConnectionChanged));
      }
    }
  }

  void onScanResult(List<ScanResult> results) {
    if (results.isNotEmpty) {
      setState(() {
        results.map((result) => result.device).forEach((device) {
          if (!handledDeviceListContains(device)) {
            deviceList.add(SubscribedDevice(device, onConnectionChanged));
          }
        });
      });
    } else {
      debugPrint("no devices found");
    }
  }

  toggleConnection(int btnIndex) async {
    SubscribedDevice handledDevice = deviceList[btnIndex];

    if (handledDevice.device.isConnected) {
      await handledDevice.disconnect();
      // TODO: remove from globalState.subscribedDevice?
    } else {
      await handledDevice.connect();
      globalState.subscribedDevice = handledDevice;
    }
  }

  void onConnectionChanged(bool isConnected, SubscribedDevice device) {
    setState(() {
      //Update the whole list
    });
  }

  bool handledDeviceListContains(BluetoothDevice device) {
    for (SubscribedDevice subscribed in deviceList) {
      if (subscribed.represents(device)) {
        return true;
      }
    }
    return false;
  }
}

enum Clear { totally, keepConnected }
