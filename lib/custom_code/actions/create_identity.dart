// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';

Future<dynamic> createIdentity(String? secret) async {
  final sdk = PolygonIdSdk.I;

  PrivateIdentityEntity identity =
      await sdk.identity.createIdentity(secret: secretKey);

  return identity.toJson;
}
