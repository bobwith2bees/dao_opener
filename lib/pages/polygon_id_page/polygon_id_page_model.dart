import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'polygon_id_page_widget.dart' show PolygonIdPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PolygonIdPageModel extends FlutterFlowModel<PolygonIdPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
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

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
