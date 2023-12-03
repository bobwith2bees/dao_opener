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

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:ffi';
import 'dart:io';

Future<FFUploadedFile?> issueTicket(
  EventTypeStruct eventData,
  String? authorizationCode,
) async {
  print('issueTicket - ');

  print('Event: ${eventData.title}, $eventData');
  // http post to a url with the body consisting of  json formatted eventReference.
  final url = 'https://us-central1-fifthpint-common-dev.cloudfunctions.net/pass';
  final headers = <String, String>{
    'Content-Type': 'application/json',
    // 'User-Agent': 'PostmanRuntime/7.35.0',
    // 'Accept': '*/*',
    // 'Cache-Control': 'no-cache',
    // 'Accept-Encoding': 'gzip, deflate, br',
    // 'Connection': 'keep-alive',
  };
  print('headers:$headers');

  Map<String, dynamic> eventTicket = {
    'passModel': 'event',
    "serialNumber": "abc123456",
    "textColor": "rgb(255,255,255)",
    "backgroundColor": "rgb(10,10,10)",
    "labelColor": "rgb(255,255,255)",
    "logoFile": "logo.png",
    "relevantDate": "2023-12-12T13:00-08:00",
    "header": [
      {"label": "Date", "value": "Dec 12, 2023"}
    ],
    "primary": [
      {"key": "event", "label": "Event", "value": eventData.title}
    ],
    "secondary": [
      {"key": "loc", "label": "Location", "value": eventData.venueName},
      {"key": "seat", "label": "Access", "value": "VIP Access"}
    ],
    "auxiliary": [
      {"label": "Time", "value": "7pm to Midnight"},
      {"label": "Bar", "value": (eventData.drink == BarOptions.openBar) ? "Open Bar" : "For Purchase"},
      {"label": "Food", "value": (eventData.food == FoodOptions.forPurchase) ? "For Purchase" : "None"},
    ],
    "qrText": "This is the ticket number",
    "codeAlt": "Ticket Number",
    "codeType": "PKBarcodeFormatPDF417"
  };

  // DevNote - this is not wrapped in a Firebase function (with authentication TODO before production.)
  final httpClient = HttpClient();

  final request = await httpClient.postUrl(Uri.parse(url));
  request.headers.contentType = ContentType("application", "json");
  // body
  request.add(
    utf8.encode(
      jsonEncode(eventTicket),
    ),
  );

  final HttpClientResponse response = await request.close();

  print('Response ${response.statusCode} with length ${response.contentLength}');

  // final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(eventTicket), encoding: null);
  if (response.statusCode == 200) {
    print('issueTicket - server responded 200 - OK .');
    final transformU8Int = StreamTransformer<int, Uint8>.fromHandlers(handleData: (data, sink) {
      sink.add(data as Uint8);
    });

    // Convert the stream data into a single list to pass as the file bytes
    List<List<int>> responseList = await response.toList();
    List<int> bytes = [];
    for (int i = 0; i < responseList.length; i++) {
      for (int data in responseList[i]) {
        bytes.add(data);
      }
    }
    print('bytes length: ${bytes.length}');

    FFUploadedFile eventPass = FFUploadedFile(name: "event.pkpass", bytes: Uint8List.fromList(bytes));
    return eventPass;
  } else {
    print("response: ${response.statusCode} - ${response.reasonPhrase}");
    return null;
    //throw Exception('Failed to issue ticket: ${response.statusCode} ${response.reasonPhrase}');
  }
}
