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

import 'package:polygonid_flutter_sdk/credential/domain/entities/claim_entity.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:http/http.dart' as http;

String testCredential =
    "iden3comm://?request_uri=https://issuer-admin.polygonid.me/v1/qr-store?id=db0c71f3-608b-4cde-b72b-bd3efb212fb4";
String testCredentialJson =
    '{"message":"Invalid format for parameter id: error unmarshaling \'db0c71f3-608b-4cde-b72b-bd3efb212fb4\"\' text as *uuid.UUID: invalid UUID length: 37"}';

// https://issuer-ui.polygonid.me/
// did:polygonid:polygon:mumbai:2qGZqUP2LtnCubFS8MCF125qf67Kd8gkyWa4nU2qqu
// DAO Membership Schema URL : ipfs://QmeWR5QsDM3vSLLGryYH6shtYzCDYMPsLi3SiXGiuPHAmd
// DAO Membership LD-Context : ipfs://QmV2B1xLRUZfb2zLUg4xM3tVYJgUg1R9E7jGz6Hf6em2Ui
// https://issuer-ui.polygonid.me/credentials/scan-link/42e42ce1-df19-4000-ba48-d32d19af1092
// iden3comm://?request_uri=https://issuer-admin.polygonid.me/v1/qr-store?id=d75e2890-1390-4fe8-851e-8e5f1c725e64
//

Future<bool> requestCredential(
  String message,
  String? genesisDid,
  String? privateKey,
  String? nonce,
) async {
  print('requestCredential - message $message');

  // Check for URI
  if (message.startsWith('iden3comm://?request_uri=')) {
    String uriString = message.substring(25);
    final response = await http.get(Uri.parse(uriString));
    print('requestCredential - load from request_uri: $uriString');
    if (response.statusCode == 200) {
      message = response.body;
      print('requestCredential - message: $message');
    } else {
      print(
          'requestCredential - unable to load $uriString, response: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Iden3MessageEntity iden3messageEntity;
  try {
    iden3messageEntity =
        await PolygonIdSdk.I.iden3comm.getIden3Message(message: message);
  } on Exception catch (e) {
    print('requestCredential - Error parsing iden3 message "$message": $e');
    rethrow;
    return false;
  }

  genesisDid ??= FFAppState().identityGenesisId;
  privateKey ??= FFAppState().idendityPrivateKey;
  nonce ??= '';

  try {
    List<ClaimEntity> claims =
        await PolygonIdSdk.I.iden3comm.fetchAndSaveClaims(
      message: iden3messageEntity,
      genesisDid: genesisDid,
      profileNonce: BigInt.tryParse(nonce),
      privateKey: privateKey,
    );
    print('requestCredential - ${claims.length} claims processed.');
    for (int i = 0; i < claims.length; i++) {
      print('requestCredential - [$i] ${claims[i]}');
    }
  } on Exception catch (e) {
    print('requestCredential - error during fetchAndSaveClaims $e');
    return false;
  }
  return true;
}
