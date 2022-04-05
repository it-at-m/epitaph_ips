import 'package:epitaph_ips/epitaph_ips/buildings/area.dart';

/// Representation of a Room in the real world. [area] defines it size.
class Room {
  Room({required this.key, required this.area});

  final String key;
  final Area area;

  Room copy() => this;

  ///Serializes the class into a json object
  Map<String, dynamic> toJson() => {'key': key, 'area': area.toJson()};

  @override
  String toString() => 'Room:(key: $key, area: $area)';
}
