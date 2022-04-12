import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/floor.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';


class MockBuilding  extends Building {
  MockBuilding()
      : super(key: name, location: address, floors: stages, area: buildingArea);

  static String name = "MyBuilding";
  static WorldLocation address = WorldLocation(
      streetName: "Marienplatz", streetNumber: 8, extra: "München");
  static MockBeacon bc1 = MockBeacon("001", "bc1", Point(1, 1));
  static MockBeacon bc2 = MockBeacon("002", "bc2", Point(10, 1));
  static List<MockBeacon> beacons = [bc1, bc2];
  static List<Point> roomPoints1 = [
    Point(1, 1),
    Point(1, 10),
    Point(10, 10),
    Point(10, 1)
  ];
  static List<Point> roomPoints2 = [
    Point(11, 1),
    Point(11, 10),
    Point(20, 20),
    Point(20, 1)
  ];
  static List<Point> floorPoints = [
    Point(0, 0),
    Point(0, 21),
    Point(21, 21),
    Point(21, 0)
  ];
  static List<Point> buildingPoints = [
    Point(-1, -1),
    Point(-1, 22),
    Point(22, 22),
    Point(22, -1)
  ];

  static PolygonalArea roomArea1 = PolygonalArea(points: roomPoints1);
  static PolygonalArea roomArea2 = PolygonalArea(points: roomPoints2);
  static PolygonalArea floorArea = PolygonalArea(points: floorPoints);
  static PolygonalArea buildingArea = PolygonalArea(points: buildingPoints);

  static Room room1 = Room(key: "01", area: roomArea1);
  static Room room2 = Room(key: "02", area: roomArea2);
  static List<Room> rooms = [room1, room2];
  static List<Floor> stages = [
    Floor(area: floorArea, floorNumber: 0, beacons: beacons, rooms: rooms)
  ];
}
