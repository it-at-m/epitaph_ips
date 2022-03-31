import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/floor.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/landmark.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';

class BuildingTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Landmark testmark = Landmark(
        key: 'TestLandmark',
        area: PolygonalArea(points: [
          Coordinate(1, 1),
          Coordinate(2, 1),
          Coordinate(3, 3),
          Coordinate(4, 3)
        ]));

    Room testRoom = Room(
        key: 'TestRoom',
        area: PolygonalArea(points: [
          Coordinate(7, 7),
          Coordinate(7, 6),
          Coordinate(10, 10),
          Coordinate(10, 9)
        ]));

    Room testRoom2 = Room(
        key: 'TestRoom2',
        area: PolygonalArea(points: [
          Coordinate(7, 7),
          Coordinate(7, 6),
          Coordinate(10, 10),
          Coordinate(10, 9)
        ]));

    Floor testFloor = Floor(
        area: PolygonalArea(points: [
          Coordinate(0, 0),
          Coordinate(15, 0),
          Coordinate(20, 20),
          Coordinate(0, 20)
        ]),
        floorNumber: 0,
        rooms: [
          testRoom
        ],
        landmarks: [
          testmark
        ],
        beacons: [
          MockBeacon('00:00:00:01', 'test1', Coordinate(5, 5)),
          MockBeacon('00:00:00:02', 'test2', Coordinate(10, 10)),
          MockBeacon('00:00:00:03', 'test3', Coordinate(15, 15))
        ]);

    Floor floorSix = Floor(
        area: PolygonalArea(points: [
          Coordinate(0, 0),
          Coordinate(15, 0),
          Coordinate(20, 20),
          Coordinate(0, 20)
        ]),
        floorNumber: 6,
        rooms: [
          testRoom2
        ],
        beacons: [
          MockBeacon('00:00:00:04', 'test4', Coordinate(5, 5)),
          MockBeacon('00:00:00:05', 'test5', Coordinate(10, 10)),
          MockBeacon('00:00:00:06', 'test6', Coordinate(15, 15))
        ]);

    Building innovationLab = Building(
        key: 'InnoLab',
        location: WorldLocation(streetName: 'APB', streetNumber: 66),
        floors: [testFloor, floorSix],
        area: PolygonalArea(points: [
          Coordinate(0, 0),
          Coordinate(60, 0),
          Coordinate(60, 60),
          Coordinate(0, 60)
        ]));

    group("*Building Constructor Unit Tests*", () {
      test("Building constructor", () {
        //Arrange
        PolygonalArea expectedArea = PolygonalArea(points: [
          Coordinate(0, 0),
          Coordinate(60, 0),
          Coordinate(60, 60),
          Coordinate(0, 60)
        ]);

        Building innovationLab = Building(
            key: 'InnoLab',
            location: WorldLocation(streetName: 'APB', streetNumber: 66),
            floors: [],
            area: PolygonalArea(points: [
              Coordinate(0, 0),
              Coordinate(60, 0),
              Coordinate(60, 60),
              Coordinate(0, 60)
            ]));

        expect(innovationLab.numberOfFloors, 0);
        expect(innovationLab.floors, []);
        expect(innovationLab.key, 'InnoLab');
        expect(innovationLab.location.toFullName(), 'APB 66');
        expect(innovationLab.area.toString(), expectedArea.toString());
      });
      test("Building assertion error", () {
        expect(
            () => Building(
                key: 'InnoLab',
                location: WorldLocation(streetName: 'APB', streetNumber: 66),
                floors: [
                  Floor(
                      area: PolygonalArea(points: [
                        Coordinate(0, 0),
                        Coordinate(600, 0),
                        Coordinate(15, 30)
                      ]),
                      floorNumber: 0,
                      beacons: [],
                      rooms: [
                        Room(
                            key: 'TestRoom',
                            area: PolygonalArea(points: [
                              Coordinate(7, 7),
                              Coordinate(7, 6),
                              Coordinate(100, 100),
                              Coordinate(10, 9)
                            ]))
                      ]),
                ],
                area: PolygonalArea(points: [
                  Coordinate(0, 0),
                  Coordinate(60, 0),
                  Coordinate(60, 60),
                  Coordinate(0, 60)
                ])),
            throwsAssertionError);
      });
    });
    group("*Building Method Unit Tests*", () {
      test("toJson", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'key': 'InnoLab',
          'location': {'streetName': 'APB', 'streetNumber': 66, 'extra': null},
          'floors': [
            {
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
            },
            {
              'area': {
                'points': [
                  {'x': 0.0, 'y': 0.0, 'z': 0.0},
                  {'x': 15.0, 'y': 0.0, 'z': 0.0},
                  {'x': 20.0, 'y': 20.0, 'z': 0.0},
                  {'x': 0.0, 'y': 20.0, 'z': 0.0}
                ]
              },
              'floorNumber': 6,
              'beacons': [
                {
                  'id': '00:00:00:04',
                  'name': 'test4',
                  'position': {'x': 5.0, 'y': 5.0, 'z': 0.0}
                },
                {
                  'id': '00:00:00:05',
                  'name': 'test5',
                  'position': {'x': 10.0, 'y': 10.0, 'z': 0.0}
                },
                {
                  'id': '00:00:00:06',
                  'name': 'test6',
                  'position': {'x': 15.0, 'y': 15.0, 'z': 0.0}
                }
              ],
              'rooms': [
                {
                  'key': 'TestRoom2',
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
              'landmarks': []
            }
          ],
          'area': {
            'points': [
              {'x': 0.0, 'y': 0.0, 'z': 0.0},
              {'x': 60.0, 'y': 0.0, 'z': 0.0},
              {'x': 60.0, 'y': 60.0, 'z': 0.0},
              {'x': 0.0, 'y': 60.0, 'z': 0.0}
            ]
          }
        };

        //Act
        Map<String, dynamic> retrieved = innovationLab.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString", () {
        //Arrange
        String expectedValue =
            'Building(key : InnoLab, location: WorldLocation(streetName: APB, streetNumber: 66, extra: null), floors: [Floor(area: PolygonalArea(points: [Coordinate(x: 0.0, y: 0.0, z: 0.0), Coordinate(x: 15.0, y: 0.0, z: 0.0), Coordinate(x: 20.0, y: 20.0, z: 0.0), Coordinate(x: 0.0, y: 20.0, z: 0.0)]), floorNumber: 0, beacons: [Beacon(id: 00:00:00:01, name: test1, position: Coordinate(x: 5.0, y: 5.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity), Beacon(id: 00:00:00:02, name: test2, position: Coordinate(x: 10.0, y: 10.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity), Beacon(id: 00:00:00:03, name: test3, position: Coordinate(x: 15.0, y: 15.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity)], rooms: [Room:(key: TestRoom, area: PolygonalArea(points: [Coordinate(x: 7.0, y: 7.0, z: 0.0), Coordinate(x: 7.0, y: 6.0, z: 0.0), Coordinate(x: 10.0, y: 10.0, z: 0.0), Coordinate(x: 10.0, y: 9.0, z: 0.0)]))], landmarks: [Landmark:(key: TestLandmark, area: PolygonalArea(points: [Coordinate(x: 1.0, y: 1.0, z: 0.0), Coordinate(x: 2.0, y: 1.0, z: 0.0), Coordinate(x: 3.0, y: 3.0, z: 0.0), Coordinate(x: 4.0, y: 3.0, z: 0.0)]))]), Floor(area: PolygonalArea(points: [Coordinate(x: 0.0, y: 0.0, z: 0.0), Coordinate(x: 15.0, y: 0.0, z: 0.0), Coordinate(x: 20.0, y: 20.0, z: 0.0), Coordinate(x: 0.0, y: 20.0, z: 0.0)]), floorNumber: 6, beacons: [Beacon(id: 00:00:00:04, name: test4, position: Coordinate(x: 5.0, y: 5.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity), Beacon(id: 00:00:00:05, name: test5, position: Coordinate(x: 10.0, y: 10.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity), Beacon(id: 00:00:00:06, name: test6, position: Coordinate(x: 15.0, y: 15.0, z: 0.0), rssi: -Infinity, distanceToUser: Infinity)], rooms: [Room:(key: TestRoom2, area: PolygonalArea(points: [Coordinate(x: 7.0, y: 7.0, z: 0.0), Coordinate(x: 7.0, y: 6.0, z: 0.0), Coordinate(x: 10.0, y: 10.0, z: 0.0), Coordinate(x: 10.0, y: 9.0, z: 0.0)]))], landmarks: null)], area: PolygonalArea(points: [Coordinate(x: 0.0, y: 0.0, z: 0.0), Coordinate(x: 60.0, y: 0.0, z: 0.0), Coordinate(x: 60.0, y: 60.0, z: 0.0), Coordinate(x: 0.0, y: 60.0, z: 0.0)]))';

        String retrieved = innovationLab.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
