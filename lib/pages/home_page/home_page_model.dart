import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/widgets/empty_devices/empty_devices_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool isFetchingDeices = false;

  bool isBluetoothEnabled = false;

  List<BTDeviceStruct> foundDevices = [];
  void addToFoundDevices(BTDeviceStruct item) => foundDevices.add(item);
  void removeFromFoundDevices(BTDeviceStruct item) => foundDevices.remove(item);
  void removeAtIndexFromFoundDevices(int index) => foundDevices.removeAt(index);
  void insertAtIndexInFoundDevices(int index, BTDeviceStruct item) =>
      foundDevices.insert(index, item);
  void updateFoundDevicesAtIndex(
          int index, Function(BTDeviceStruct) updateFn) =>
      foundDevices[index] = updateFn(foundDevices[index]);

  bool isFetchingConnectedDevices = false;

  List<BTDeviceStruct> connnectedDevices = [];
  void addToConnnectedDevices(BTDeviceStruct item) =>
      connnectedDevices.add(item);
  void removeFromConnnectedDevices(BTDeviceStruct item) =>
      connnectedDevices.remove(item);
  void removeAtIndexFromConnnectedDevices(int index) =>
      connnectedDevices.removeAt(index);
  void insertAtIndexInConnnectedDevices(int index, BTDeviceStruct item) =>
      connnectedDevices.insert(index, item);
  void updateConnnectedDevicesAtIndex(
          int index, Function(BTDeviceStruct) updateFn) =>
      connnectedDevices[index] = updateFn(connnectedDevices[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getConnectedDevices] action in HomePage widget.
  List<BTDeviceStruct>? fetchedConnectedDevices;
  // Stores action output result for [Custom Action - findDevices] action in HomePage widget.
  List<BTDeviceStruct>? devices;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Custom Action - turnOnBluetooth] action in Switch widget.
  bool? isTurningOn;
  // Stores action output result for [Custom Action - getConnectedDevices] action in Switch widget.
  List<BTDeviceStruct>? fetchedConnectedDevicesOn;
  // Stores action output result for [Custom Action - findDevices] action in Switch widget.
  List<BTDeviceStruct>? findDevicesListOn;
  // Stores action output result for [Custom Action - turnOffBluetooth] action in Switch widget.
  bool? isTurningOff;
  // Stores action output result for [Custom Action - findDevices] action in Icon widget.
  List<BTDeviceStruct>? findDevicesListReload;
  // Stores action output result for [Custom Action - connectDevice] action in ScannedDeviceTile widget.
  bool? hasWrite;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
