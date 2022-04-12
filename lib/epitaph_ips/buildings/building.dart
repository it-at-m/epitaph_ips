import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:flutter/foundation.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/floor.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';

/// An object representing a building in the real world.
class Building {
  Building(
      {required this.key,
      required this.location,
      required this.floors,
      required this.area}) {
    //list of room keys
    List<String> keys = [];
    for (var floor in floors) {
      for (var room in floor.rooms) {
        keys.add(room.key);
      }
    }

    //check for duplicate room keys if building has rooms
    if (keys.isNotEmpty) {
      final duplicateKeys = keys.toSet().toList();
      assert(listEquals(duplicateKeys, keys),
          'Identical Room keys or on the same floor cannot exist!');
    }

    //list of beacon ids
    List<String> ids = [];
    for (var floor in floors) {
      for (var beacon in floor.beacons) {
        ids.add(beacon.id);
      }
    }

    //check for duplicate beacon ids
    final check = ids.toSet().toList();
    assert(listEquals(check, ids),
        'Identical Beacon ids or mac adresses in the same building cannot exist!');

    for (var floor in floors) {
      for (var floorPoints in floor.area.points) {
        assert(area.pointInArea(floorPoints),
            '$floorPoints:All points of floors need to be in the Area of the building');
      }
    }
  }

  final String key;
  final WorldLocation location;
  final List<Floor> floors;
  final PolygonalArea area;

  int get numberOfFloors => floors.length;

  Map<String, dynamic> toJson() {
    List<dynamic> floorList = [];
    for (var element in floors) {
      floorList.add(element.toJson());
    }

    return {
      'key': key,
      'location': location.toJson(),
      'floors': floorList,
      'area': area.toJson()
    };
  }

  Room? getCurrentRoom(Point point) {
    for (Floor floor in floors) {
      if (!floor.area.pointInArea(point)) {
        continue;
      }

      for (Room room in floor.rooms) {
        if (room.area.pointInArea(point)) {
          return room;
        }
      }
    }

    return null;
  }

  @override
  String toString() =>
      'Building(key : $key, location: $location, floors: $floors, area: $area)';
}
