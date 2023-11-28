// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClaimDetailModelStruct extends FFFirebaseStruct {
  ClaimDetailModelStruct({
    String? name,
    String? value,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _value = value,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;
  bool hasValue() => _value != null;

  static ClaimDetailModelStruct fromMap(Map<String, dynamic> data) =>
      ClaimDetailModelStruct(
        name: data['name'] as String?,
        value: data['value'] as String?,
      );

  static ClaimDetailModelStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic>
          ? ClaimDetailModelStruct.fromMap(data)
          : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
      }.withoutNulls;

  static ClaimDetailModelStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClaimDetailModelStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ClaimDetailModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClaimDetailModelStruct &&
        name == other.name &&
        value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([name, value]);
}

ClaimDetailModelStruct createClaimDetailModelStruct({
  String? name,
  String? value,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClaimDetailModelStruct(
      name: name,
      value: value,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClaimDetailModelStruct? updateClaimDetailModelStruct(
  ClaimDetailModelStruct? claimDetailModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    claimDetailModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClaimDetailModelStructData(
  Map<String, dynamic> firestoreData,
  ClaimDetailModelStruct? claimDetailModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (claimDetailModel == null) {
    return;
  }
  if (claimDetailModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && claimDetailModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final claimDetailModelData =
      getClaimDetailModelFirestoreData(claimDetailModel, forFieldValue);
  final nestedData =
      claimDetailModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = claimDetailModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClaimDetailModelFirestoreData(
  ClaimDetailModelStruct? claimDetailModel, [
  bool forFieldValue = false,
]) {
  if (claimDetailModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(claimDetailModel.toMap());

  // Add any Firestore field values
  claimDetailModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClaimDetailModelListFirestoreData(
  List<ClaimDetailModelStruct>? claimDetailModels,
) =>
    claimDetailModels
        ?.map((e) => getClaimDetailModelFirestoreData(e, true))
        .toList() ??
    [];
