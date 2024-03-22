import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SubscribedDevice {
  late BluetoothDevice device;
  late StreamSubscription<BluetoothConnectionState> subscription;
  late void Function(bool, SubscribedDevice) callBack;
  List<BluetoothService> services = [];
  int lampVal = 0;

  SubscribedDevice(BluetoothDevice bluetoothDevice, this.callBack) {
    device = bluetoothDevice;
    subscription = device.connectionState.listen(onConnectionChange);
  }

  void dispose() {
    subscription.cancel();
    disconnect();
  }

  connect() async {
    await device.connect();
    addServices();
  }

  disconnect() async {
    await device.disconnect();
  }

  bool represents(BluetoothDevice btDevice) {
    return device == btDevice;
  }

  addServices() async {
    if (device.isConnected) {
      services.addAll(await device.discoverServices());
    }
  }

  void printServices() {
    for (var service in services) {
      print("Service ${service.serviceUuid}");
    }
  }

  void toggleLamp() {
    lampVal = lampVal ^ 1;
    services
        .where((service) =>
            service.serviceUuid.str == "05811a0b-f418-488e-87b9-bf47ee64fda3")
        .forEach((service) async {
      for (BluetoothCharacteristic c in service.characteristics) {
        await c.write([lampVal]);
      }
    });
  }

  void printTempCharacteristic() {
    services
        .where((service) =>
            service.serviceUuid.str == "06e2d59b-8087-4338-b347-1b6322b5d8be")
        .forEach((service) async {
      service.characteristics
          .where((characteristic) =>
              characteristic.uuid.str == "4df03e85-818b-4f41-b26c-71d68b24814f")
          .forEach((characteristic) {
        print(characteristic.toString() + "\n");
      });
    });
  }

  void onConnectionChange(BluetoothConnectionState state) {
    callBack(state == BluetoothConnectionState.connected, this);
  }
}
