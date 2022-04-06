import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';

/// A class representing BLE beacons in the real world.
class RealBeacon extends Beacon {
  RealBeacon(String id, String name, Point position,
      {BeaconsConfiguration configuration = const BeaconsConfiguration()})
      : super(
            id: id,
            name: name,
            position: position,
            configuration: configuration);

  RealBeacon.fromJson(Map<String, dynamic> json)
      : super(
            id: json['id'],
            name: json['name'],
            position: Point.fromJson(json['position']));

  @override
  Beacon copy() => this;

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'position': position.toJson()};
}
