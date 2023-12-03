// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClaimModelStruct extends FFFirebaseStruct {
  ClaimModelStruct({
    String? expiration,
    String? id,
    String? value,
    String? name,
    String? issuer,
    ClamModelState? state,
    String? type,
    List<ClaimDetailModelStruct>? details,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _expiration = expiration,
        _id = id,
        _value = value,
        _name = name,
        _issuer = issuer,
        _state = state,
        _type = type,
        _details = details,
        super(firestoreUtilData);

  // "expiration" field.
  String? _expiration;
  String get expiration => _expiration ?? '';
  set expiration(String? val) => _expiration = val;
  bool hasExpiration() => _expiration != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;
  bool hasId() => _id != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;
  bool hasValue() => _value != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "issuer" field.
  String? _issuer;
  String get issuer => _issuer ?? '';
  set issuer(String? val) => _issuer = val;
  bool hasIssuer() => _issuer != null;

  // "state" field.
  ClamModelState? _state;
  ClamModelState? get state => _state;
  set state(ClamModelState? val) => _state = val;
  bool hasState() => _state != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;
  bool hasType() => _type != null;

  // "details" field.
  List<ClaimDetailModelStruct>? _details;
  List<ClaimDetailModelStruct> get details => _details ?? const [];
  set details(List<ClaimDetailModelStruct>? val) => _details = val;
  void updateDetails(Function(List<ClaimDetailModelStruct>) updateFn) =>
      updateFn(_details ??= []);
  bool hasDetails() => _details != null;

  static ClaimModelStruct fromMap(Map<String, dynamic> data) =>
      ClaimModelStruct(
        expiration: data['expiration'] as String?,
        id: data['id'] as String?,
        value: data['value'] as String?,
        name: data['name'] as String?,
        issuer: data['issuer'] as String?,
        state: deserializeEnum<ClamModelState>(data['state']),
        type: data['type'] as String?,
        details: getStructList(
          data['details'],
          ClaimDetailModelStruct.fromMap,
        ),
      );

  static ClaimModelStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? ClaimModelStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'expiration': _expiration,
        'id': _id,
        'value': _value,
        'name': _name,
        'issuer': _issuer,
        'state': _state?.toString(),
        'type': _type,
        'details': _details?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'expiration': serializeParam(
          _expiration,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'issuer': serializeParam(
          _issuer,
          ParamType.String,
        ),
        'state': serializeParam(
          _state,
          ParamType.Enum,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'details': serializeParam(
          _details,
          ParamType.DataStruct,
          true,
        ),
      }.withoutNulls;

  static ClaimModelStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClaimModelStruct(
        expiration: deserializeParam(
          data['expiration'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        issuer: deserializeParam(
          data['issuer'],
          ParamType.String,
          false,
        ),
        state: deserializeParam<ClamModelState>(
          data['state'],
          ParamType.Enum,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        details: deserializeStructParam<ClaimDetailModelStruct>(
          data['details'],
          ParamType.DataStruct,
          true,
          structBuilder: ClaimDetailModelStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ClaimModelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ClaimModelStruct &&
        expiration == other.expiration &&
        id == other.id &&
        value == other.value &&
        name == other.name &&
        issuer == other.issuer &&
        state == other.state &&
        type == other.type &&
        listEquality.equals(details, other.details);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([expiration, id, value, name, issuer, state, type, details]);
}

ClaimModelStruct createClaimModelStruct({
  String? expiration,
  String? id,
  String? value,
  String? name,
  String? issuer,
  ClamModelState? state,
  String? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ClaimModelStruct(
      expiration: expiration,
      id: id,
      value: value,
      name: name,
      issuer: issuer,
      state: state,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ClaimModelStruct? updateClaimModelStruct(
  ClaimModelStruct? claimModel, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    claimModel
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addClaimModelStructData(
  Map<String, dynamic> firestoreData,
  ClaimModelStruct? claimModel,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (claimModel == null) {
    return;
  }
  if (claimModel.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && claimModel.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final claimModelData = getClaimModelFirestoreData(claimModel, forFieldValue);
  final nestedData = claimModelData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = claimModel.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getClaimModelFirestoreData(
  ClaimModelStruct? claimModel, [
  bool forFieldValue = false,
]) {
  if (claimModel == null) {
    return {};
  }
  final firestoreData = mapToFirestore(claimModel.toMap());

  // Add any Firestore field values
  claimModel.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getClaimModelListFirestoreData(
  List<ClaimModelStruct>? claimModels,
) =>
    claimModels?.map((e) => getClaimModelFirestoreData(e, true)).toList() ?? [];
