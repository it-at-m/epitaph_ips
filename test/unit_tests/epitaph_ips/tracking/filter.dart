import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/filter.dart';

class FilterTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group('*FilterTests Method UnitTests*', () {
      test('filter', () {
        //Arrange
        _MockFilter filter = _MockFilter();
        List<Coordinate> coordinates = [];
        Coordinate expected = Coordinate(3, 3, 3);

        for (int i = 0; i < 7; i++) {
          coordinates.add(Coordinate(i.toDouble(), i.toDouble(), i.toDouble()));
        }

        //Act
        for (var element in coordinates) {
          filter.filter(element);
        }

        Coordinate received = filter.current;

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
        Coordinate initialPosition = Coordinate(1, 1, 7);
        Coordinate expectedCurrent = Coordinate(1, 1, 7);

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
        List<Coordinate> coordinates = [];
        Coordinate expectedCurrent = Coordinate.origin();

        for (int i = 0; i < 7; i++) {
          coordinates.add(Coordinate(i.toDouble(), i.toDouble(), i.toDouble()));
        }

        //Act
        for (var element in coordinates) {
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
