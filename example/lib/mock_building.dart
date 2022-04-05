import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/floor.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';

MockBeacon bc1 = MockBeacon("001", "bc1", Coordinate(1, 1));
MockBeacon bc2 = MockBeacon("002", "bc2", Coordinate(10, 1));
List<MockBeacon> beacons = [bc1, bc2];
List<Coordinate> roomPoints1 = [
  Coordinate(1, 1),
  Coordinate(1, 10),
  Coordinate(10, 10),
  Coordinate(10, 1)
];
List<Coordinate> roomPoints2 = [
  Coordinate(11, 1),
  Coordinate(11, 10),
  Coordinate(20, 20),
  Coordinate(20, 1)
];
List<Coordinate> floorPoints = [
  Coordinate(0, 0),
  Coordinate(0, 21),
  Coordinate(21, 21),
  Coordinate(21, 0)
];
List<Coordinate> buildingPoints = [
  Coordinate(-1, -1),
  Coordinate(-1, 22),
  Coordinate(22, 22),
  Coordinate(22, -1)
];

PolygonalArea roomArea1 = PolygonalArea(points: roomPoints1);
PolygonalArea roomArea2 = PolygonalArea(points: roomPoints2);
PolygonalArea floorArea = PolygonalArea(points: floorPoints);
PolygonalArea buildingArea = PolygonalArea(points: buildingPoints);

Room room1 = Room(key: "01", area: roomArea1);
Room room2 = Room(key: "02", area: roomArea2);
List<Room> rooms = [room1, room2];
List<Floor> floors = [
  Floor(area: floorArea, floorNumber: 0, beacons: beacons, rooms: rooms)
];

WorldLocation location =
    WorldLocation(streetName: "Marienplatz", streetNumber: 8, extra: "München");

Building createBuilding() {
  return Building(
      key: "MyBuilding",
      location: location,
      floors: floors,
      area: buildingArea);
}
