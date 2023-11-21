import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/widgets/empty_devices/empty_devices_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bluetooth_page_model.dart';
export 'bluetooth_page_model.dart';

class BluetoothPageWidget extends StatefulWidget {
  const BluetoothPageWidget({
    Key? key,
    bool? isBTEnabled,
  })  : this.isBTEnabled = isBTEnabled ?? true,
        super(key: key);

  final bool isBTEnabled;

  @override
  _BluetoothPageWidgetState createState() => _BluetoothPageWidgetState();
}

class _BluetoothPageWidgetState extends State<BluetoothPageWidget>
    with TickerProviderStateMixin {
  late BluetoothPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'textOnPageLoadAnimation1': AnimationInfo(
      loop: true,
      reverse: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0.5,
          end: 1.0,
        ),
      ],
    ),
    'textOnPageLoadAnimation2': AnimationInfo(
      loop: true,
      reverse: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0.5,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BluetoothPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.isBluetoothEnabled = widget.isBTEnabled;
      });
      if (widget.isBTEnabled) {
        setState(() {
          _model.isFetchingDeices = true;
          _model.isFetchingConnectedDevices = true;
        });
        _model.fetchedConnectedDevices = await actions.getConnectedDevices();
        setState(() {
          _model.isFetchingConnectedDevices = false;
          _model.connnectedDevices =
              _model.fetchedConnectedDevices!.toList().cast<BTDeviceStruct>();
        });
        _model.devices = await actions.findDevices();
        setState(() {
          _model.isFetchingDeices = false;
          _model.foundDevices = _model.devices!.toList().cast<BTDeviceStruct>();
        });
      }
    });
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
            'Bluetooth Screen',
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enable Bluetooth',
                    style: FlutterFlowTheme.of(context).bodyLarge,
                  ),
                  Switch.adaptive(
                    value: _model.switchValue ??= widget.isBTEnabled,
                    onChanged: (newValue) async {
                      setState(() => _model.switchValue = newValue!);
                      if (newValue!) {
                        _model.isTurningOn = await actions.turnOnBluetooth();
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        setState(() {
                          _model.isBluetoothEnabled = true;
                          _model.isFetchingDeices = true;
                          _model.isFetchingConnectedDevices = true;
                        });
                        _model.fetchedConnectedDevicesOn =
                            await actions.getConnectedDevices();
                        setState(() {
                          _model.foundDevices = _model
                              .fetchedConnectedDevicesOn!
                              .toList()
                              .cast<BTDeviceStruct>();
                          _model.isFetchingConnectedDevices = false;
                        });
                        _model.findDevicesListOn = await actions.findDevices();
                        setState(() {
                          _model.connnectedDevices = _model.findDevicesListOn!
                              .toList()
                              .cast<BTDeviceStruct>();
                          _model.isFetchingDeices = false;
                        });

                        setState(() {});
                      } else {
                        _model.isTurningOff = await actions.turnOffBluetooth();
                        await Future.delayed(
                            const Duration(milliseconds: 1000));
                        setState(() {
                          _model.isBluetoothEnabled = false;
                        });

                        setState(() {});
                      }
                    },
                    activeColor: FlutterFlowTheme.of(context).primary,
                    activeTrackColor: FlutterFlowTheme.of(context).accent1,
                    inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                    inactiveThumbColor:
                        FlutterFlowTheme.of(context).secondaryText,
                  ),
                ],
              ),
              Divider(
                thickness: 0.5,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
              Expanded(
                child: Stack(
                  children: [
                    if (_model.isBluetoothEnabled)
                      Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Connected Devices',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                            ),
                                            if (_model
                                                .isFetchingConnectedDevices)
                                              Text(
                                                'Finding...',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmall,
                                              ).animateOnPageLoad(animationsMap[
                                                  'textOnPageLoadAnimation1']!),
                                          ],
                                        ),
                                      ),
                                      ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 16.0, 0.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final displayConnectedDevices =
                                                    _model.connnectedDevices
                                                        .toList();
                                                if (displayConnectedDevices
                                                    .isEmpty) {
                                                  return Center(
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 50.0,
                                                      child: EmptyDevicesWidget(
                                                        text: 'No Devices',
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount:
                                                      displayConnectedDevices
                                                          .length,
                                                  itemBuilder: (context,
                                                      displayConnectedDevicesIndex) {
                                                    final displayConnectedDevicesItem =
                                                        displayConnectedDevices[
                                                            displayConnectedDevicesIndex];
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  12.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            'DevicePage',
                                                            queryParameters: {
                                                              'deviceName':
                                                                  serializeParam(
                                                                valueOrDefault<
                                                                    String>(
                                                                  displayConnectedDevicesItem
                                                                      .name,
                                                                  'Unknown',
                                                                ),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'deviceId':
                                                                  serializeParam(
                                                                valueOrDefault<
                                                                    String>(
                                                                  displayConnectedDevicesItem
                                                                      .id,
                                                                  'Unknown Id',
                                                                ),
                                                                ParamType
                                                                    .String,
                                                              ),
                                                              'deviceRssi':
                                                                  serializeParam(
                                                                displayConnectedDevicesItem
                                                                    .rssi,
                                                                ParamType.int,
                                                              ),
                                                              'hasWriteCharacteristic':
                                                                  serializeParam(
                                                                true,
                                                                ParamType.bool,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .accent2,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        12.0,
                                                                        16.0,
                                                                        12.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              8.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            displayConnectedDevicesItem.name,
                                                                            style:
                                                                                FlutterFlowTheme.of(context).bodyLarge,
                                                                          ),
                                                                        ),
                                                                        StrengthIndicatorWidget(
                                                                          key: Key(
                                                                              'Key8qd_${displayConnectedDevicesIndex}_of_${displayConnectedDevices.length}'),
                                                                          rssi:
                                                                              displayConnectedDevicesItem.rssi,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).success,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        displayConnectedDevicesItem
                                                                            .id,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelSmall,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward_ios_rounded,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 24.0,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 50.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Devices',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              if (!_model.isFetchingDeices)
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.findDevicesListReload =
                                                        await actions
                                                            .findDevices();
                                                    setState(() {
                                                      _model.foundDevices = _model
                                                          .findDevicesListReload!
                                                          .toList()
                                                          .cast<
                                                              BTDeviceStruct>();
                                                    });

                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.refresh_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 22.0,
                                                  ),
                                                ),
                                              if (_model.isFetchingDeices)
                                                Text(
                                                  'Scanning...',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodySmall,
                                                ).animateOnPageLoad(animationsMap[
                                                    'textOnPageLoadAnimation2']!),
                                            ],
                                          ),
                                        ),
                                        ListView(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 16.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final displayFoundDevices =
                                                      _model.foundDevices
                                                          .toList();
                                                  if (displayFoundDevices
                                                      .isEmpty) {
                                                    return Center(
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 50.0,
                                                        child:
                                                            EmptyDevicesWidget(
                                                          text: 'No Devices',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        displayFoundDevices
                                                            .length,
                                                    itemBuilder: (context,
                                                        displayFoundDevicesIndex) {
                                                      final displayFoundDevicesItem =
                                                          displayFoundDevices[
                                                              displayFoundDevicesIndex];
                                                      return Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.hasWrite =
                                                                await actions
                                                                    .connectDevice(
                                                              displayFoundDevicesItem,
                                                            );
                                                            setState(() {
                                                              _model.addToConnnectedDevices(
                                                                  displayFoundDevicesItem);
                                                            });

                                                            context.pushNamed(
                                                              'DevicePage',
                                                              queryParameters: {
                                                                'deviceName':
                                                                    serializeParam(
                                                                  displayFoundDevicesItem
                                                                      .name,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'deviceId':
                                                                    serializeParam(
                                                                  displayFoundDevicesItem
                                                                      .id,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'deviceRssi':
                                                                    serializeParam(
                                                                  displayFoundDevicesItem
                                                                      .rssi,
                                                                  ParamType.int,
                                                                ),
                                                                'hasWriteCharacteristic':
                                                                    serializeParam(
                                                                  _model
                                                                      .hasWrite,
                                                                  ParamType
                                                                      .bool,
                                                                ),
                                                              }.withoutNulls,
                                                            );

                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          12.0,
                                                                          16.0,
                                                                          12.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              displayFoundDevicesItem.name,
                                                                              style: FlutterFlowTheme.of(context).bodyLarge,
                                                                            ),
                                                                          ),
                                                                          StrengthIndicatorWidget(
                                                                            key:
                                                                                Key('Key0ft_${displayFoundDevicesIndex}_of_${displayFoundDevices.length}'),
                                                                            rssi:
                                                                                displayFoundDevicesItem.rssi,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).success,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          displayFoundDevicesItem
                                                                              .id,
                                                                          style:
                                                                              FlutterFlowTheme.of(context).labelSmall,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .arrow_forward_ios_rounded,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 24.0,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (!_model.isBluetoothEnabled)
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Text(
                            'Turn on bluetooth to connect with any device',
                            style: FlutterFlowTheme.of(context).labelMedium,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
