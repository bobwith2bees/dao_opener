// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Leveraged from https://blog.flutterflow.io/creating-an-app-for-interacting-with-any-iot-devices-using-ble/

Future<bool> isBluetoothEnabled() async {
  print('isBluetoothEnabled - starting');
  if (await FlutterBluePlus.isSupported == false) {
    print("Bluetooth not supported by this device");
    return false;
  }

  BluetoothAdapterState state = await FlutterBluePlus.adapterState.first;
  if (state == BluetoothAdapterState.on) {
    print('isBluetoothEnabled - true');
    return true;
  }

  if (isAndroid) {
    print('isBluetoothEnabled - Android call to turnOn Bluetooth');
    await FlutterBluePlus.turnOn();
  }

  await Future.delayed(Duration(milliseconds: 300));
  state = await FlutterBluePlus.adapterState.first;

  if (state == BluetoothAdapterState.on) {
    print('isBluetoothEnabled - true (after retry)');
    return true;
  }
  print('isBluetoothEnabled - FALSE');
  return false;
}
