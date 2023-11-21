// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventTypeStruct extends FFFirebaseStruct {
  EventTypeStruct({
    String? title,
    String? description,
    String? venueName,
    String? venueAddress,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? doorsOpen,
    LatLng? location,
    List<BandTypeStruct>? bands,
    String? beaconUUID,
    bool? nfcSupported,
    FoodOptions? food,
    BarOptions? drink,
    String? parking,
    VenueType? venueType,
    EventType? eventType,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _title = title,
        _description = description,
        _venueName = venueName,
        _venueAddress = venueAddress,
        _startTime = startTime,
        _endTime = endTime,
        _doorsOpen = doorsOpen,
        _location = location,
        _bands = bands,
        _beaconUUID = beaconUUID,
        _nfcSupported = nfcSupported,
        _food = food,
        _drink = drink,
        _parking = parking,
        _venueType = venueType,
        _eventType = eventType,
        super(firestoreUtilData);

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;
  bool hasDescription() => _description != null;

  // "venueName" field.
  String? _venueName;
  String get venueName => _venueName ?? '';
  set venueName(String? val) => _venueName = val;
  bool hasVenueName() => _venueName != null;

  // "venueAddress" field.
  String? _venueAddress;
  String get venueAddress => _venueAddress ?? '';
  set venueAddress(String? val) => _venueAddress = val;
  bool hasVenueAddress() => _venueAddress != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  set startTime(DateTime? val) => _startTime = val;
  bool hasStartTime() => _startTime != null;

  // "endTime" field.
  DateTime? _endTime;
  DateTime? get endTime => _endTime;
  set endTime(DateTime? val) => _endTime = val;
  bool hasEndTime() => _endTime != null;

  // "doorsOpen" field.
  DateTime? _doorsOpen;
  DateTime? get doorsOpen => _doorsOpen;
  set doorsOpen(DateTime? val) => _doorsOpen = val;
  bool hasDoorsOpen() => _doorsOpen != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  set location(LatLng? val) => _location = val;
  bool hasLocation() => _location != null;

  // "bands" field.
  List<BandTypeStruct>? _bands;
  List<BandTypeStruct> get bands => _bands ?? const [];
  set bands(List<BandTypeStruct>? val) => _bands = val;
  void updateBands(Function(List<BandTypeStruct>) updateFn) =>
      updateFn(_bands ??= []);
  bool hasBands() => _bands != null;

  // "beaconUUID" field.
  String? _beaconUUID;
  String get beaconUUID => _beaconUUID ?? '';
  set beaconUUID(String? val) => _beaconUUID = val;
  bool hasBeaconUUID() => _beaconUUID != null;

  // "nfcSupported" field.
  bool? _nfcSupported;
  bool get nfcSupported => _nfcSupported ?? false;
  set nfcSupported(bool? val) => _nfcSupported = val;
  bool hasNfcSupported() => _nfcSupported != null;

  // "food" field.
  FoodOptions? _food;
  FoodOptions? get food => _food;
  set food(FoodOptions? val) => _food = val;
  bool hasFood() => _food != null;

  // "drink" field.
  BarOptions? _drink;
  BarOptions? get drink => _drink;
  set drink(BarOptions? val) => _drink = val;
  bool hasDrink() => _drink != null;

  // "parking" field.
  String? _parking;
  String get parking => _parking ?? '';
  set parking(String? val) => _parking = val;
  bool hasParking() => _parking != null;

  // "venueType" field.
  VenueType? _venueType;
  VenueType? get venueType => _venueType;
  set venueType(VenueType? val) => _venueType = val;
  bool hasVenueType() => _venueType != null;

  // "eventType" field.
  EventType? _eventType;
  EventType? get eventType => _eventType;
  set eventType(EventType? val) => _eventType = val;
  bool hasEventType() => _eventType != null;

  static EventTypeStruct fromMap(Map<String, dynamic> data) => EventTypeStruct(
        title: data['title'] as String?,
        description: data['description'] as String?,
        venueName: data['venueName'] as String?,
        venueAddress: data['venueAddress'] as String?,
        startTime: data['startTime'] as DateTime?,
        endTime: data['endTime'] as DateTime?,
        doorsOpen: data['doorsOpen'] as DateTime?,
        location: data['location'] as LatLng?,
        bands: getStructList(
          data['bands'],
          BandTypeStruct.fromMap,
        ),
        beaconUUID: data['beaconUUID'] as String?,
        nfcSupported: data['nfcSupported'] as bool?,
        food: deserializeEnum<FoodOptions>(data['food']),
        drink: deserializeEnum<BarOptions>(data['drink']),
        parking: data['parking'] as String?,
        venueType: deserializeEnum<VenueType>(data['venueType']),
        eventType: deserializeEnum<EventType>(data['eventType']),
      );

  static EventTypeStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? EventTypeStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'description': _description,
        'venueName': _venueName,
        'venueAddress': _venueAddress,
        'startTime': _startTime,
        'endTime': _endTime,
        'doorsOpen': _doorsOpen,
        'location': _location,
        'bands': _bands?.map((e) => e.toMap()).toList(),
        'beaconUUID': _beaconUUID,
        'nfcSupported': _nfcSupported,
        'food': _food?.toString(),
        'drink': _drink?.toString(),
        'parking': _parking,
        'venueType': _venueType?.toString(),
        'eventType': _eventType?.toString(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'venueName': serializeParam(
          _venueName,
          ParamType.String,
        ),
        'venueAddress': serializeParam(
          _venueAddress,
          ParamType.String,
        ),
        'startTime': serializeParam(
          _startTime,
          ParamType.DateTime,
        ),
        'endTime': serializeParam(
          _endTime,
          ParamType.DateTime,
        ),
        'doorsOpen': serializeParam(
          _doorsOpen,
          ParamType.DateTime,
        ),
        'location': serializeParam(
          _location,
          ParamType.LatLng,
        ),
        'bands': serializeParam(
          _bands,
          ParamType.DataStruct,
          true,
        ),
        'beaconUUID': serializeParam(
          _beaconUUID,
          ParamType.String,
        ),
        'nfcSupported': serializeParam(
          _nfcSupported,
          ParamType.bool,
        ),
        'food': serializeParam(
          _food,
          ParamType.Enum,
        ),
        'drink': serializeParam(
          _drink,
          ParamType.Enum,
        ),
        'parking': serializeParam(
          _parking,
          ParamType.String,
        ),
        'venueType': serializeParam(
          _venueType,
          ParamType.Enum,
        ),
        'eventType': serializeParam(
          _eventType,
          ParamType.Enum,
        ),
      }.withoutNulls;

  static EventTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventTypeStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        venueName: deserializeParam(
          data['venueName'],
          ParamType.String,
          false,
        ),
        venueAddress: deserializeParam(
          data['venueAddress'],
          ParamType.String,
          false,
        ),
        startTime: deserializeParam(
          data['startTime'],
          ParamType.DateTime,
          false,
        ),
        endTime: deserializeParam(
          data['endTime'],
          ParamType.DateTime,
          false,
        ),
        doorsOpen: deserializeParam(
          data['doorsOpen'],
          ParamType.DateTime,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.LatLng,
          false,
        ),
        bands: deserializeStructParam<BandTypeStruct>(
          data['bands'],
          ParamType.DataStruct,
          true,
          structBuilder: BandTypeStruct.fromSerializableMap,
        ),
        beaconUUID: deserializeParam(
          data['beaconUUID'],
          ParamType.String,
          false,
        ),
        nfcSupported: deserializeParam(
          data['nfcSupported'],
          ParamType.bool,
          false,
        ),
        food: deserializeParam<FoodOptions>(
          data['food'],
          ParamType.Enum,
          false,
        ),
        drink: deserializeParam<BarOptions>(
          data['drink'],
          ParamType.Enum,
          false,
        ),
        parking: deserializeParam(
          data['parking'],
          ParamType.String,
          false,
        ),
        venueType: deserializeParam<VenueType>(
          data['venueType'],
          ParamType.Enum,
          false,
        ),
        eventType: deserializeParam<EventType>(
          data['eventType'],
          ParamType.Enum,
          false,
        ),
      );

  @override
  String toString() => 'EventTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EventTypeStruct &&
        title == other.title &&
        description == other.description &&
        venueName == other.venueName &&
        venueAddress == other.venueAddress &&
        startTime == other.startTime &&
        endTime == other.endTime &&
        doorsOpen == other.doorsOpen &&
        location == other.location &&
        listEquality.equals(bands, other.bands) &&
        beaconUUID == other.beaconUUID &&
        nfcSupported == other.nfcSupported &&
        food == other.food &&
        drink == other.drink &&
        parking == other.parking &&
        venueType == other.venueType &&
        eventType == other.eventType;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        description,
        venueName,
        venueAddress,
        startTime,
        endTime,
        doorsOpen,
        location,
        bands,
        beaconUUID,
        nfcSupported,
        food,
        drink,
        parking,
        venueType,
        eventType
      ]);
}

