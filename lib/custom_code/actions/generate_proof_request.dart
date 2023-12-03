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

Future<dynamic> generateProofRequest(
  String? credentialType,
  String? ldContext,
  String? sender,
  String? sessionId,
  String? circuitId,
) async {
  // Add your function code here!

  try {
    final result = await FirebaseFunctions.instance
        .httpsCallable('polygonId-generateProofRequest')
        .call(
      {
        "credentialType": credentialType,
        "ldContext": ldContext,
        "sender": sender,
        "sessionId": sessionId,
        "circuitId": circuitId,
      },
    );
    return result.data as String;
  } on FirebaseFunctionsException catch (error) {
    print(error.code);
    print(error.details);
    print(error.message);
  }
  return null;
}
