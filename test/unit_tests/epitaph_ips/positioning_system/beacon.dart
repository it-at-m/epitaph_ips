import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';

class BeaconTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    _MockBeacon testBeacon = _MockBeacon(
        'E4:E1:12:9A:49:EB', 'blukii BXXXXX E4E1129B0B88', Point(1, 1));

    group("*Beacon constructor Unit Tests*", () {
      test("id cannot be empty", () {
        //Arrange
        Matcher expectedValue = throwsAssertionError;

        //Act and expect
        expect(() => _MockBeacon("", 'blukii BXXXXX E4E1129B0B88', Point(1, 1)),
            expectedValue);
      });
      test("name cannot be empty", () {
        //Arrange
        Matcher expectedValue = throwsAssertionError;

        //Act and expect
        expect(() => _MockBeacon('E4:E1:12:9A:49:EB', '', Point(1, 1)),
            expectedValue);
      });
    });
    group("*Beacon getter Unit Tests*", () {
      test("get location", () {
        //Arrange
        Point expectedValue = Point(1.0, 1.0);

        //Act
        Point retrieved = testBeacon.position;

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
    group("*Beacon  Method Unit Tests*", () {
      test("rssiUpdate", () {
        //Arrange
        int expectedValue = -12;

        //Act
        testBeacon.rssiUpdate(-12);
        int retrieved = testBeacon.rssi.toInt();

        //expect
        expect(retrieved, expectedValue);
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
        _MockBeacon expected = testBeacon;

        //Act
        _MockBeacon actEdge = testBeacon.copy() as _MockBeacon;

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
            'Beacon(id: E4:E1:12:9A:49:EB, name: blukii BXXXXX E4E1129B0B88, position: Point(x: 1.0, y: 1.0, z: 0.0), rssi: -23.0, distanceToUser: 0.0199526231496888)';

        //Act
        testBeacon.rssiUpdate(-23);
        String retrieved = testBeacon.toString();

        //expect
        expect(retrieved, expectedValue);
      });
    });
    group("*BeaconConfiguration constructor Unit Tests*", () {
      test("No assertion error", () {
        //Arrange
        Matcher expectedValue = isNot(throwsAssertionError);

        //Act and expect
        expect(
            () => const BeaconsConfiguration(
                measuredPower: -66,
                advertisementInterval: 1.0,
                environmentalFactor: 3),
            expectedValue);
      });
      test("measuredPower assertion error", () {
        //Arrange
        Matcher expectedValue = throwsAssertionError;

        //Act and expect
        expect(
            () => BeaconsConfiguration(
                measuredPower: 1,
                advertisementInterval: 1.0,
                environmentalFactor: 3),
            expectedValue);
      });
      test("advertisementInterval assertion error", () {
        //Arrange
        Matcher expectedValue = throwsAssertionError;

        //Act and expect
        expect(
            () => BeaconsConfiguration(
                measuredPower: -66,
                advertisementInterval: 0.0,
                environmentalFactor: 3),
            expectedValue);
      });
      test("environmentalFactor assertion error", () {
        //Arrange
        Matcher expectedValue = throwsAssertionError;

        //Act and expect
        expect(
            () => BeaconsConfiguration(
                measuredPower: -66, environmentalFactor: 1),
            expectedValue);
      });
    });
  }
}

class _MockBeacon extends Beacon {
  _MockBeacon(String id, String name, Point position)
      : super(id: id, name: name, position: position);

  @override
  Beacon copy() => this;

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'position': position.toJson()};
}
