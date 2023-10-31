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

Future<List<BTDeviceStruct>> findDevices() async {
  print('findDevices - starting');
  Set<DeviceIdentifier> seen = {};

  List<BTDeviceStruct> devices = [];
  FlutterBluePlus.scanResults.listen(
    (results) {
      List<ScanResult> scannedDevices = [];
      for (ScanResult r in results) {
        if (r.device.platformName.isNotEmpty) {
          if (seen.contains(r.device.remoteId) == false) {
            print(
                '${r.device.remoteId}: "${r.advertisementData.localName}" found! rssi: ${r.rssi}');
            seen.add(r.device.remoteId);
          }
          scannedDevices.add(r);
        }
      }
      scannedDevices.sort((a, b) => b.rssi.compareTo(a.rssi));
      devices.clear();
      scannedDevices.forEach((deviceResult) {
        print(
            'getConnectedDevices - platformName: ${deviceResult..device.platformName}, remoteId" ${deviceResult.device.remoteId.toString()}, rssi: ${deviceResult.rssi}');
        devices.add(BTDeviceStruct(
          name: deviceResult.device.platformName,
          id: deviceResult.device.remoteId.toString(),
          rssi: deviceResult.rssi,
        ));
      });
    },
  );

  final isScanning = FlutterBluePlus.isScanningNow;
  if (!isScanning) {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 5),
    );
  }

  // Stop scanning
  await FlutterBluePlus.stopScan();

  print('findDevices - found ${devices.length} devices');

  return devices;
}
