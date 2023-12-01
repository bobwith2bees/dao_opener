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

FFUploadedFile? issueTicket(
  EventTypeStruct eventData,
  String? authorizationCode,
) {
  // http post to a url with the body consisting of  json formatted eventReference.
  final url =
      'https://us-central1-fifthpint-common-dev.cloudfunctions.net/pass';
  final headers = {'Authorization': authorizationCode ?? currentJwtToken};
  final body = json.encode(eventReference.toJson());
  final response = http.post(Uri.parse(url), headers: headers, body: body);
  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    return FFUploadedFile.fromJson(jsonBody);
  } else {
    throw Exception('Failed to issue ticket: ${response.statusCode}');
  }
}
