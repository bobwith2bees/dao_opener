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

import 'package:flutter_wallet_card/flutter_wallet_card.dart';

Future addToWallet(FFUploadedFile? passFile) async {
  /// It returns [PasskitFile] object
  final passkitFile = await FlutterWalletCard.generateFromFile(
    id: 'example-pass',
    //file: File('path-to-file.pkpass'),
    file: passFile.file,
  );

  final completed = await FlutterWalletCard.addPasskit(passkitFile);
}
