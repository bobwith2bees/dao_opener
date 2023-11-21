import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "venueName" field.
  String? _venueName;
  String get venueName => _venueName ?? '';
  bool hasVenueName() => _venueName != null;

  // "venueAddress" field.
  String? _venueAddress;
  String get venueAddress => _venueAddress ?? '';
  bool hasVenueAddress() => _venueAddress != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  bool hasEndTime() => _endTime != null;

  // "doorsOpen" field.
  DateTime? _doorsOpen;
  DateTime? get doorsOpen => _doorsOpen;
  bool hasDoorsOpen() => _doorsOpen != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "bands" field.
  List<BandTypeStruct>? _bands;
  List<BandTypeStruct> get bands => _bands ?? const [];
  bool hasBands() => _bands != null;

  // "beaconUUID" field.
  String? _beaconUUID;
  String get beaconUUID => _beaconUUID ?? '';
  bool hasBeaconUUID() => _beaconUUID != null;

  // "nfcSupported" field.
  bool? _nfcSupported;
  bool get nfcSupported => _nfcSupported ?? false;
  bool hasNfcSupported() => _nfcSupported != null;

  // "food" field.
  FoodOptions? _food;
  FoodOptions? get food => _food;
  bool hasFood() => _food != null;

  // "venueType" field.
  VenueType? _venueType;
  VenueType? get venueType => _venueType;
  bool hasVenueType() => _venueType != null;

  // "eventType" field.
  EventType? _eventType;
  EventType? get eventType => _eventType;
  bool hasEventType() => _eventType != null;

  // "parking" field.
  String? _parking;
  String get parking => _parking ?? '';
  bool hasParking() => _parking != null;

  // "drink" field.
  BarOptions? _drink;
  BarOptions? get drink => _drink;
  bool hasDrink() => _drink != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _venueName = snapshotData['venueName'] as String?;
    _venueAddress = snapshotData['venueAddress'] as String?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _endTime = snapshotData['endTime'] as DateTime?;
    _doorsOpen = snapshotData['doorsOpen'] as DateTime?;
    _location = snapshotData['location'] as LatLng?;
    _bands = getStructList(
      snapshotData['bands'],
      BandTypeStruct.fromMap,
    );
    _beaconUUID = snapshotData['beaconUUID'] as String?;
    _nfcSupported = snapshotData['nfcSupported'] as bool?;
    _food = deserializeEnum<FoodOptions>(snapshotData['food']);
    _venueType = deserializeEnum<VenueType>(snapshotData['venueType']);
    _eventType = deserializeEnum<EventType>(snapshotData['eventType']);
    _parking = snapshotData['parking'] as String?;
    _drink = deserializeEnum<BarOptions>(snapshotData['drink']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  String? title,
  String? description,
  String? venueName,
  String? venueAddress,
  DateTime? startTime,
  DateTime? endTime,
  DateTime? doorsOpen,
  LatLng? location,
  String? beaconUUID,
  bool? nfcSupported,
  FoodOptions? food,
  VenueType? venueType,
  EventType? eventType,
  String? parking,
  BarOptions? drink,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'venueName': venueName,
      'venueAddress': venueAddress,
      'startTime': startTime,
      'endTime': endTime,
      'doorsOpen': doorsOpen,
      'location': location,
      'beaconUUID': beaconUUID,
      'nfcSupported': nfcSupported,
      'food': food,
      'venueType': venueType,
      'eventType': eventType,
      'parking': parking,
      'drink': drink,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.venueName == e2?.venueName &&
        e1?.venueAddress == e2?.venueAddress &&
        e1?.startTime == e2?.startTime &&
        e1?.endTime == e2?.endTime &&
        e1?.doorsOpen == e2?.doorsOpen &&
        e1?.location == e2?.location &&
        listEquality.equals(e1?.bands, e2?.bands) &&
        e1?.beaconUUID == e2?.beaconUUID &&
        e1?.nfcSupported == e2?.nfcSupported &&
        e1?.food == e2?.food &&
        e1?.venueType == e2?.venueType &&
        e1?.eventType == e2?.eventType &&
        e1?.parking == e2?.parking &&
        e1?.drink == e2?.drink;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.description,
        e?.venueName,
        e?.venueAddress,
        e?.startTime,
        e?.endTime,
        e?.doorsOpen,
        e?.location,
        e?.bands,
        e?.beaconUUID,
        e?.nfcSupported,
        e?.food,
        e?.venueType,
        e?.eventType,
        e?.parking,
        e?.drink
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
