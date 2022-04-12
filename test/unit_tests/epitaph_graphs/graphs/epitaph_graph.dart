import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/graphs/epitaph_graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';

class EpitaphGraphTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Map<EpitaphVertex, List<EpitaphEdge>> testMap = {
      EpitaphVertex('1', Point(1, 1)): [
        EpitaphEdge(EpitaphVertex('1', Point(1, 1)),
            EpitaphVertex('2', Point(2, 2)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('2', Point(2, 2)): [
        EpitaphEdge(EpitaphVertex('2', Point(2, 2)),
            EpitaphVertex('3', Point(3, 3)), 1, EpitaphEdgeAttributes(), 0),
        EpitaphEdge(EpitaphVertex('2', Point(2, 2)),
            EpitaphVertex('4', Point(4, 4)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('3', Point(3, 3)): [
        EpitaphEdge(EpitaphVertex('3', Point(3, 3)),
            EpitaphVertex('4', Point(4, 4)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('4', Point(4, 4)): [
        EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
            EpitaphVertex('5', Point(5, 5)), 1, EpitaphEdgeAttributes(), 0),
        EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
            EpitaphVertex('6', Point(6, 6)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('5', Point(5, 5)): [
        EpitaphEdge(EpitaphVertex('5', Point(5, 5)),
            EpitaphVertex('9', Point(9, 9)), 1, EpitaphEdgeAttributes(), 0),
        EpitaphEdge(EpitaphVertex('5', Point(5, 5)),
            EpitaphVertex('8', Point(8, 8)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('6', Point(6, 6)): [
        EpitaphEdge(EpitaphVertex('6', Point(6, 6)),
            EpitaphVertex('7', Point(7, 7)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('7', Point(7, 7)): [
        EpitaphEdge(EpitaphVertex('7', Point(7, 7)),
            EpitaphVertex('8', Point(8, 8)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('8', Point(8, 8)): [],
      EpitaphVertex('9', Point(9, 9)): [
        EpitaphEdge(EpitaphVertex('9', Point(9, 9)),
            EpitaphVertex('10', Point(10, 10)), 1, EpitaphEdgeAttributes(), 0)
      ],
      EpitaphVertex('10', Point(10, 10)): []
    };

    EpitaphGraph graph = EpitaphGraph(testMap);

    //Run all Edge Constructor unit tests
    group("*EpitaphGraph Constructor Unit Tests*", () {});
    //Run all Edge Method unit tests
    group("*EpitaphGraph Method Unit Tests*", () {
      test("getVertex in graph", () {
        //Arrange
        String expectedValue = "2";
        EpitaphVertex vertex = EpitaphVertex('2', Point(2, 2));

        //Act
        Vertex retrieved = graph.getVertex(vertex);

        //Assert
        expect(retrieved.id, expectedValue);
      });
      test("getVertexByString in graph", () {
        //Arrange
        String expectedValue = "2";

        //Act
        EpitaphVertex retrieved = graph.getVertexByString("2");

        //Assert
        expect(retrieved.id, expectedValue);
      });
      test("getAllVertices test", () {
        //Arrange
        List<EpitaphVertex> expectedValue = [
          EpitaphVertex('1', Point(1, 1)),
          EpitaphVertex('2', Point(2, 2)),
          EpitaphVertex('3', Point(3, 3)),
          EpitaphVertex('4', Point(4, 4)),
          EpitaphVertex('5', Point(5, 5)),
          EpitaphVertex('6', Point(6, 6)),
          EpitaphVertex('7', Point(7, 7)),
          EpitaphVertex('8', Point(8, 8)),
          EpitaphVertex('9', Point(9, 9)),
          EpitaphVertex('10', Point(10, 10))
        ];

        //Act
        List<EpitaphVertex> retrieved = graph.getAllVertices();

        //expected
        //Assert Vertex names should be equal, but vertices have different hashcodes
        for (int i = 0; i < expectedValue.length; i++) {
          expect(retrieved[i].id, expectedValue[i].id);
          expect(
              retrieved[i].hashCode, isNot(equals(expectedValue[i].hashCode)));
        }
      });
      test("getEdge in graph", () {
        //Arrange
        EpitaphVertex source = graph.getVertexByString("2");
        EpitaphVertex target = graph.getVertexByString("3");
        EpitaphEdge expectedValue = graph.getEdgeByString("2", "3");

        //Act
        EpitaphEdge retrieved = graph.getEdge(source, target);

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getEdgeByString in graph", () {
        //Arrange
        EpitaphVertex source = graph.getVertexByString("2");
        EpitaphVertex target = graph.getVertexByString("3");
        EpitaphEdge expectedValue = graph.getEdge(source, target);

        //Act
        EpitaphEdge retrieved = graph.getEdgeByString("2", "3");

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getAllEdges in graph", () {
        //Arrange
        List<EpitaphEdge> expected = [
          EpitaphEdge(EpitaphVertex('1', Point(1, 1)),
              EpitaphVertex('2', Point(2, 2)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('2', Point(2, 2)),
              EpitaphVertex('3', Point(3, 3)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('2', Point(2, 2)),
              EpitaphVertex('4', Point(4, 4)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('3', Point(3, 3)),
              EpitaphVertex('4', Point(4, 4)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
              EpitaphVertex('5', Point(5, 5)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
              EpitaphVertex('6', Point(6, 6)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('5', Point(5, 5)),
              EpitaphVertex('9', Point(9, 9)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('5', Point(5, 5)),
              EpitaphVertex('8', Point(8, 8)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('6', Point(6, 6)),
              EpitaphVertex('7', Point(7, 7)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('7', Point(7, 7)),
              EpitaphVertex('8', Point(8, 8)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('9', Point(9, 9)),
              EpitaphVertex('10', Point(10, 10)), 1, EpitaphEdgeAttributes(), 0)
        ];

        //Act
        List<EpitaphEdge> retrieved = graph.getAllEdges();

        //Assert Vertex names should be equal, but vertices have different hashcodes
        for (int i = 0; i < expected.length; i++) {
          expect(retrieved[i].a.id, expected[i].a.id);
          expect(retrieved[i].b.id, expected[i].b.id);
          expect(retrieved[i].weight, expected[i].weight);
          expect(retrieved[i].hashCode, isNot(equals(expected[i].hashCode)));
        }
      });
      test("getEdgeWeight in graph", () {
        //Arrange
        double expectedValue = 1;

        //Act
        double retrieved = graph.getEdgeWeight(
            graph.getVertexByString("2"), graph.getVertexByString("3"));

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getPathWeight in graph", () {
        //Arrange
        double expectedValue = 2.0;
        Queue<EpitaphVertex> vertices = Queue.from([
          EpitaphVertex('1', Point(1, 1)),
          EpitaphVertex('2', Point(2, 2)),
          EpitaphVertex('3', Point(3, 3))
        ]);
        Path path = Path(vertices);

        //Act
        double retrieved = graph.getPathWeight(path);

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getOutgoingEdges in graph", () {
        //Arrange
        List<EpitaphEdge> expected = [
          EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
              EpitaphVertex('5', Point(5, 5)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
              EpitaphVertex('6', Point(6, 6)), 1, EpitaphEdgeAttributes(), 0)
        ];

        //Act
        List<EpitaphEdge> retrieved =
            graph.getOutgoingEdges(graph.getVertexByString("4"));

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getOutgoingEdgesByString in graph", () {
        //Arrange
        List<EpitaphEdge> expected = [
          EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
              EpitaphVertex('5', Point(5, 5)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('4', Point(4, 4)),
              EpitaphVertex('6', Point(6, 6)), 1, EpitaphEdgeAttributes(), 0)
        ];

        //Act
        List<EpitaphEdge> retrieved = graph.getOutgoingEdgesByString('4');

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getNeighboringEdgesOfEdge in graph", () {
        List<EpitaphEdge> expected = [
          EpitaphEdge(EpitaphVertex('2', Point(2, 2)),
              EpitaphVertex('4', Point(3, 3)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('3', Point(2, 2)),
              EpitaphVertex('4', Point(3, 3)), 1, EpitaphEdgeAttributes(), 0),
        ];

        //Act
        List<EpitaphEdge> retrieved = graph.getNeighboringEdgesOfEdge(
          graph.getEdgeByString(
            EpitaphVertex('2', Point(2, 2)).id,
            EpitaphVertex('3', Point(3, 3)).id,
          ),
        );

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getNeighboringEdgesOfEdgeByString in graph", () {
        List<EpitaphEdge> expected = [
          EpitaphEdge(EpitaphVertex('2', Point(2, 2)),
              EpitaphVertex('4', Point(3, 3)), 1, EpitaphEdgeAttributes(), 0),
          EpitaphEdge(EpitaphVertex('3', Point(2, 2)),
              EpitaphVertex('4', Point(3, 3)), 1, EpitaphEdgeAttributes(), 0),
        ];

        //Act
        List<DirectedEdge> retrieved =
            graph.getNeighboringEdgesOfEdgeByString('2', '3');

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("toString Edge syntax test", () {
        //Arrange
        String expectedValue =
            'EpitaphGraph({EpitaphVertex(id: 1, Point: Point(x: 1.0, y: 1.0, z: 0.0)): [EpitaphEdge(source: 1 -> target: 2, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 2, Point: Point(x: 2.0, y: 2.0, z: 0.0)): [EpitaphEdge(source: 2 -> target: 3, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false)), EpitaphEdge(source: 2 -> target: 4, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 3, Point: Point(x: 3.0, y: 3.0, z: 0.0)): [EpitaphEdge(source: 3 -> target: 4, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 4, Point: Point(x: 4.0, y: 4.0, z: 0.0)): [EpitaphEdge(source: 4 -> target: 5, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false)), EpitaphEdge(source: 4 -> target: 6, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 5, Point: Point(x: 5.0, y: 5.0, z: 0.0)): [EpitaphEdge(source: 5 -> target: 9, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false)), EpitaphEdge(source: 5 -> target: 8, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 6, Point: Point(x: 6.0, y: 6.0, z: 0.0)): [EpitaphEdge(source: 6 -> target: 7, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 7, Point: Point(x: 7.0, y: 7.0, z: 0.0)): [EpitaphEdge(source: 7 -> target: 8, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 8, Point: Point(x: 8.0, y: 8.0, z: 0.0)): [], EpitaphVertex(id: 9, Point: Point(x: 9.0, y: 9.0, z: 0.0)): [EpitaphEdge(source: 9 -> target: 10, weight: 1.0, cardinalDir: 0.0, attributes: EpitaphEdgeAttributes(isFloorChange: false))], EpitaphVertex(id: 10, Point: Point(x: 10.0, y: 10.0, z: 0.0)): []})';
        //Act
        String retrieved = graph.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