EventTypeStruct createEventTypeStruct({
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
  BarOptions? drink,
  String? parking,
  VenueType? venueType,
  EventType? eventType,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventTypeStruct(
      title: title,
      description: description,
      venueName: venueName,
      venueAddress: venueAddress,
      startTime: startTime,
      endTime: endTime,
      doorsOpen: doorsOpen,
      location: location,
      beaconUUID: beaconUUID,
      nfcSupported: nfcSupported,
      food: food,
      drink: drink,
      parking: parking,
      venueType: venueType,
      eventType: eventType,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventTypeStruct? updateEventTypeStruct(
  EventTypeStruct? eventTypeStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventTypeStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventTypeStructData(
  Map<String, dynamic> firestoreData,
  EventTypeStruct? eventTypeStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventTypeStruct == null) {
    return;
  }
  if (eventTypeStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventTypeStruct.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventTypeStructData =
      getEventTypeFirestoreData(eventTypeStruct, forFieldValue);
  final nestedData =
      eventTypeStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventTypeStruct.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventTypeFirestoreData(
  EventTypeStruct? eventTypeStruct, [
  bool forFieldValue = false,
]) {
  if (eventTypeStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventTypeStruct.toMap());

  // Add any Firestore field values
  eventTypeStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventTypeListFirestoreData(
  List<EventTypeStruct>? eventTypeStructs,
) =>
    eventTypeStructs?.map((e) => getEventTypeFirestoreData(e, true)).toList() ??
    [];
