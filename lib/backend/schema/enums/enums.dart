import 'package:collection/collection.dart';

enum BarOptions {
  openBar,
  forPurchase,
  none,
}

enum FoodOptions {
  none,
  forPurchase,
  snacksProvided,
  mealsProvided,
}

enum VenueType {
  indoor,
  outdoor,
  indoorOutdoor,
}

enum EventType {
  public,
  private,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (BarOptions):
      return BarOptions.values.deserialize(value) as T?;
    case (FoodOptions):
      return FoodOptions.values.deserialize(value) as T?;
    case (VenueType):
      return VenueType.values.deserialize(value) as T?;
    case (EventType):
      return EventType.values.deserialize(value) as T?;
    default:
      return null;
  }
}
