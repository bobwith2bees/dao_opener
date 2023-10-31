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
  // Increase to see all the scan results
  FlutterBluePlus.setLogLevel(LogLevel.debug, color: false);

  Set<DeviceIdentifier> seen = {};
  List<BTDeviceStruct> devices = [];

  print('findDevices - setup listener _scanResultsSubscription');
  StreamSubscription<List<ScanResult>> _scanResultsSubscription =
      FlutterBluePlus.scanResults.listen((results) {
    // print('findDevices - results: ${results.length}');
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
      // print(
      //     'getConnectedDevices - platformName: ${deviceResult.device.platformName}, remoteId: ${deviceResult.device.remoteId.toString()}, rssi: ${deviceResult.rssi}');
      devices.add(BTDeviceStruct(
        name: deviceResult.device.platformName,
        id: deviceResult.device.remoteId.toString(),
        rssi: deviceResult.rssi,
      ));
    });
  }, onError: (err, stack) {
    print(
        'getConnectedDevices - _scanResultsSubscription the stream had an error $err, $stack');
  }, onDone: () {
    print('getConnectedDevices - _scanResultsSubscription stream is done :)');
  });

  final isScanning = FlutterBluePlus.isScanningNow;
  if (!isScanning) {
    print('findDevices - startScan');
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    } on Exception catch (e) {
      print('findDevices - startScan exception: $e');
    }
  }

  // FlutterBluePlus.startScan doesn't block so we need to wait for the stream to have results
  await Future.delayed(Duration(milliseconds: 5000));
  print('findDevices - found ${devices.length} devices in the first 5 seconds');
  await Future.delayed(Duration(seconds: 5));
  print('findDevices - found ${devices.length} devices after 5 more seconds');

  _scanResultsSubscription.cancel();
  return devices;
}
