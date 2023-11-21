// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PrivateIdentityEntityStruct extends FFFirebaseStruct {
  PrivateIdentityEntityStruct({
    String? did,
    List<String>? publicKey,
    String? privateKey,
    List<IdentityProfileStruct>? profiles,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _did = did,
        _publicKey = publicKey,
        _privateKey = privateKey,
        _profiles = profiles,
        super(firestoreUtilData);

  // "did" field.
  String? _did;
  String get did => _did ?? '';
  set did(String? val) => _did = val;
  bool hasDid() => _did != null;

  // "publicKey" field.
  List<String>? _publicKey;
  List<String> get publicKey => _publicKey ?? const [];
  set publicKey(List<String>? val) => _publicKey = val;
  void updatePublicKey(Function(List<String>) updateFn) =>
      updateFn(_publicKey ??= []);
  bool hasPublicKey() => _publicKey != null;

  // "privateKey" field.
  String? _privateKey;
  String get privateKey => _privateKey ?? '';
  set privateKey(String? val) => _privateKey = val;
  bool hasPrivateKey() => _privateKey != null;

  // "profiles" field.
  List<IdentityProfileStruct>? _profiles;
  List<IdentityProfileStruct> get profiles => _profiles ?? const [];
  set profiles(List<IdentityProfileStruct>? val) => _profiles = val;
  void updateProfiles(Function(List<IdentityProfileStruct>) updateFn) =>
      updateFn(_profiles ??= []);
  bool hasProfiles() => _profiles != null;

  static PrivateIdentityEntityStruct fromMap(Map<String, dynamic> data) =>
      PrivateIdentityEntityStruct(
        did: data['did'] as String?,
        publicKey: getDataList(data['publicKey']),
        privateKey: data['privateKey'] as String?,
        profiles: getStructList(
          data['profiles'],
          IdentityProfileStruct.fromMap,
        ),
      );

  static PrivateIdentityEntityStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? PrivateIdentityEntityStruct.fromMap(data)
          : null;

  Map<String, dynamic> toMap() => {
        'did': _did,
        'publicKey': _publicKey,
        'privateKey': _privateKey,
        'profiles': _profiles?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'did': serializeParam(
          _did,
          ParamType.String,
        ),
        'publicKey': serializeParam(
          _publicKey,
          ParamType.String,
          true,
        ),
        'privateKey': serializeParam(
          _privateKey,
          ParamType.String,
        ),
        'profiles': serializeParam(
          _profiles,
          ParamType.DataStruct,
          true,
        ),
      }.withoutNulls;

  static PrivateIdentityEntityStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      PrivateIdentityEntityStruct(
        did: deserializeParam(
          data['did'],
          ParamType.String,
          false,
        ),
        publicKey: deserializeParam<String>(
          data['publicKey'],
          ParamType.String,
          true,
        ),
        privateKey: deserializeParam(
          data['privateKey'],
          ParamType.String,
          false,
        ),
        profiles: deserializeStructParam<IdentityProfileStruct>(
          data['profiles'],
          ParamType.DataStruct,
          true,
          structBuilder: IdentityProfileStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'PrivateIdentityEntityStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is PrivateIdentityEntityStruct &&
        did == other.did &&
        listEquality.equals(publicKey, other.publicKey) &&
        privateKey == other.privateKey &&
        listEquality.equals(profiles, other.profiles);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([did, publicKey, privateKey, profiles]);
}

PrivateIdentityEntityStruct createPrivateIdentityEntityStruct({
  String? did,
  String? privateKey,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PrivateIdentityEntityStruct(
      did: did,
      privateKey: privateKey,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PrivateIdentityEntityStruct? updatePrivateIdentityEntityStruct(
  PrivateIdentityEntityStruct? privateIdentityEntity, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    privateIdentityEntity
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPrivateIdentityEntityStructData(
  Map<String, dynamic> firestoreData,
  PrivateIdentityEntityStruct? privateIdentityEntity,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (privateIdentityEntity == null) {
    return;
  }
  if (privateIdentityEntity.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue &&
      privateIdentityEntity.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final privateIdentityEntityData = getPrivateIdentityEntityFirestoreData(
      privateIdentityEntity, forFieldValue);
  final nestedData =
      privateIdentityEntityData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      privateIdentityEntity.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPrivateIdentityEntityFirestoreData(
  PrivateIdentityEntityStruct? privateIdentityEntity, [
  bool forFieldValue = false,
]) {
  if (privateIdentityEntity == null) {
    return {};
  }
  final firestoreData = mapToFirestore(privateIdentityEntity.toMap());

  // Add any Firestore field values
  privateIdentityEntity.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPrivateIdentityEntityListFirestoreData(
  List<PrivateIdentityEntityStruct>? privateIdentityEntitys,
) =>
    privateIdentityEntitys
        ?.map((e) => getPrivateIdentityEntityFirestoreData(e, true))
        .toList() ??
    [];
