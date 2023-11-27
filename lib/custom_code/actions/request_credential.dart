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

Future requestCredential(
  String message,
  String? genesisDid,
  String? privateKey,
  String? nonce,
) async {
  print('requestCredential');

  try {
    Iden3MessageEntity iden3messageEntity = await getIden3Message(message);
  } on Exception catch (e) {
    print('requestCredential - Error parsing iden3 message "$message": $e');
    return false;
  }

  genesisDid ??= FFAppState().identityGenesisId;
  privateKey ??= FFAppState().idendityPrivateKey;
  nonce ??= '';

  try {
    await PolygonIdSdk.I.iden3comm.fetchAndSaveClaims(
      message: iden3messageEntity,
      genesisDid: genesisDid,
      profileNonce: BigInt.tryParse(nonce),
      privateKey: privateKey,
    );
  } on Exception catch (e) {
    print('requestCredential - error during fetchAndSaveClaims $e');
    return false;
  }
  return;
}
