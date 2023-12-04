import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'event_details_model.dart';
export 'event_details_model.dart';

class EventDetailsWidget extends StatefulWidget {
  const EventDetailsWidget({Key? key}) : super(key: key);

  @override
  _EventDetailsWidgetState createState() => _EventDetailsWidgetState();
}

class _EventDetailsWidgetState extends State<EventDetailsWidget> {
  late EventDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventDetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return StreamBuilder<List<EventsRecord>>(
      stream: queryEventsRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: SpinKitPulse(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 50.0,
                ),
              ),
            ),
          );
        }
        List<EventsRecord> eventDetailsEventsRecordList = snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final eventDetailsEventsRecord =
            eventDetailsEventsRecordList.isNotEmpty ? eventDetailsEventsRecordList.first : null;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Events',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Open Sans',
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                maxWidth: 570.0,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/fifthpint-common-dev.appspot.com/o/logos%2Flogo.png?alt=media&token=6fe98646-b9c6-4d46-af33-b7c05dd3cc9a',
                                                width: 50.0,
                                                height: 50.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                          child: Text(
                                            dateTimeFormat(
                                              'MMMMEEEEd',
                                              eventDetailsEventsRecord!.startTime!,
                                              locale: FFLocalizations.of(context).languageCode,
                                            ),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Inter',
                                                  color: FlutterFlowTheme.of(context).primary,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 8.0, 2.0, 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/fifthpint-common-dev.appspot.com/o/events%2FhsYKqEldPvFM1OQHSoZm%2FeventBackground.png?alt=media&token=5f14215f-5f65-4f89-b7c5-f86ac953ca24',
                                          width: double.infinity,
                                          height: 230.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 12.0),
                                      child: Text(
                                        eventDetailsEventsRecord!.title,
                                        textAlign: TextAlign.center,
                                        style: FlutterFlowTheme.of(context).headlineMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                                      child: Text(
                                        dateTimeFormat(
                                          'relative',
                                          eventDetailsEventsRecord!.startTime!,
                                          locale: FFLocalizations.of(context).languageCode,
                                        ),
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Inter',
                                              color: FlutterFlowTheme.of(context).primary,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 12.0),
                                      child: Text(
                                        eventDetailsEventsRecord!.description,
                                        style: FlutterFlowTheme.of(context).labelMedium,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                                      child: Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          maxWidth: 570.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context).alternate,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 4.0),
                                                child: Text(
                                                  'Event Location',
                                                  style: FlutterFlowTheme.of(context).labelMedium,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                child: Text(
                                                  eventDetailsEventsRecord!.venueName,
                                                  style: FlutterFlowTheme.of(context).titleLarge,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                                                child: Text(
                                                  eventDetailsEventsRecord!.venueAddress,
                                                  style: FlutterFlowTheme.of(context).labelMedium,
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1.0,
                                                color: FlutterFlowTheme.of(context).accent4,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 4.0),
                                                child: Text(
                                                  'Ticket Requirements',
                                                  style: FlutterFlowTheme.of(context).labelMedium,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                                child: Text(
                                                  'Membership in a DAO',
                                                  style: FlutterFlowTheme.of(context).titleLarge,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!_model.ticketIssued! && !_model.credentialAuthenticated)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          var _shouldSetState = false;
                          setState(() {
                            _model.generatingProofRequest = true;
                            _model.generatingProof = false;
                            _model.generatingTicket = false;
                            _model.ticketIssued = false;
                            _model.credentialAuthenticated = false;
                            _model.proofRequestGenerated = false;
                          });
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Credential Verificaiton Required'),
                                    content: Text(
                                        'Good news your uh Mansplain DAO credential can get you in the door.  Use this credential stored in your default identity?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(alertDialogContext, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(alertDialogContext, true),
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            _model.proofRequestOutput = await actions.generateProofRequest(
                              'MembershipCredential',
                              'ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui',
                              'did:eth:cryptotomorrow',
                              null,
                              'credentialAtomicQuerySigV2',
                            );
                            _shouldSetState = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _model.proofRequestOutput!.toString(),
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                            _model.authenticateResuls = await actions.authenticateCredential(
                              _model.proofRequestOutput!.toString(),
                            );
                            _shouldSetState = true;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _model.authenticateResuls!,
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                            setState(() {
                              _model.credentialAuthenticated = true;
                            });
                          } else {
                            if (_shouldSetState) setState(() {});
                            return;
                          }

                          if (_shouldSetState) setState(() {});
                        },
                        text: 'Request To Attend',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  if (_model.credentialAuthenticated && !_model.ticketIssued!)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          _model.eventTicketCopy = await actions.issueTicket(
                            EventTypeStruct(
                              title: eventDetailsEventsRecord?.title,
                              description: eventDetailsEventsRecord?.description,
                              venueName: eventDetailsEventsRecord?.venueName,
                              venueAddress: eventDetailsEventsRecord?.venueAddress,
                              startTime: eventDetailsEventsRecord?.startTime,
                              endTime: eventDetailsEventsRecord?.endTime,
                              doorsOpen: eventDetailsEventsRecord?.doorsOpen,
                              location: eventDetailsEventsRecord?.location,
                              bands: eventDetailsEventsRecord?.bands,
                              beaconUUID: eventDetailsEventsRecord?.beaconUUID,
                              nfcSupported: eventDetailsEventsRecord?.nfcSupported,
                              food: eventDetailsEventsRecord?.food,
                              drink: eventDetailsEventsRecord?.drink,
                              parking: eventDetailsEventsRecord?.parking,
                              venueType: eventDetailsEventsRecord?.venueType,
                              eventType: eventDetailsEventsRecord?.eventType,
                            ),
                            'testing',
                          );
                          final selectedFiles = await selectFiles(
                            multiFile: false,
                          );
                          if (selectedFiles != null) {
                            setState(() => _model.isDataUploading = true);
                            var selectedUploadedFiles = <FFUploadedFile>[];

                            try {
                              showUploadMessage(
                                context,
                                'Uploading file...',
                                showLoading: true,
                              );
                              selectedUploadedFiles = selectedFiles
                                  .map((m) => FFUploadedFile(
                                        name: m.storagePath.split('/').last,
                                        bytes: m.bytes,
                                      ))
                                  .toList();
                            } finally {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              _model.isDataUploading = false;
                            }
                            if (selectedUploadedFiles.length == selectedFiles.length) {
                              setState(() {
                                _model.uploadedLocalFile = selectedUploadedFiles.first;
                              });
                              showUploadMessage(
                                context,
                                'Success!',
                              );
                            } else {
                              setState(() {});
                              showUploadMessage(
                                context,
                                'Failed to upload file',
                              );
                              return;
                            }
                          }

                          setState(() {
                            _model.generatingTicket = false;
                            _model.ticketIssued = true;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Ticket Issue Request Complete',
                                style: TextStyle(
                                  color: FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor: FlutterFlowTheme.of(context).secondary,
                            ),
                          );

                          setState(() {});
                        },
                        text: 'Issue Ticket (IOS)',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  if (false)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await actions.addToWallet(
                            _model.uploadedLocalFile,
                          );
                        },
                        text: 'Add to Wallet',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                              ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
