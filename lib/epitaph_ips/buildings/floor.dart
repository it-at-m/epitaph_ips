import 'package:flutter/foundation.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/landmark.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';

/// Representation of a floor in a building. ALl members with an [Area] need to be contained in the floor itself.
/// When a point of an [Area] is not in the Floors area an exception is thrown.
class Floor {
  Floor(
      {required this.area,
      required this.floorNumber,
      required this.beacons,
      required this.rooms,
      this.landmarks}) {
    //list of room keys
    List<String> keys = [];
    for (var room in rooms) {
      keys.add(room.key);
    }

    //check for duplicate room keys
    final duplicateKeys = keys.toSet().toList();
    assert(listEquals(duplicateKeys, keys),
        'Identical Room keys or on the same floor cannot exist!');

    //list of beacon ids
    List<String> ids = [];
    for (var beacon in beacons) {
      ids.add(beacon.id);
    }

    //check for duplicate beacon ids
    final duplicateIds = ids.toSet().toList();
    assert(listEquals(duplicateIds, ids),
        'Identical Beacon ids or mac adresses on the same floor cannot exist!');

    for (var beacon in beacons) {
      assert(area.pointInArea(beacon.position),
          'All beacons need to be in the Area of the floor');
    }
    for (var room in rooms) {
      for (var roomPoint in room.area.points) {
        assert(area.pointInArea(roomPoint),
            'All rooms need to be in the Area of the floor');
      }
    }
    if (landmarks != null) {
      for (var landmark in landmarks!) {
        for (var landmarkPoint in landmark.area.points) {
          assert(area.pointInArea(landmarkPoint),
              'All landmarks need to be in the Area of the floor');
        }
      }
    }
  }

  final PolygonalArea area;
  final int floorNumber;
  final List<Beacon> beacons;
  final List<Room> rooms;
  final List<Landmark>? landmarks;

  Map<String, dynamic> toJson() {
    // Lists cannot be automatically be generated, this is why this method is convoluted
    List<dynamic> beaconsList = [];
    for (var element in beacons) {
      beaconsList.add(element.toJson());
    }

    List<dynamic> roomsList = [];
    for (var element in rooms) {
      roomsList.add(element.toJson());
    }

    List<dynamic> landmarksList = [];
    if (landmarks != null) {
      for (var element in landmarks!) {
        landmarksList.add(element.toJson());
      }
    }

    return {
      'area': area.toJson(),
      'floorNumber': floorNumber,
      'beacons': beaconsList,
      'rooms': roomsList,
      'landmarks': landmarksList
    };
  }

  Floor copy() => this;

  @override
  String toString() =>
      'Floor(area: $area, floorNumber: $floorNumber, beacons: $beacons, rooms: $rooms, landmarks: $landmarks)';
}
