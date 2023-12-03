import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'event_details_widget.dart' show EventDetailsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EventDetailsModel extends FlutterFlowModel<EventDetailsWidget> {
  ///  Local state fields for this page.

  bool generatingProofRequest = false;

  bool generatingProof = false;

  bool generatingTicket = false;

  bool? ticketIssued;

  String? proofRequest = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - generateProofRequest] action in button_2 widget.
  dynamic? proofRequestOutput;
  // Stores action output result for [Custom Action - authenticateCredential] action in button_2 widget.
  String? authenticateResult;
  // Stores action output result for [Custom Action - issueTicket] action in button_2 widget.
  FFUploadedFile? eventTicket;
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
