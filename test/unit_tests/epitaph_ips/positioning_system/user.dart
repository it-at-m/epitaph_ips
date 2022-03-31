import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/user.dart';

class UserTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    User user = User(
        position: Coordinate(0, 0),
        cardinalDir: 180.0,
        location: WorldLocation(streetName: 'Marienplatz', streetNumber: 8));

    group("*User constructor Unit Tests*", () {
      test("Constructor full constructor", () {
        //Arrange
        Coordinate expPosition = Coordinate(0, 0);
        double expCardinalDir = 180;
        WorldLocation expWorldLoc =
            WorldLocation(streetName: 'Marienplatz', streetNumber: 8);

        //Act

        //expected
        expect(user.position!.x, expPosition.x);
        expect(user.position!.y, expPosition.y);
        expect(user.position!.z, expPosition.z);
        expect(user.cardinalDir, expCardinalDir);
        expect(user.location!.streetName, expWorldLoc.streetName);
        expect(user.location!.streetNumber, expWorldLoc.streetNumber);
        expect(user.location!.extra, expWorldLoc.extra);
      });
      test("Constructor cardinalDir assertion false", () {
        //Arrange
        Coordinate expPosition = Coordinate(0, 0);
        double expCardinalDir = 370;
        WorldLocation expWorldLoc =
            WorldLocation(streetName: 'Marienplatz', streetNumber: 8);

        //expected
        expect(
            () => User(
                location: expWorldLoc,
                cardinalDir: expCardinalDir,
                position: expPosition),
            throwsAssertionError);

        expCardinalDir = -230;
        expect(
            () => User(
                location: expWorldLoc,
                cardinalDir: expCardinalDir,
                position: expPosition),
            throwsAssertionError);
      });
      test("Constructor cardinalDir 0, when parameter null", () {
        //Arrange
        double expValue = 0;

        //Act
        Coordinate expPosition = Coordinate(0, 0);
        WorldLocation expWorldLoc =
            WorldLocation(streetName: 'Marienplatz', streetNumber: 8);
        User retrieved = User(position: expPosition, location: expWorldLoc);

        //expected
        expect(retrieved.cardinalDir, expValue);
      });
      test("Constructor; position null", () {
        //Arrange
        double expCardinalDir = 180;
        WorldLocation expWorldLoc =
            WorldLocation(streetName: 'Marienplatz', streetNumber: 8);

        //Act
        User test = User(cardinalDir: expCardinalDir, location: expWorldLoc);

        //expected
        expect(test.position, null);
        expect(test.cardinalDir, expCardinalDir);
        expect(test.location!.streetName, expWorldLoc.streetName);
        expect(test.location!.streetNumber, expWorldLoc.streetNumber);
        expect(test.location!.extra, expWorldLoc.extra);
      });
      test("Constructor; location null", () {
        //Arrange
        Coordinate expPosition = Coordinate(0, 0);
        double expCardinalDir = 180;

        //Act
        User test =
            User(position: Coordinate(0, 0), cardinalDir: expCardinalDir);

        //expected
        expect(user.position!.x, expPosition.x);
        expect(user.position!.y, expPosition.y);
        expect(user.position!.z, expPosition.z);
        expect(test.cardinalDir, expCardinalDir);
        expect(test.location, null);
      });
    });
    group("*User method Unit Tests*", () {
      test("toString", () {
        //Arrange
        String expected =
            'User(position: Coordinate(x: 0.0, y: 0.0, z: 0.0), cardinalDir: 180.0, location: WorldLocation(streetName: Marienplatz, streetNumber: 8, extra: null))';

        //Act
        String retrieved = user.toString();

        //expected
        expect(retrieved, expected);
      });
      test("set cardinalDir assertion fail", () {
        //expected
        expect(() => user.cardinalDir = 370, throwsAssertionError);
        expect(() => user.cardinalDir = -230, throwsAssertionError);
      });
    });
  }
}
