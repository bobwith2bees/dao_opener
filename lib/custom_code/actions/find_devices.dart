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

/// Keeping this uppercase since the libraries seem to prefer it
const cPolygonIdUUID = '5A09ECEE-C70D-4256-860E-23E3B21B9E88';

String printHexString(List<int>? intList) {
  String result = '0x';
  intList = intList ?? [];

  if (intList.isEmpty) {
    return 'null';
  }
  for (int i in intList) {
    result += '${i.toRadixString(16).padLeft(2, '0')}';
  }
  return result;
}

String printMfgData(Map<int, List<int>> mfgData) {
  String result = 'mfg: ';

  if (mfgData.isEmpty) {
    return result;
  }
  mfgData.forEach((key, value) {
    result += '${key.toRadixString(16).padLeft(2, '0')}: ' +
        printHexString(value) +
        ' ';
  });
  return result;
}

Future<List<BTDeviceStruct>> findDevices() async {
  print('findDevices - starting');
  // Increase to verbose see all the scan results
  // FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
  FlutterBluePlus.setLogLevel(LogLevel.debug, color: false);

  Set<DeviceIdentifier> seen = {};
  List<BTDeviceStruct> devices = [];

  print('findDevices - setup listener _scanResultsSubscription');
  StreamSubscription<List<ScanResult>> _scanResultsSubscription =
      FlutterBluePlus.scanResults.listen((results) {
    // print('findDevices - results: ${results.length}');
    List<ScanResult> scannedDevices = [];
    for (ScanResult r in results) {
      // format the manufacture data in hex bytes
      String mfgData =
          printMfgData(r.advertisementData.manufacturerData).toLowerCase();
      // strip the UUID of -'s and look for it in the manufacture data
      bool mfgDataHasUUID =
          mfgData.contains(cPolygonIdUUID.replaceAll('-', '').toLowerCase());

      if (r.device.platformName.isNotEmpty | mfgDataHasUUID) {
        if (seen.contains(r.device.remoteId) == false) {
          print(
            'findDevices - id: ${r.device.remoteId} platformName: "${r.device.platformName.padLeft(15)}" '
                    'localName: "${r.advertisementData.localName.padLeft(15)}" '
                    'rssi: ${r.rssi.toString().padLeft(3)} '
                    'services: ${r.device.servicesList?.length ?? 0}, '
                    'service Uuids: ${r.advertisementData.serviceUuids}, '
                    'tx power: ${r.advertisementData.txPowerLevel ?? 'N/A'}, ' +
                printMfgData(r.advertisementData.manufacturerData),

            ///   'mfg:${r.advertisementData.manufacturerData}'
          );
          seen.add(r.device.remoteId);

          // Android Flutter BLE Peripheral
          if (mfgDataHasUUID) {
            print(
                '_scanResultsSubscription: **** MATCH **** GUID in Manufacturing DATA $mfgData');
          }

          // Check Manufacture info for GUID

          // Android Flutter BLE Peripheral
          if (r.advertisementData.serviceUuids
                  .contains(cPolygonIdUUID.toUpperCase()) |
              r.advertisementData.serviceUuids
                  .contains(cPolygonIdUUID.toLowerCase())) {
            print(
                '_scanResultsSubscription: **** MATCH **** SERVICE GUID r.advertisementData.serviceUuids.');
          }

          // Android can read IOS iBeacon
          if (r.advertisementData.manufacturerData[0x4c] == [8, 6, 7, 5]) {
            print(
                '_scanResultsSubscription: **** MATCH **** manufacturerData.');
          }

          // iPhones Flutter BLE Peripheral
          if (r.advertisementData.localName.startsWith('PolygonID')) {
            print('_scanResultsSubscription: **** MATCH **** localName.');
          }

          // Bluetooth Beacon
          if (r.device.platformName.startsWith('PolygonID')) {
            print('_scanResultsSubscription: **** MATCH **** platformName.');
          }
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
        name: deviceResult.device.platformName.isNotEmpty
            ? deviceResult.device.platformName
            : 'PolygonID-Beacon',
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
      // DevNote - This scan uses ACCESS_FINE_LOCATION because I don't know if FlutterFire can ass
      // android:usesPermissionFlags="neverForLocation" to the BLUETOOTH_SCAN
      // await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10), androidUsesFineLocation: true);
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 10),
        androidUsesFineLocation: true,
        // IOS you can see the device if you look for the specific GUID?  No luck
        //withServices: Platform.isIOS ? [Guid('5a09ecee-c70d-4256-860e-23e3b21b9e88')] : [],
      );
    } on Exception catch (e) {
      print('findDevices - startScan exception: $e');
    }
  }

  // DevNote - FlutterBluePlus.startScan doesn't block so we need to wait for the stream to have results
  await Future.delayed(Duration(milliseconds: 5000));
  print('findDevices - found ${devices.length} devices in the first 5 seconds');
  await Future.delayed(Duration(seconds: 5));
  print('findDevices - found ${devices.length} devices after 5 more seconds');

  _scanResultsSubscription.cancel();
  return devices;
}
