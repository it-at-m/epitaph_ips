import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';

class RoomTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Room testRoom = Room(
        key: 'TestRoom',
        area: PolygonalArea(points: [
          Coordinate(1, 1),
          Coordinate(2, 1),
          Coordinate(3, 3),
          Coordinate(4, 3)
        ]));

    group("*Room Constructor Unit Tests*", () {
      test("Room constructor", () {
        //Arrange
        String expectedKey = 'TestRoom';
        PolygonalArea expectedArea = PolygonalArea(points: [
          Coordinate(1, 1),
          Coordinate(2, 1),
          Coordinate(3, 3),
          Coordinate(4, 3)
        ]);

        Room testRoom = Room(
            key: 'TestRoom',
            area: PolygonalArea(points: [
              Coordinate(1, 1),
              Coordinate(2, 1),
              Coordinate(3, 3),
              Coordinate(4, 3)
            ]));

        expect(testRoom.key, expectedKey);
        expect(testRoom.area.toString(), expectedArea.toString());
      });
      group("*Room Method Unit Tests*", () {
        test("copy", () {
          Room copyRoom = testRoom.copy();

          //expected
          expect(copyRoom.key, testRoom.key);
          expect(copyRoom.area.toString(), testRoom.area.toString());
        });
        test("toJson", () {
          //Arrange
          Map<String, dynamic> expectedValue = {
            'key': 'TestRoom',
            'area': {
              'points': [
                {'x': 1.0, 'y': 1.0, 'z': 0.0},
                {'x': 2.0, 'y': 1.0, 'z': 0.0},
                {'x': 3.0, 'y': 3.0, 'z': 0.0},
                {'x': 4.0, 'y': 3.0, 'z': 0.0}
              ]
            }
          };

          //Act
          Map<String, dynamic> retrieved = testRoom.toJson();

          //expected
          expect(retrieved, expectedValue);
        });
        test("toString", () {
          //Arrange
          String expectedValue =
              'Room:(key: TestRoom, area: PolygonalArea(points: [Coordinate(x: 1.0, y: 1.0, z: 0.0), Coordinate(x: 2.0, y: 1.0, z: 0.0), Coordinate(x: 3.0, y: 3.0, z: 0.0), Coordinate(x: 4.0, y: 3.0, z: 0.0)]))';

          String retrieved = testRoom.toString();

          //expected
          expect(retrieved, expectedValue);
        });
      });
    });
  }
}
