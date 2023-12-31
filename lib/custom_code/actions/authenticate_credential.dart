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

import 'package:http/http.dart' as http;
import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk/iden3comm/domain/entities/common/iden3_message_entity.dart';
import 'package:polygonid_flutter_sdk/common/data/exceptions/network_exceptions.dart';
import 'dart:convert';

class QrcodeParserUtils {
  final PolygonIdSdk _polygonIdSdk;

  QrcodeParserUtils(this._polygonIdSdk);

  Future<Iden3MessageEntity> getIden3MessageFromQrCode(String message) async {
    try {
      String rawMessage = message;

      // old server added quotes
      if (message.startsWith('"') && message.endsWith('"')) {
        print('QrcodeParserUtils - stripping extra quotes on $message');
        message = message.substring(1, (message.length - 1));
      }
      if (message.startsWith("iden3comm://?i_m")) {
        rawMessage = await _getMessageFromBase64(message);
      }

      if (message.startsWith("iden3comm://?request_uri")) {
        rawMessage = await _getMessageFromRemote(message);
      }

      Iden3MessageEntity? _iden3Message =
          await _polygonIdSdk.iden3comm.getIden3Message(message: rawMessage);
      return _iden3Message;
    } catch (error) {
      throw Exception("Error while processing the QR code");
    }
  }

  Future<String> _getMessageFromRemote(String message) async {
    try {
      message = message.replaceAll("iden3comm://?request_uri=", "");
      http.Response response = await http.get(Uri.parse(message));
      if (response.statusCode != 200) {
        throw Exception("Error while getting the message from the remote");
      }
      return response.body;
    } catch (error) {
      throw Exception("Error while getting the message from the remote");
    }
  }

  Future<String> _getMessageFromBase64(String message) async {
    try {
      message = message.replaceAll("iden3comm://?i_m=", "");
      String decodedMessage = String.fromCharCodes(base64.decode(message));
      return decodedMessage;
    } catch (error) {
      throw Exception("Error while getting the message from the base64");
    }
  }
}

Future<String> authenticateCredential(String message) async {
  // Add your function code here!

  print('authenticateCredential -');

  try {
    var messageDecoded = jsonDecode(message);
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(messageDecoded);
    debugPrint(prettyprint);
  } on Exception catch (e) {
    print('authenticateCredential - message: $message');
  }

  QrcodeParserUtils qrcodeParserUtils = QrcodeParserUtils(PolygonIdSdk.I);

  Iden3MessageEntity iden3messageEntity;
  try {
    iden3messageEntity =
        await qrcodeParserUtils.getIden3MessageFromQrCode(message);
  } on Exception catch (e) {
    print('authenticateCredential - error decoding message $e');
    return "Error decoding iden3 message: $message";
  }

  try {
    await PolygonIdSdk.I.iden3comm.authenticate(
      message: iden3messageEntity,
      genesisDid: FFAppState().identityGenesisId,
      privateKey: FFAppState().idendityPrivateKey,
      profileNonce: null,
    );
  } on NetworkException {
    print('authenticateCredential - Network exception possibly the callback?');
  } on Exception catch (e) {
    print('authenticateCredential - error authenticating message $e');
    return "Error calling authenticate $e";
  }

  return "Done!";
}
