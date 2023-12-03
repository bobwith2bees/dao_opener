import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'polygon_id_page_widget.dart' show PolygonIdPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PolygonIdPageModel extends FlutterFlowModel<PolygonIdPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - addIdentity] action in Button widget.
  dynamic? addIdentityJson;
  // Stores action output result for [Custom Action - checkIdentity] action in Button widget.
  bool? identityResult;
  var qrScanResult = '';
  // State field(s) for QrText widget.
  FocusNode? qrTextFocusNode;
  TextEditingController? qrTextController;
  String? Function(BuildContext, String?)? qrTextControllerValidator;
  // Stores action output result for [Custom Action - requestCredential] action in Button widget.
  bool? requestCredentialResult;
  // Stores action output result for [Custom Action - generateProofRequest] action in Button widget.
  dynamic? proofRequestResponse;
  // Stores action output result for [Custom Action - authenticateCredential] action in Button widget.
  String? authenticateResult2;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    qrTextFocusNode?.dispose();
    qrTextController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
