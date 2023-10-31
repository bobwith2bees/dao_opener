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

Future<bool> turnOnBluetooth() async {
  print('turnOnBluetooth - starting');
  if (await FlutterBluePlus.isSupported == false) {
    print('turnOnBluetooth - Bluetooth not supported by this device');
    return false;
  }

  // handle bluetooth on & off
  // note: for iOS the initial state is typically BluetoothAdapterState.unknown
  // note: if you have permissions issues you will get stuck at BluetoothAdapterState.unauthorized
  FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
    print(state);
    if (state == BluetoothAdapterState.on) {
      // usually start scanning, connecting, etc
      print('turnOnBluetooth - BluetoothAdapterState.on');
    } else {
      print('turnOnBluetooth - Unexpected state: $state');
      // show an error to the user, etc
    }
  });

  // turn on bluetooth ourself if we can
  // for iOS, the user controls bluetooth enable/disable
  if (isAndroid) {
    await FlutterBluePlus.turnOn();
  }
  return true;
}
