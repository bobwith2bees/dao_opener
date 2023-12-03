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
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future addToWallet(FFUploadedFile? passFile) async {
  /// It returns [PasskitFile] object

  if (passFile == null) {
    print('addToWallet - No file to add.');
    return;
  } else {
    print(
        'addToWallet - name: ${passFile.name}, bytes: ${passFile.bytes?.length ?? 0}');
  }

  // Drop a copy in the appliation's document folder for save keeping, and the library flutter_wallet_card wants a file.
  final documentsDir = await getApplicationDocumentsDirectory();
  String documentsPath = documentsDir.path;

  File passFileOnDisk = File("$documentsPath/walletPass.pkpass");
  await passFileOnDisk.create(recursive: true);

  print('addToWallet - saving to local file ${passFileOnDisk.path}');
  passFileOnDisk.writeAsBytesSync(passFile.bytes ?? []);

  print('addToWallet - extracting pass contents}');
  final passkitFile = await FlutterWalletCard.generateFromFile(
      id: 'dao-opener', file: passFileOnDisk);

  print('addToWallet - user clicked addPasskit to wallet}');
  final completed = await FlutterWalletCard.addPasskit(passkitFile);
}
