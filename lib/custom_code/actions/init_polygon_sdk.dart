// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:polygonid_flutter_sdk/sdk/polygon_id_sdk.dart';
import 'package:polygonid_flutter_sdk/common/domain/entities/env_entity.dart';
import 'package:polygonid_flutter_sdk/identity/domain/entities/private_identity_entity.dart';

// DevNote - FlutterFlow changes for SDK
// App Details > Advanced > Set Kotlin version to 1.8.0 (had gradle package conflicts)
// pubspec.yaml - Manually add polygonid_flutter_sdk since dependencies want pub.dev packages
// pubspec.yaml - Dependency override for path_provider to 2.0.14 (polygonid_flutter_sdk wants v2.0.15)
//

// Theses are defined in the make target or environment
const web3ApiKey = String.fromEnvironment('WEB3_API_KEY');
const ipfsApiKey = String.fromEnvironment('IPFS_API_KEY');
const ipfsApiKeySecret = String.fromEnvironment('IPFS_API_KEY_SECRET');

Future initPolygonSdk() async {
  print('initPolygonSdk -');

  // Referene https://github.com/0xPolygonID/polygonid-flutter-sdk/tree/main#supported-environments
  EnvEntity env = EnvEntity(
    blockchain: 'polygon',
    network: 'mumbai',
    web3Url: 'https://polygon-mumbai.infura.io/v3/',
    web3RdpUrl: 'wss://polygon-mumbai.infura.io/v3/',
    idStateContract: '0x134B1BE34911E39A8397ec6289782989729807a4',
    pushUrl: 'https://push-staging.polygonid.com/api/v1',
    // Credentials ** SENSITIVE DATA **
    web3ApiKey: web3ApiKey,
    ipfsUrl: 'https://$ipfsApiKey:$ipfsApiKeySecret@ipfs.infura.io:5001',
  );

  print('initPolygonSdk - init');
  await PolygonIdSdk.init(env: env);

  final sdk = PolygonIdSdk.I;

  print('initPolygonSdk - enable logging');
  await PolygonIdSdk.I.switchLog(enabled: true);

  print('initPolygonSdk - get EnvEntity');
  EnvEntity envEntity = await PolygonIdSdk.I.getEnv();
  // print('initPolygonSdk - $envEntity');

  print('initPolygonSdk - create identity');
  PrivateIdentityEntity identity = await sdk.identity.addIdentity();
  // Save identity to AppState
  FFAppState().update(() {
    FFAppState().privateIdentityEntity = identity.toJson();
  });

  String privateKey = identity.privateKey;
  String identifier = await sdk.identity.getDidIdentifier(
    privateKey: privateKey,
    blockchain: env.blockchain,
    network: env.network,
  );
  FFAppState().update(() {
    FFAppState().privateKey = privateKey;
  });

  print('initPolygonSdk - capture genesisDid');
  String? genesisDid = await sdk.identity.getDidIdentifier(
    privateKey: privateKey,
    blockchain: envEntity.blockchain,
    network: envEntity.network,
    profileNonce: null, // genesisDid has no Nonce
  );
  FFAppState().update(() {
    FFAppState().genesisDid = genesisDid;
  });

  print('initPolygonSdk - privateKey: $privateKey, genesisDid $genesisDid');

  // Iden3MessageEntity iden3messageEntity =
  //     await PolygonIdSdk.I.iden3comm.getIden3Message(message: "This is the message");
  print('initPolygonSdk - completed');

  return;
}