import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class SubscribedDevice {
  late BluetoothDevice device;
  late StreamSubscription<BluetoothConnectionState> subscription;
  late void Function(bool, BluetoothDevice) callBack;
  List<BluetoothService> services = [];

  SubscribedDevice(BluetoothDevice bluetoothDevice, this.callBack) {
    device = bluetoothDevice;
    subscription = device.connectionState.listen(onConnectionChange);
  }

  Future<void> addServices() async {
    if (device.isConnected) {
      services.addAll(await device.discoverServices());
    }
  }

  void printServices() {
    services.forEach((service) {
      print("Service");
      print(service.serviceUuid);
    });
  }

  void toggleLamp() {
    for (var service in services) {
      if (service.serviceUuid.str == "05811a0b-f418-488e-87b9-bf47ee64fda3") {
        service.characteristics.forEach((BluetoothCharacteristic c) async {
          await c.write([0x01]);
        });
      }
    }
  }

  void onConnectionChange(BluetoothConnectionState state) {
    callBack(state == BluetoothConnectionState.connected, device);
  }

  void dispose() {
    subscription.cancel();
  }
}
