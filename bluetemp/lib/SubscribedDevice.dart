import 'dart:async';
import 'dart:typed_data';
import 'package:bluetemp/MeasurementValue.dart';
import 'package:bluetemp/Safe_GlobalState.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';

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

  void listenToTempCharacteristic() {
    services
        .where((service) => service.serviceUuid.str == "181a")
        .forEach((service) async {
      service.characteristics
          .where((characteristic) =>
              characteristic.uuid.str == "cbdbd6ac-977c-429f-993d-deca9a3a1b2d")
          .forEach((characteristic) async {
        print(characteristic.toString());
        final subscription = characteristic.onValueReceived.listen((value) {
          convertRecievedValToFloat(value);
        });

        device.cancelWhenDisconnected(subscription);

        await characteristic.setNotifyValue(true);
      });
    });
  }

  convertRecievedValToFloat(List<int> recievedList) {
    Int8List bytes = Int8List.fromList(recievedList.reversed.toList());
    double float = ByteData.view(bytes.buffer).getFloat64(0);
    globalState.DataList.add(MeasurementValue(float, DateTime.now()));
    print(float);
  }

  void onConnectionChange(BluetoothConnectionState state) {
    callBack(state == BluetoothConnectionState.connected, this);
  }
}
