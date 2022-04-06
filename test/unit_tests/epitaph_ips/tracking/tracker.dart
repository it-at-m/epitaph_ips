import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
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
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Point(j, j, j)),
            MockBeacon('1', '1', Point(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Point(j + 2, j + 2, j + 2)),
          ]);
        }

        double received = tracker.accuracy;

        //Expected
        expect(received, expected);
      });

      test('get calculatedPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Point expected = Point(3, 3, 3);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);
        Point received = tracker.calculatedPosition;

        //Expected
        expect(received, expected);
      });

      test('get filteredPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Point expected = Point(3.5, 3.5, 3.5);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Point(j, j, j)),
            MockBeacon('1', '1', Point(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Point(j + 2, j + 2, j + 2)),
          ]);
        }

        Point received = tracker.filteredPosition;

        //Expected
        expect(received, expected);
      });

      test('get finalPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Point expected = Point(3.0, 3.0, 3.0);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Point(j, j, j)),
            MockBeacon('1', '1', Point(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Point(j + 2, j + 2, j + 2)),
          ]);
        }

        Point received = tracker.finalPosition;

        //Expected
        expect(received, expected);
      });
    });

    group('*TrackerTests Method Unit Tests*', () {
      test('reset', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Point expectedPoint = Point.origin();

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);
        tracker.reset();

        //Expected
        expect(() {
          assert(tracker.calculatedPosition == expectedPoint);
          assert(tracker.filteredPosition == expectedPoint);
          assert(tracker.finalPosition == expectedPoint);
          assert(tracker.accuracy == 2.0);
        }, returnsNormally);
      });

      test('initiateTrackingCycle', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Point expectedCalculated = Point(4.0, 4.0, 4.0);
        Point expectedFiltered = Point(3.5, 3.5, 3.5);
        Point expectedFinal = Point(3.0, 3.0, 3.0);
        double expectedAccuracy = 2.0;

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);

        for (int i = 0; i < 4; i++) {
          double j = i.toDouble();
          tracker.initiateTrackingCycle([
            MockBeacon('0', '0', Point(j, j, j)),
            MockBeacon('1', '1', Point(j + 1, j + 1, j + 1)),
            MockBeacon('2', '2', Point(j + 2, j + 2, j + 2)),
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
        Point expectedPoint = Point(3.0, 3.0, 3.0);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);

        //Expected
        expect(() {
          assert(tracker.calculatedPosition == expectedPoint);
          assert(tracker.filteredPosition == expectedPoint);
          assert(tracker.finalPosition == expectedPoint);
          assert(tracker.accuracy == 2.0);
        }, returnsNormally);
      });

      test('calculatePosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Point expected = Point(3.0, 3.0, 3.0);

        //Act
        Point received = tracker.calculatePosition([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);

        //Expected
        expect(received, expected);
      });

      test('filterPosition', () {
        //Arrange
        Tracker tracker = Tracker(_MockCalculator(), _MockFilter());
        Point expected = Point(2.0, 1.5, 3.5);

        //Act
        tracker.initiateFirstScan([
          MockBeacon('0', '0', Point(1, 1, 1)),
          MockBeacon('1', '1', Point(1, 1, 1)),
          MockBeacon('2', '2', Point(7, 7, 7)),
        ]);
        Point received = tracker.filterPosition(Point(1, 0, 4));

        //Expected
        expect(received, expected);
      });
    });
  }
}

class _MockCalculator implements Calculator {
  @override
  Point calculate(List<Beacon> beacons) {
    return beacons.fold(
            Point.origin(),
            (previousValue, element) =>
                (previousValue as Point) + element.position) /
        beacons.length;
  }
}

class _MockFilter extends Filter {
  Point current = Point(0, 0);
  List<Point> values = [];

  @override
  Point filter(Point newPosition) {
    if (values.isEmpty) {
      configFilter(newPosition);
    } else {
      Point sum =
          (values.reduce((value, element) => value + element)) / values.length;
      current = (sum + newPosition) / 2;
    }

    return current;
  }

  @override
  void configFilter(Point initialPosition) {
    current = initialPosition.copy();
    values.add(initialPosition.copy());
  }

  @override
  void reset() {
    current = Point(0, 0);
    values = [];
  }
}
