import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/calculator.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/filter.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/tracker.dart';

class TrackerTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group("*TrackerTests Getter Unit Tests*", () {
      test('get accuracy', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        double expected = 2.0;

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Coordinate(j, j, j)),
            MockBeacon('1', '1', Coordinate(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Coordinate(j + 2, j + 2, j + 2)),
          ]);
        }

        double received = tracker.accuracy;

        //Expected
        expect(received, expected);
      });

      test('get calculatedPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expected = Coordinate(3, 3, 3);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);
        Coordinate received = tracker.calculatedPosition;

        //Expected
        expect(received, expected);
      });

      test('get filteredPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expected = Coordinate(3.5, 3.5, 3.5);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Coordinate(j, j, j)),
            MockBeacon('1', '1', Coordinate(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Coordinate(j + 2, j + 2, j + 2)),
          ]);
        }

        Coordinate received = tracker.filteredPosition;

        //Expected
        expect(received, expected);
      });

      test('get finalPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expected = Coordinate(3.0, 3.0, 3.0);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Coordinate(j, j, j)),
            MockBeacon('1', '1', Coordinate(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Coordinate(j + 2, j + 2, j + 2)),
          ]);
        }

        Coordinate received = tracker.finalPosition;

        //Expected
        expect(received, expected);
      });
    });

    group('*TrackerTests Method Unit Tests*', () {
      test('reset', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expectedCoordinate = Coordinate.origin();

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);
        tracker.reset();

        //Expected
        expect(() {
          assert(tracker.calculatedPosition == expectedCoordinate);
          assert(tracker.filteredPosition == expectedCoordinate);
          assert(tracker.finalPosition == expectedCoordinate);
          assert(tracker.accuracy == 2.0);
        }, returnsNormally);
      });

      test('initiateTrackingCycle', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expectedCalculated = Coordinate(4.0, 4.0, 4.0);
        Coordinate expectedFiltered = Coordinate(3.5, 3.5, 3.5);
        Coordinate expectedFinal = Coordinate(3.0, 3.0, 3.0);
        double expectedAccuracy = 2.0;

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Coordinate(j, j, j)),
            MockBeacon('1', '1', Coordinate(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Coordinate(j + 2, j + 2, j + 2)),
          ]);
        }

        //Expected
        expect(() {
          assert(tracker.calculatedPosition == expectedCalculated);
          assert(tracker.filteredPosition == expectedFiltered);
          assert(tracker.finalPosition == expectedFinal);
          assert(tracker.accuracy == expectedAccuracy);
        }, returnsNormally);
      });

      test('initiateFirstScan', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expectedCoordinate = Coordinate(3.0, 3.0, 3.0);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);

        //Expected
        expect(() {
          assert(tracker.calculatedPosition == expectedCoordinate);
          assert(tracker.filteredPosition == expectedCoordinate);
          assert(tracker.finalPosition == expectedCoordinate);
          assert(tracker.accuracy == 2.0);
        }, returnsNormally);
      });

      test('calculatePosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expected = Coordinate(3.0, 3.0, 3.0);

        //Act
        Coordinate received = tracker.calculatePosition([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);

        //Expected
        expect(received, expected);
      });

      test('filterPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Coordinate expected = Coordinate(2.0, 1.5, 3.5);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Coordinate(1, 1, 1)),
          MockBeacon('1', '1', Coordinate(1, 1, 1)),
          MockBeacon('2', '2', Coordinate(7, 7, 7)),
        ]);
        Coordinate received = tracker.filterPosition(Coordinate(1, 0, 4));

        //Expected
        expect(received, expected);
      });
    });
  }
}

class _MockCalculator implements Calculator {
  @override
  Coordinate calculate(List<Beacon> beacons) {
    return beacons.fold(
            Coordinate.origin(),
            (previousValue, element) =>
                (previousValue as Coordinate) + element.position) /
        beacons.length;
  }
}

class _MockFilter extends Filter {
  Coordinate current = Coordinate(0, 0);
  List<Coordinate> values = [];

  @override
  Coordinate filter(Coordinate newPosition) {
    if (values.isEmpty) {
      configFilter(newPosition);
    } else {
      Coordinate sum =
          (values.reduce((value, element) => value + element)) / values.length;
      current = (sum + newPosition) / 2;
    }

    return current;
  }

  @override
  void configFilter(Coordinate initialPosition) {
    current = initialPosition.copy();
    values.add(initialPosition.copy());
  }

  @override
  void reset() {
    current = Coordinate(0, 0);
    values = [];
  }
}
