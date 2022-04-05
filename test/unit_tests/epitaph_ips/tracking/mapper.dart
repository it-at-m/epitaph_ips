import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/graphs/epitaph_graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_vertex.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/calculator.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/filter.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/mapper.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

class MapperTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Map<EpitaphVertex, List<EpitaphEdge>> testMap = {
      EpitaphVertex('1', Coordinate(1, 1)): [
        EpitaphEdge(EpitaphVertex('1', Coordinate(1, 1)),
            EpitaphVertex('2', Coordinate(2, 2)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('2', Coordinate(2, 2)): [
        EpitaphEdge(
            EpitaphVertex('2', Coordinate(2, 2)),
            EpitaphVertex('3', Coordinate(3, 3)),
            1,
            EpitaphEdgeAttributes(),
            0),
        EpitaphEdge(EpitaphVertex('2', Coordinate(2, 2)),
            EpitaphVertex('4', Coordinate(4, 4)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('3', Coordinate(3, 3)): [
        EpitaphEdge(EpitaphVertex('3', Coordinate(3, 3)),
            EpitaphVertex('4', Coordinate(4, 4)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('4', Coordinate(4, 4)): [
        EpitaphEdge(
            EpitaphVertex('4', Coordinate(4, 4)),
            EpitaphVertex('5', Coordinate(5, 5)),
            1,
            EpitaphEdgeAttributes(),
            0),
        EpitaphEdge(EpitaphVertex('4', Coordinate(4, 4)),
            EpitaphVertex('6', Coordinate(6, 6)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('5', Coordinate(5, 5)): [
        EpitaphEdge(
            EpitaphVertex('5', Coordinate(5, 5)),
            EpitaphVertex('9', Coordinate(9, 9)),
            1,
            EpitaphEdgeAttributes(),
            0),
        EpitaphEdge(EpitaphVertex('5', Coordinate(5, 5)),
            EpitaphVertex('8', Coordinate(8, 8)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('6', Coordinate(6, 6)): [
        EpitaphEdge(EpitaphVertex('6', Coordinate(6, 6)),
            EpitaphVertex('7', Coordinate(7, 7)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('7', Coordinate(7, 7)): [
        EpitaphEdge(EpitaphVertex('7', Coordinate(7, 7)),
            EpitaphVertex('8', Coordinate(8, 8)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('8', Coordinate(8, 8)): [],
      EpitaphVertex('9', Coordinate(9, 9)): [
        EpitaphEdge(
            EpitaphVertex('9', Coordinate(9, 9)),
            EpitaphVertex('10', Coordinate(10, 10)),
            1,
            EpitaphEdgeAttributes(),
            0)
      ],
      EpitaphVertex('10', Coordinate(10, 10)): []
    };

    //Arrange
    _MockCalculator calculator = _MockCalculator();
    _MockFilter filter = _MockFilter();

    Building building = Building(
        key: 'InnoLab',
        location: WorldLocation(streetName: 'APB', streetNumber: 66),
        floors: [],
        area: PolygonalArea(points: [
          Coordinate(0, 0),
          Coordinate(60, 0),
          Coordinate(60, 60),
          Coordinate(0, 60)
        ]));

    EpitaphGraph graph = EpitaphGraph(testMap);

    group('*MapperTests Getter Unit Tests*', () {
      test('get mappedPosition', () {
        //Arrange
        Mapper mapper = Mapper(calculator, filter, graph, building);
        Coordinate expected = Coordinate.origin();

        //Act
        Coordinate received = mapper.mappedPosition;

        //Expect
        expect(received, expected);
      });
    });

    group('*MapperTests Setter Unit Tests*', () {
      test('set path', () {
        //Arrange
        Mapper mapper = Mapper(calculator, filter, graph, building);

        //Act and expect
        expect(() {
          mapper.path = Path(Queue<EpitaphVertex>());
        }, returnsNormally);
      });

      test('set currentEdge', () {
        //Arrange
        Mapper mapper = Mapper(calculator, filter, graph, building);

        //Act and expect
        expect(() {
          mapper.currentEdge = graph.graph.values.first.first;
        }, returnsNormally);
      });
    });

    group('*MapperTests Method Unit Tests*', () {
      test('getClosestEdge', () {
        //Arrange
        Mapper mapper = Mapper(calculator, filter, graph, building);
        String expected =
            'EpitaphEdge(source: 1 -> target: 2, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))';

        //Act
        String received = mapper.getClosestEdge().toString();

        //Expect
        expect(received, expected);
      });

      test('getShortestPath', () {
        //Arrange
        Mapper mapper = Mapper(calculator, filter, graph, building);
        String expected =
            'Path({EpitaphVertex(id: 1, coordinate: Coordinate(x: 1.0, y: 1.0, z: 0.0)), EpitaphVertex(id: 2, coordinate: Coordinate(x: 2.0, y: 2.0, z: 0.0)), EpitaphVertex(id: 4, coordinate: Coordinate(x: 4.0, y: 4.0, z: 0.0)), EpitaphVertex(id: 5, coordinate: Coordinate(x: 5.0, y: 5.0, z: 0.0)), EpitaphVertex(id: 9, coordinate: Coordinate(x: 9.0, y: 9.0, z: 0.0)), EpitaphVertex(id: 10, coordinate: Coordinate(x: 10.0, y: 10.0, z: 0.0))})';

        //Act
        String received = mapper.getShortestPath('10', '1').toString();

        //Expect
        expect(expected, received);
      });

      test('distanceToDestination', () {
        //Arrange
        Mapper mapper = Mapper(calculator, filter, graph, building);
        mapper.path = mapper.getShortestPath('10', '1');
        double expected = 14.142135623730951;

        //Act
        double received = mapper.distanceToDestination();

        //Expect
        expect(expected, received);
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
