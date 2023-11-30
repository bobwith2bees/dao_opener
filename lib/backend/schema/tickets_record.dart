import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TicketsRecord extends FirestoreRecord {
  TicketsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "did" field.
  String? _did;
  String get did => _did ?? '';
  bool hasDid() => _did != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "issued" field.
  DateTime? _issued;
  DateTime? get issued => _issued;
  bool hasIssued() => _issued != null;

  // "used" field.
  DateTime? _used;
  DateTime? get used => _used;
  bool hasUsed() => _used != null;

  // "lastStatus" field.
  String? _lastStatus;
  String get lastStatus => _lastStatus ?? '';
  bool hasLastStatus() => _lastStatus != null;

  // "type" field.
  TicketType? _type;
  TicketType? get type => _type;
  bool hasType() => _type != null;

  // "ticketNumber" field.
  String? _ticketNumber;
  String get ticketNumber => _ticketNumber ?? '';
  bool hasTicketNumber() => _ticketNumber != null;

  // "event" field.
  DocumentReference? _event;
  DocumentReference? get event => _event;
  bool hasEvent() => _event != null;

  void _initializeFields() {
    _did = snapshotData['did'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _issued = snapshotData['issued'] as DateTime?;
    _used = snapshotData['used'] as DateTime?;
    _lastStatus = snapshotData['lastStatus'] as String?;
    _type = deserializeEnum<TicketType>(snapshotData['type']);
    _ticketNumber = snapshotData['ticketNumber'] as String?;
    _event = snapshotData['event'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tickets');

  static Stream<TicketsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TicketsRecord.fromSnapshot(s));

  static Future<TicketsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TicketsRecord.fromSnapshot(s));

  static TicketsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TicketsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TicketsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TicketsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TicketsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TicketsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTicketsRecordData({
  String? did,
  double? price,
  DateTime? issued,
  DateTime? used,
  String? lastStatus,
  TicketType? type,
  String? ticketNumber,
  DocumentReference? event,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'did': did,
      'price': price,
      'issued': issued,
      'used': used,
      'lastStatus': lastStatus,
      'type': type,
      'ticketNumber': ticketNumber,
      'event': event,
    }.withoutNulls,
  );

  return firestoreData;
}

class TicketsRecordDocumentEquality implements Equality<TicketsRecord> {
  const TicketsRecordDocumentEquality();

  @override
  bool equals(TicketsRecord? e1, TicketsRecord? e2) {
    return e1?.did == e2?.did &&
        e1?.price == e2?.price &&
        e1?.issued == e2?.issued &&
        e1?.used == e2?.used &&
        e1?.lastStatus == e2?.lastStatus &&
        e1?.type == e2?.type &&
        e1?.ticketNumber == e2?.ticketNumber &&
        e1?.event == e2?.event;
  }

  @override
  int hash(TicketsRecord? e) => const ListEquality().hash([
        e?.did,
        e?.price,
        e?.issued,
        e?.used,
        e?.lastStatus,
        e?.type,
        e?.ticketNumber,
        e?.event
      ]);

  @override
  bool isValidKey(Object? o) => o is TicketsRecord;
}
