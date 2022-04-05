import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';

class WorldLocationTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    WorldLocation locationWithExtra =
        WorldLocation(streetName: 'Marienplatz', streetNumber: 8, extra: 'a');
    WorldLocation location =
        WorldLocation(streetName: 'Marienplatz', streetNumber: 8);

    group("*WorldLocation Constructor Unit Tests*", () {
      test("Full constructor", () {
        //Arrange
        String expectedName = 'Marienplatz';
        int expectedNumber = 8;
        String extra = 'a';

        //Act
        WorldLocation retrieved = WorldLocation(
            streetName: 'Marienplatz', streetNumber: 8, extra: 'a');

        //expect
        expect(retrieved.streetName, expectedName);
        expect(retrieved.streetNumber, expectedNumber);
        expect(retrieved.extra, extra);
      });
      test("Constructor, when extra is null", () {
        //Arrange
        String expectedName = 'Marienplatz';
        int expectedNumber = 8;

        //Act
        WorldLocation retrieved =
            WorldLocation(streetName: 'Marienplatz', streetNumber: 8);

        //expect
        expect(retrieved.streetName, expectedName);
        expect(retrieved.streetNumber, expectedNumber);
        expect(retrieved.extra, null);
      });
      test("Constructor fromJson", () {
        //Act
        WorldLocation retrieved =
            WorldLocation.fromJson(locationWithExtra.toJson());
        //expect
        expect(retrieved.streetName, locationWithExtra.streetName);
        expect(retrieved.streetNumber, locationWithExtra.streetNumber);
        expect(retrieved.extra, locationWithExtra.extra);
      });
      test("Constructor fromJson, when extra is null", () {
        //Act
        WorldLocation retrieved = WorldLocation.fromJson(location.toJson());
        //expect
        expect(retrieved.streetName, location.streetName);
        expect(retrieved.streetNumber, location.streetNumber);
        expect(retrieved.extra, location.extra);
      });
    });
    group("*WorldLocation Method Unit Tests*", () {
      test('toJson', () {
        //Arrange
        Map<String, dynamic> expected = {
          'streetName': 'Marienplatz',
          'streetNumber': 8,
          'extra': 'a'
        };

        //Act
        Map<String, dynamic> retrieved = locationWithExtra.toJson();

        //Expect
        expect(retrieved, expected);
      });
      test("toJson, when extra is null", () {
        //Arrange
        Map<String, dynamic> expected = {
          'streetName': 'Marienplatz',
          'streetNumber': 8,
          'extra': null
        };

        //Act
        Map<String, dynamic> retrieved = location.toJson();

        //Expect
        expect(retrieved, expected);
      });
      test("toString", () {
        //Arrange
        String expected =
            'WorldLocation(streetName: Marienplatz, streetNumber: 8, extra: a)';

        //Act
        String retrieved = locationWithExtra.toString();

        //Expect
        expect(retrieved, expected);
      });
      test("toString, when extra is null", () {
        //Arrange
        String expected =
            'WorldLocation(streetName: Marienplatz, streetNumber: 8, extra: null)';

        //Act
        String retrieved = location.toString();

        //Expect
        expect(retrieved, expected);
      });
      test("toFullName", () {
        //Arrange
        String expected = 'Marienplatz 8a';

        //Act
        String retrieved = locationWithExtra.toFullName();

        //Expect
        expect(retrieved, expected);
      });
      test("toFullName, when extra is null", () {
        //Arrange
        String expected = 'Marienplatz 8';

        //Act
        String retrieved = location.toFullName();

        //Expect
        expect(retrieved, expected);
      });
    });
  }
}
