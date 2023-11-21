// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BandTypeStruct extends FFFirebaseStruct {
  BandTypeStruct({
    String? name,
    String? primaryUrl,
    List<String>? mediaUrls,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _primaryUrl = primaryUrl,
        _mediaUrls = mediaUrls,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "primaryUrl" field.
  String? _primaryUrl;
  String get primaryUrl => _primaryUrl ?? '';
  set primaryUrl(String? val) => _primaryUrl = val;
  bool hasPrimaryUrl() => _primaryUrl != null;

  // "mediaUrls" field.
  List<String>? _mediaUrls;
  List<String> get mediaUrls => _mediaUrls ?? const [];
  set mediaUrls(List<String>? val) => _mediaUrls = val;
  void updateMediaUrls(Function(List<String>) updateFn) =>
      updateFn(_mediaUrls ??= []);
  bool hasMediaUrls() => _mediaUrls != null;

  static BandTypeStruct fromMap(Map<String, dynamic> data) => BandTypeStruct(
        name: data['name'] as String?,
        primaryUrl: data['primaryUrl'] as String?,
        mediaUrls: getDataList(data['mediaUrls']),
      );

  static BandTypeStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? BandTypeStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'primaryUrl': _primaryUrl,
        'mediaUrls': _mediaUrls,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'primaryUrl': serializeParam(
          _primaryUrl,
          ParamType.String,
        ),
        'mediaUrls': serializeParam(
          _mediaUrls,
          ParamType.String,
          true,
        ),
      }.withoutNulls;

  static BandTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      BandTypeStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        primaryUrl: deserializeParam(
          data['primaryUrl'],
          ParamType.String,
          false,
        ),
        mediaUrls: deserializeParam<String>(
          data['mediaUrls'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'BandTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is BandTypeStruct &&
        name == other.name &&
        primaryUrl == other.primaryUrl &&
        listEquality.equals(mediaUrls, other.mediaUrls);
  }

  @override
  int get hashCode => const ListEquality().hash([name, primaryUrl, mediaUrls]);
}

BandTypeStruct createBandTypeStruct({
  String? name,
  String? primaryUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BandTypeStruct(
      name: name,
      primaryUrl: primaryUrl,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BandTypeStruct? updateBandTypeStruct(
  BandTypeStruct? bandType, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    bandType
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBandTypeStructData(
  Map<String, dynamic> firestoreData,
  BandTypeStruct? bandType,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (bandType == null) {
    return;
  }
  if (bandType.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && bandType.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final bandTypeData = getBandTypeFirestoreData(bandType, forFieldValue);
  final nestedData = bandTypeData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = bandType.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBandTypeFirestoreData(
  BandTypeStruct? bandType, [
  bool forFieldValue = false,
]) {
  if (bandType == null) {
    return {};
  }
  final firestoreData = mapToFirestore(bandType.toMap());

  // Add any Firestore field values
  bandType.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBandTypeListFirestoreData(
  List<BandTypeStruct>? bandTypes,
) =>
    bandTypes?.map((e) => getBandTypeFirestoreData(e, true)).toList() ?? [];
