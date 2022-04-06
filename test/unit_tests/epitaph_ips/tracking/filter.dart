import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/filter.dart';

class FilterTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group('*FilterTests Method UnitTests*', () {
      test('filter', () {
        //Arrange
        _MockFilter filter = _MockFilter();
        List<Point> points = [];
        Point expected = Point(3, 3, 3);

        for (int i = 0; i < 7; i++) {
          points.add(Point(i.toDouble(), i.toDouble(), i.toDouble()));
        }

        //Act
        for (var element in points) {
          filter.filter(element);
        }

        Point received = filter.current;

        //Expected
        expect(() {
          assert(received.x == expected.x);
          assert(received.y == expected.y);
          assert(received.z == expected.z);
        }, returnsNormally);
      });

      test('configFilter', () {
        //Arrange
        _MockFilter filter = _MockFilter();
        Point initialPosition = Point(1, 1, 7);
        Point expectedCurrent = Point(1, 1, 7);

        //Act
        filter.configFilter(initialPosition);

        //Expected
        expect(() {
          assert(filter.values.length == 1);
          assert(filter.current == expectedCurrent);
        }, returnsNormally);
      });

      test('reset', () {
        //Arrange
        _MockFilter filter = _MockFilter();
        List<Point> points = [];
        Point expectedCurrent = Point.origin();

        for (int i = 0; i < 7; i++) {
          points.add(Point(i.toDouble(), i.toDouble(), i.toDouble()));
        }

        //Act
        for (var element in points) {
          filter.filter(element);
        }

        filter.reset();

        //Expected
        expect(() {
          assert(filter.values.isEmpty);
          assert(filter.current == expectedCurrent);
        }, returnsNormally);
      });
    });
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
