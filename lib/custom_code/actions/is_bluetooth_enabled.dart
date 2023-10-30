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
  await FlutterBluePlus.isOn;
  await Future.delayed(Duration(milliseconds: 100));
  final state = await FlutterBluePlus.instance.state.first;
  if (state == BluetoothState.on) {
    return true;
  }
  return false;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
