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
import 'package:polygonid_flutter_sdk/identity/domain/entities/identity_entity.dart';
import 'package:polygonid_flutter_sdk/proof/domain/entities/download_info_entity.dart';
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

//  DevNote - Modified this private_identity_entity.dart to add cast as Map<String, dynamic>
PrivateIdentityEntity privateIdentityEntityFromJson(Map<String, dynamic> json) {
  return PrivateIdentityEntity(
    did: json['did'],
    publicKey: List<String>.from(json['publicKey']),
    profiles: (json['profiles'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(BigInt.parse(key), value)),
    privateKey: json['privateKey'],
  );
}

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

  print('initPolygonSdk - getIdentities');
  List<IdentityEntity> identities = await sdk.identity.getIdentities();
  if (identities.isNotEmpty) {
    for (IdentityEntity identity in identities) {
      print('initPolygonSdk - getIdentities - profiles ${identity.profiles}');
    }
  } else {
    print('initPolygonSdk - getIdentities - No existing identities.');
  }

  // PrivateIdentities have the private key
  PrivateIdentityEntity privateIdentity;
  try {
    if (FFAppState().privateIdentityEntity == null) {
      throw 'no identity information stored on device';
    }
    print(
        'initPolygonSdk - attempt to restore existing privateIdentity from secure storage.');
    privateIdentity =
        privateIdentityEntityFromJson(FFAppState().privateIdentityEntity);
    print(
        'initPolygonSdk - privateIdentity restored for did ${privateIdentity.did}');
  } catch (e) {
    print(
        'initPolygonSdk -  error restoring privateIdentity: $e.  *** Creating new privateIdentity ***');
    privateIdentity = await sdk.identity.addIdentity();
    // Save identity to AppState
    FFAppState().update(() {
      FFAppState().privateIdentityEntity = privateIdentity.toJson();
      FFAppState().identityBlockchain = envEntity.blockchain;
      FFAppState().identityNetwork = envEntity.network;
    });
  }

  String privateKey = privateIdentity.privateKey;
  String identifier = await sdk.identity.getDidIdentifier(
    privateKey: privateKey,
    blockchain: env.blockchain,
    network: env.network,
  );
  FFAppState().update(() {
    FFAppState().idendityPrivateKey = privateKey;
  });

  print('initPolygonSdk - capture genesisDid');
  String? genesisDid = await sdk.identity.getDidIdentifier(
    privateKey: privateKey,
    blockchain: envEntity.blockchain,
    network: envEntity.network,
    profileNonce: null, // genesisDid has no Nonce
  );
  FFAppState().update(() {
    FFAppState().identityGenesisId = genesisDid;
  });

  print('initPolygonSdk - privateKey: $privateKey, genesisDid $genesisDid');

  // What Claims do we have?
  List<ClaimEntity> claimList = await sdk.credential.getClaims(
    genesisDid: privateIdentity.did,
    privateKey: privateIdentity.privateKey,
  );

  if (claimList.isNotEmpty) {
    for (ClaimEntity claimEntity in claimList) {
      print('initPolygonSdk - claim: $claimEntity');

      // if (claimList.length > 2) {
      //   print('removing old claim ${claimEntity.type}');
      //   await sdk.credential.removeClaim(claimId: claimEntity.id, genesisDid: genesisDid, privateKey: privateKey);
      // }
    }
  } else {
    print('initPolygonSdk - no claims found');
  }

  Map<BigInt, String> profiles = await sdk.identity
      .getProfiles(genesisDid: genesisDid, privateKey: privateKey);
  profiles.forEach((k, v) => print("Nonce : $k, privateDid : $v"));

  print('initPolygonSdk - start circuits download');
  Stream<DownloadInfo> stream =
      PolygonIdSdk.I.proof.initCircuitsDownloadAndGetInfoStream;

  FFAppState().update(() {
    FFAppState().isCircuitDownloading = true;
  });

  StreamSubscription? _subscription;
  _subscription = stream.listen((downloadInfo) {
    switch (downloadInfo.downloadInfoType) {
      case DownloadInfoType.onDone:
        print('StreamSubscription - circuits download complete');
        FFAppState().update(() {
          FFAppState().isCircuitDownloading = false;
        });
        break;

      case DownloadInfoType.onError:
        print('StreamSubscription - circuits download error $downloadInfo');
        FFAppState().update(() {
          FFAppState().isCircuitDownloading = false;
        });
        break;

      case DownloadInfoType.onProgress:
      default:
        break;
    }

    // Suppress lots of status updates
    //if (downloadInfo.downloadInfoType != DownloadInfoType.onProgress) {
    print('circuits download event - $downloadInfo');
    //}
  });

  // Iden3MessageEntity iden3messageEntity =
  //     await PolygonIdSdk.I.iden3comm.getIden3Message(message: "This is the message");
  print('initPolygonSdk - completed');

  return;
}
