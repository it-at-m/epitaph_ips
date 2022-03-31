import 'package:epitaph_ips/epitaph_ips/buildings/area.dart';

/// Representation of a Landmark in the real world. [area] defines it size.
class Landmark {
  Landmark({required this.key, required this.area});

  final String key;
  final Area area;

  Landmark copy() => this;

  ///Serializes the class into a json object
  Map<String, dynamic> toJson() => {'key': key, 'area': area.toJson()};

  @override
  String toString() => 'Landmark:(key: $key, area: $area)';
}
