// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

Future<dynamic> addIdentity(String? secretKey) async {
  PrivateIdentityEntity identity = await PolygonIdSdk.I.identity.addIdentity(
    secret: secretKey,
  );
  return identity.toJson;
}
