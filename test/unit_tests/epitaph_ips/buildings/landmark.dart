import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/landmark.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';

class LandmarkTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Landmark testmark = Landmark(
        key: 'TestLandmark',
        area: PolygonalArea(
            points: [Point(1, 1), Point(2, 1), Point(3, 3), Point(4, 3)]));

    group("*Landmark Constructor Unit Tests*", () {
      test("Landmark constructor", () {
        //Arrange
        String expectedKey = 'TestLandmark';
        PolygonalArea expectedArea = PolygonalArea(
            points: [Point(1, 1), Point(2, 1), Point(3, 3), Point(4, 3)]);

        Landmark testmark = Landmark(
            key: 'TestLandmark',
            area: PolygonalArea(
                points: [Point(1, 1), Point(2, 1), Point(3, 3), Point(4, 3)]));

        expect(testmark.key, expectedKey);
        expect(testmark.area.toString(), expectedArea.toString());
      });
      group("*Landmark Method Unit Tests*", () {
        test("copy", () {
          Landmark copymark = testmark.copy();

          //expected
          expect(copymark.key, testmark.key);
          expect(copymark.area.toString(), testmark.area.toString());
        });
        test("toJson", () {
          //Arrange
          Map<String, dynamic> expectedValue = {
            'key': 'TestLandmark',
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
          Map<String, dynamic> retrieved = testmark.toJson();

          //expected
          expect(retrieved, expectedValue);
        });
        test("toString", () {
          //Arrange
          String expectedValue =
              'Landmark:(key: TestLandmark, area: PolygonalArea(points: [Point(x: 1.0, y: 1.0, z: 0.0), Point(x: 2.0, y: 1.0, z: 0.0), Point(x: 3.0, y: 3.0, z: 0.0), Point(x: 4.0, y: 3.0, z: 0.0)]))';

          String retrieved = testmark.toString();

          //expected
          expect(retrieved, expectedValue);
        });
      });
    });
  }
}
