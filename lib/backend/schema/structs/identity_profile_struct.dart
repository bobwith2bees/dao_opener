// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IdentityProfileStruct extends FFFirebaseStruct {
  IdentityProfileStruct({
    double? key,
    String? profile,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _key = key,
        _profile = profile,
        super(firestoreUtilData);

  // "key" field.
  double? _key;
  double get key => _key ?? 0.0;
  set key(double? val) => _key = val;
  void incrementKey(double amount) => _key = key + amount;
  bool hasKey() => _key != null;

  // "profile" field.
  String? _profile;
  String get profile => _profile ?? '';
  set profile(String? val) => _profile = val;
  bool hasProfile() => _profile != null;

  static IdentityProfileStruct fromMap(Map<String, dynamic> data) =>
      IdentityProfileStruct(
        key: castToType<double>(data['key']),
        profile: data['profile'] as String?,
      );

  static IdentityProfileStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? IdentityProfileStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'key': _key,
        'profile': _profile,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'key': serializeParam(
          _key,
          ParamType.double,
        ),
        'profile': serializeParam(
          _profile,
          ParamType.String,
        ),
      }.withoutNulls;

  static IdentityProfileStruct fromSerializableMap(Map<String, dynamic> data) =>
      IdentityProfileStruct(
        key: deserializeParam(
          data['key'],
          ParamType.double,
          false,
        ),
        profile: deserializeParam(
          data['profile'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'IdentityProfileStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is IdentityProfileStruct &&
        key == other.key &&
        profile == other.profile;
  }

  @override
  int get hashCode => const ListEquality().hash([key, profile]);
}

IdentityProfileStruct createIdentityProfileStruct({
  double? key,
  String? profile,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    IdentityProfileStruct(
      key: key,
      profile: profile,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

IdentityProfileStruct? updateIdentityProfileStruct(
  IdentityProfileStruct? identityProfile, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    identityProfile
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addIdentityProfileStructData(
  Map<String, dynamic> firestoreData,
  IdentityProfileStruct? identityProfile,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (identityProfile == null) {
    return;
  }
  if (identityProfile.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && identityProfile.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final identityProfileData =
      getIdentityProfileFirestoreData(identityProfile, forFieldValue);
  final nestedData =
      identityProfileData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = identityProfile.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getIdentityProfileFirestoreData(
  IdentityProfileStruct? identityProfile, [
  bool forFieldValue = false,
]) {
  if (identityProfile == null) {
    return {};
  }
  final firestoreData = mapToFirestore(identityProfile.toMap());

  // Add any Firestore field values
  identityProfile.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getIdentityProfileListFirestoreData(
  List<IdentityProfileStruct>? identityProfiles,
) =>
    identityProfiles
        ?.map((e) => getIdentityProfileFirestoreData(e, true))
        .toList() ??
    [];
