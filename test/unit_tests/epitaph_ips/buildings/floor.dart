import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/floor.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/landmark.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';

class FloorTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Landmark testmark = Landmark(
        key: 'TestLandmark',
        area: PolygonalArea(
            points: [Point(1, 1), Point(2, 1), Point(3, 3), Point(4, 3)]));

    Room testRoom = Room(
        key: 'TestRoom',
        area: PolygonalArea(
            points: [Point(7, 7), Point(7, 6), Point(10, 10), Point(10, 9)]));

    Floor testFloor = Floor(
        area: PolygonalArea(
            points: [Point(0, 0), Point(15, 0), Point(20, 20), Point(0, 20)]),
        floorNumber: 0,
        rooms: [
          testRoom
        ],
        landmarks: [
          testmark
        ],
        beacons: [
          MockBeacon('00:00:00:01', 'test1', Point(5, 5)),
          MockBeacon('00:00:00:02', 'test2', Point(10, 10)),
          MockBeacon('00:00:00:03', 'test3', Point(15, 15))
        ]);
    group("*Floor Constructor Unit Tests*", () {
      test("Floor constructor", () {
        //Arrange
        PolygonalArea expectedArea =
            PolygonalArea(points: [Point(0, 0), Point(30, 0), Point(15, 30)]);

        Floor retrieved = Floor(
            area: PolygonalArea(
                points: [Point(0, 0), Point(30, 0), Point(15, 30)]),
            floorNumber: 0,
            beacons: [],
            rooms: []);

        expect(retrieved.floorNumber, 0);
        expect(retrieved.rooms, []);
        expect(retrieved.beacons, []);
        expect(retrieved.landmarks, null);
        expect(retrieved.area.toString(), expectedArea.toString());
      });
      test("Floor assertion error beacons", () {
        expect(
            () => Floor(
                    area: PolygonalArea(
                        points: [Point(0, 0), Point(30, 0), Point(15, 30)]),
                    floorNumber: 0,
                    beacons: [],
                    rooms: [
                      Room(
                          key: 'TestRoom',
                          area: PolygonalArea(points: [
                            Point(7, 7),
                            Point(7, 6),
                            Point(100, 100),
                            Point(10, 9)
                          ]))
                    ]),
            throwsAssertionError);
      });
      test("Floor assertion error rooms", () {
        expect(
            () => Floor(
                    area: PolygonalArea(
                        points: [Point(0, 0), Point(30, 0), Point(15, 30)]),
                    floorNumber: 0,
                    beacons: [
                      MockBeacon('00:00:00:01', 'test1', Point(100, 100)),
                    ],
                    rooms: []),
            throwsAssertionError);
      });
      test("Floor assertion error landmarks", () {
        expect(
            () => Floor(
                    area: PolygonalArea(
                        points: [Point(0, 0), Point(30, 0), Point(15, 30)]),
                    floorNumber: 0,
                    beacons: [],
                    rooms: [],
                    landmarks: [
                      Landmark(
                          key: 'TestLandmark',
                          area: PolygonalArea(points: [
                            Point(1, 1),
                            Point(2, 1),
                            Point(3, 3),
                            Point(100, 100)
                          ]))
                    ]),
            throwsAssertionError);
      });
    });
    group("*Floor Method Unit Tests*", () {
      test("copy", () {
        Floor copyFloor = testFloor.copy();

        expect(copyFloor.toString(), testFloor.toString());
      });
      test("toJson", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'area': {
            'points': [
              {'x': 0.0, 'y': 0.0, 'z': 0.0},
              {'x': 15.0, 'y': 0.0, 'z': 0.0},
              {'x': 20.0, 'y': 20.0, 'z': 0.0},
              {'x': 0.0, 'y': 20.0, 'z': 0.0}
            ]
          },
          'floorNumber': 0,
          'beacons': [
            {
              'id': '00:00:00:01',
              'name': 'test1',
              'position': {'x': 5.0, 'y': 5.0, 'z': 0.0}
            },
            {
              'id': '00:00:00:02',
              'name': 'test2',
              'position': {'x': 10.0, 'y': 10.0, 'z': 0.0}
            },
            {
              'id': '00:00:00:03',
              'name': 'test3',
              'position': {'x': 15.0, 'y': 15.0, 'z': 0.0}
            }
          ],
          'rooms': [
            {
              'key': 'TestRoom',
              'area': {
                'points': [
                  {'x': 7.0, 'y': 7.0, 'z': 0.0},
                  {'x': 7.0, 'y': 6.0, 'z': 0.0},
                  {'x': 10.0, 'y': 10.0, 'z': 0.0},
                  {'x': 10.0, 'y': 9.0, 'z': 0.0}
                ]
              }
            }
          ],
          'landmarks': [
            {
              'key': 'TestLandmark',
              'area': {
                'points': [
                  {'x': 1.0, 'y': 1.0, 'z': 0.0},
                  {'x': 2.0, 'y': 1.0, 'z': 0.0},
                  {'x': 3.0, 'y': 3.0, 'z': 0.0},
                  {'x': 4.0, 'y': 3.0, 'z': 0.0}
                ]
              }
            }
          ]
        };

        //Act
        Map<String, dynamic> retrieved = testFloor.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString", () {
        //Arrange
        String expectedValue =
            'Floor(area: PolygonalArea(points: [Point(x: 0.0, y: 0.0, z: 0.0), Point(x: 15.0, y: 0.0, z: 0.0), Point(x: 20.0, y: 20.0, z: 0.0), Point(x: 0.0, y: 20.0, z: 0.0)]), floorNumber: 0, beacons: [Beacon(id: 00:00:00:01, name: test1, position: Point(x: 5.0, y: 5.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity), Beacon(id: 00:00:00:02, name: test2, position: Point(x: 10.0, y: 10.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity), Beacon(id: 00:00:00:03, name: test3, position: Point(x: 15.0, y: 15.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity)], rooms: [Room:(key: TestRoom, area: PolygonalArea(points: [Point(x: 7.0, y: 7.0, z: 0.0), Point(x: 7.0, y: 6.0, z: 0.0), Point(x: 10.0, y: 10.0, z: 0.0), Point(x: 10.0, y: 9.0, z: 0.0)]))], landmarks: [Landmark:(key: TestLandmark, area: PolygonalArea(points: [Point(x: 1.0, y: 1.0, z: 0.0), Point(x: 2.0, y: 1.0, z: 0.0), Point(x: 3.0, y: 3.0, z: 0.0), Point(x: 4.0, y: 3.0, z: 0.0)]))])';

        String retrieved = testFloor.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
