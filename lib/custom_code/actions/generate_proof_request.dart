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

import 'package:cloud_functions/cloud_functions.dart';
import 'package:word_generator/word_generator.dart';

Future<dynamic> generateProofRequest(
  String? credentialType,
  String? ldContext,
  String? sender,
  String? sessionId,
  String? circuitId,
) async {
  // Add your function code here!

  final wordGenerator = WordGenerator();
  List<String> nouns = wordGenerator.randomNouns(3);

  // sessionId ??= nouns.join();
  sessionId = nouns.join();

  try {
    final result = await FirebaseFunctions.instance
        .httpsCallable('polygonId-generateProofRequest')
        .call(
      {
        "type": credentialType,
        "ldContext": ldContext,
        "sender": sender,
        "sessionId": sessionId,
        "circuitId": circuitId,
      },
    );

    print('result.data: ${result.data}');
    return jsonEncode(result.data);
  } on FirebaseFunctionsException catch (error) {
    print(error.code);
    print(error.details);
    print(error.message);
  }
  return null;
}
