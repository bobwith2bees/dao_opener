// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<bool> connectDevice(BTDeviceStruct deviceInfo) async {
  print('connectDevice - ${deviceInfo.name}, id ${deviceInfo.id}');
  final device = BluetoothDevice.fromId(deviceInfo.id);
  try {
    await device.connect();
  } catch (e) {
    print(e);
  }

  final mtuSubscription = device.mtu.listen((int mtu) {
    // iOS: initial value is always 23, but iOS will quickly negotiate a higher value
    // android: you must request higher mtu yourself
    print('connectDevice - mtu $mtu');
  });

  // cleanup: cancel subscription when disconnected
  device.cancelWhenDisconnected(mtuSubscription);

  // Very important!
  if (isAndroid) {
    print('connectDevice - Android platform so need to update MTU');
    await device.requestMtu(512);
  }

  print('connectDevice - discover services');
  var hasWriteCharacteristic = false;
  final services = await device.discoverServices();
  for (BluetoothService service in services) {
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      final isWrite = characteristic.properties.write;
      if (isWrite) {
        debugPrint(
            'Found write characteristic: ${characteristic.uuid}, ${characteristic.properties}');
        hasWriteCharacteristic = true;
      }
    }
  }
  return hasWriteCharacteristic;
}
