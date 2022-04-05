import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';

class MockBeaconTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    MockBeacon testBeacon = MockBeacon(
        'E4:E1:12:9A:49:EB', 'blukii BXXXXX E4E1129B0B88', Coordinate(1, 1));

    group("*MockBeacon constructor Unit Tests*", () {
      test("id cannot be empty", () {
        //Arrange
        Matcher expectedValue = throwsAssertionError;

        //Act and expect
        expect(
            () =>
                MockBeacon("", 'blukii BXXXXX E4E1129B0B88', Coordinate(1, 1)),
            expectedValue);
      });
      test("name cannot be empty", () {
        //Arrange
        Matcher expectedValue = throwsAssertionError;

        //Act and expect
        expect(() => MockBeacon('E4:E1:12:9A:49:EB', '', Coordinate(1, 1)),
            expectedValue);
      });
    });
    test("fromJson Constructor", () {
      //Arrange
      String expectedId = testBeacon.id;
      String expectedName = testBeacon.name;
      double expectedPositionX = testBeacon.position.x;
      double expectedPositionY = testBeacon.position.x;

      //Act
      Map<String, dynamic> json = testBeacon.toJson();
      MockBeacon retrieved = MockBeacon.fromJson(json);

      //expect
      expect(retrieved.id, expectedId);
      expect(retrieved.name, expectedName);
      expect(retrieved.x, expectedPositionX);
      expect(retrieved.y, expectedPositionY);
    });
    group("*MockBeacon getter Unit Tests*", () {
      test("get location", () {
        //Arrange
        Coordinate expectedValue = Coordinate(1.0, 1.0);

        //Act
        Coordinate retrieved = testBeacon.position;

        //expect
        expect(retrieved.x, expectedValue.x);
        expect(retrieved.y, expectedValue.y);
      });
      test("get distanceToUser", () {
        //Arrange
        double expectedValue = 1.0;

        //Act
        testBeacon.rssiUpdate(-57);
        double retrieved = testBeacon.distanceToUser;

        //expect
        expect(retrieved, expectedValue);
      });
      test("get id", () {
        //Arrange
        String expectedValue = "E4:E1:12:9A:49:EB";

        //Act
        String retrieved = testBeacon.id;

        //expect
        expect(retrieved, expectedValue);
      });
      test("get name", () {
        //Arrange
        String expectedValue = "blukii BXXXXX E4E1129B0B88";

        //Act
        String retrieved = testBeacon.name;

        //expect
        expect(retrieved, expectedValue);
      });
      test("get rssi", () {
        //Arrange
        int expectedValue = -57;

        //Act
        testBeacon.rssiUpdate(-57);
        int retrieved = testBeacon.rssi.toInt();

        //expect
        expect(retrieved, expectedValue);
      });
    });
    group("*MockBeacon  Method Unit Tests*", () {
      test("rssiUpdate", () {
        //Arrange
        int expectedValue = -12;

        //Act
        testBeacon.rssiUpdate(-12);
        int retrieved = testBeacon.rssi.toInt();

        //expect
        expect(retrieved, expectedValue);
      });
      test("sendRssiAdvertisement", () {
        //Arrange
        bool expectedMatchingValue = true;
        List<int> expectedValues = [-57, -58, -59, -60, -61, -62, -63];

        //Act
        bool foundMatchingValue = false;
        testBeacon.sendRssiAdvertisement(Coordinate(2, 2));
        int retrieved = testBeacon.rssi.toInt();
        for (var element in expectedValues) {
          if (element == retrieved) foundMatchingValue = true;
        }

        //expect
        expect(foundMatchingValue, expectedMatchingValue);
      });
      test("rssiUpdate greater than 0 assertion error", () {
        //expect
        expect(() => testBeacon.rssiUpdate(4), throwsAssertionError);
      });
      test("getXYDistanceRSSI", () {
        //Arrange
        List<double> expectedValue = [1.0, 1.0, 0.015848931924611134, -21.0];

        //Act
        testBeacon.rssiUpdate(-21);
        List<double> retrieved = testBeacon.getXYDistanceRSSI();

        //expect
        expect(retrieved, expectedValue);
      });

      test("copy", () {
        //Arrange
        MockBeacon expected = testBeacon;

        //Act
        MockBeacon actEdge = testBeacon.copy() as MockBeacon;

        expect(actEdge, expected);
      });
      test("toJson", () {
        //Arrange
        Map<String, dynamic> expected = {
          'id': 'E4:E1:12:9A:49:EB',
          'name': 'blukii BXXXXX E4E1129B0B88',
          'position': {'x': 1.0, 'y': 1.0, 'z': 0.0}
        };

        //Act
        Map<String, dynamic> retrieved = testBeacon.toJson();

        expect(retrieved, expected);
      });
      test("toString", () {
        //Arrange
        String expectedValue =
            'Beacon(id: E4:E1:12:9A:49:EB, name: blukii BXXXXX E4E1129B0B88, position: Coordinate(x: 1.0, y: 1.0, z: 0.0), rssi: -23.0, distanceToUser: 0.0199526231496888)';

        //Act
        testBeacon.rssiUpdate(-23);
        String retrieved = testBeacon.toString();

        //expect
        expect(retrieved, expectedValue);
      });
    });
  }
}
