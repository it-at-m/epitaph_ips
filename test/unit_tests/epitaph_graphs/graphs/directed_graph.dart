import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/graphs/directed_graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

class DirectedGraphTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Map<SimpleVertex, List<SimpleDirectedEdge>> testMap = {
      SimpleVertex('1'): [
        SimpleDirectedEdge(SimpleVertex('1'), SimpleVertex('2'), 1)
      ],
      SimpleVertex('2'): [
        SimpleDirectedEdge(SimpleVertex('2'), SimpleVertex('3'), 1),
        SimpleDirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1)
      ],
      SimpleVertex('3'): [
        SimpleDirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
      ],
      SimpleVertex('4'): [
        SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1),
        SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1)
      ],
      SimpleVertex('5'): [
        SimpleDirectedEdge(SimpleVertex('5'), SimpleVertex('9'), 1),
        SimpleDirectedEdge(SimpleVertex('5'), SimpleVertex('8'), 1)
      ],
      SimpleVertex('6'): [
        SimpleDirectedEdge(SimpleVertex('6'), SimpleVertex('7'), 1)
      ],
      SimpleVertex('7'): [
        SimpleDirectedEdge(SimpleVertex('7'), SimpleVertex('8'), 1)
      ],
      SimpleVertex('8'): [],
      SimpleVertex('9'): [
        SimpleDirectedEdge(SimpleVertex('9'), SimpleVertex('10'), 1)
      ],
      SimpleVertex('10'): []
    };

    DirectedGraph graph = DirectedGraph(testMap);

    //Run all Edge Constructor unit tests
    group("*DirectedGraph Constructor Unit Tests*", () {});
    //Run all Edge Method unit tests
    group("*DirectedGraph Method Unit Tests*", () {
      test("getVertex in graph", () {
        //Arrange
        String expectedValue = "2";
        SimpleVertex vertex = SimpleVertex("2");

        //Act
        Vertex retrieved = graph.getVertex(vertex);

        //Assert
        expect(retrieved.id, expectedValue);
      });
      test("getVertexByString in graph", () {
        //Arrange
        String expectedValue = "2";

        //Act
        SimpleVertex retrieved = graph.getVertexByString("2") as SimpleVertex;

        //Assert
        expect(retrieved.id, expectedValue);
      });
      test("getAllVertices test", () {
        //Arrange
        List<SimpleVertex> expectedValue = [
          SimpleVertex('1'),
          SimpleVertex('2'),
          SimpleVertex('3'),
          SimpleVertex('4'),
          SimpleVertex('5'),
          SimpleVertex('6'),
          SimpleVertex('7'),
          SimpleVertex('8'),
          SimpleVertex('9'),
          SimpleVertex('10')
        ];

        //Act
        List<Vertex> retrieved = graph.getAllVertices();

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
        SimpleVertex source = graph.getVertexByString("2") as SimpleVertex;
        SimpleVertex target = graph.getVertexByString("3") as SimpleVertex;
        SimpleDirectedEdge expectedValue =
            graph.getEdgeByString("2", "3") as SimpleDirectedEdge;

        //Act
        SimpleDirectedEdge retrieved =
            graph.getEdge(source, target) as SimpleDirectedEdge;

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getEdgeByString in graph", () {
        //Arrange
        SimpleVertex source = graph.getVertexByString("2") as SimpleVertex;
        SimpleVertex target = graph.getVertexByString("3") as SimpleVertex;
        SimpleDirectedEdge expectedValue =
            graph.getEdge(source, target) as SimpleDirectedEdge;

        //Act
        SimpleDirectedEdge retrieved =
            graph.getEdgeByString("2", "3") as SimpleDirectedEdge;

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getAllEdges in graph", () {
        //Arrange
        List<SimpleDirectedEdge> expected = [
          SimpleDirectedEdge(SimpleVertex('1'), SimpleVertex('2'), 1),
          SimpleDirectedEdge(SimpleVertex('2'), SimpleVertex('3'), 1),
          SimpleDirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1),
          SimpleDirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1),
          SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1),
          SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1),
          SimpleDirectedEdge(SimpleVertex('5'), SimpleVertex('9'), 1),
          SimpleDirectedEdge(SimpleVertex('5'), SimpleVertex('8'), 1),
          SimpleDirectedEdge(SimpleVertex('6'), SimpleVertex('7'), 1),
          SimpleDirectedEdge(SimpleVertex('7'), SimpleVertex('8'), 1),
          SimpleDirectedEdge(SimpleVertex('9'), SimpleVertex('10'), 1),
        ];

        //Act
        List<Edge> retrieved = graph.getAllEdges();

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
        Queue<SimpleVertex> vertices = Queue.from(
            [SimpleVertex('1'), SimpleVertex('2'), SimpleVertex('3')]);
        Path path = Path(vertices);

        //Act
        double retrieved = graph.getPathWeight(path);

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getOutgoingEdges in graph", () {
        //Arrange
        List<SimpleDirectedEdge> expected = [
          SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1),
          SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1)
        ];

        //Act
        List<Edge> retrieved =
            graph.getOutgoingEdges(graph.getVertexByString("4"));

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getOutgoingEdgesByString in graph", () {
        //Arrange
        List<SimpleDirectedEdge> expected = [
          SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1),
          SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1)
        ];

        //Act
        List<Edge> retrieved = graph.getOutgoingEdgesByString('4');

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getNeighboringEdgesOfEdge in graph", () {
        List<SimpleDirectedEdge> expected = [
          SimpleDirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1),
          SimpleDirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
        ];

        //Act
        List<DirectedEdge> retrieved = graph.getNeighboringEdgesOfEdge(
          graph.getEdgeByString(
            SimpleVertex('2').id,
            SimpleVertex('3').id,
          ),
        );

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getNeighboringEdgesOfEdgeByString in graph", () {
        List<SimpleDirectedEdge> expected = [
          SimpleDirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1),
          SimpleDirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
        ];

        //Act
        List<DirectedEdge> retrieved =
            graph.getNeighboringEdgesOfEdgeByString('2', '3');

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'graph': {
            '1': {
              'source': {'id': '1'},
              'target': {'id': '2'},
              'weight': 1.0
            },
            '2': {
              'source': {'id': '2'},
              'target': {'id': '4'},
              'weight': 1.0
            },
            '3': {
              'source': {'id': '3'},
              'target': {'id': '4'},
              'weight': 1.0
            },
            '4': {
              'source': {'id': '4'},
              'target': {'id': '6'},
              'weight': 1.0
            },
            '5': {
              'source': {'id': '5'},
              'target': {'id': '8'},
              'weight': 1.0
            },
            '6': {
              'source': {'id': '6'},
              'target': {'id': '7'},
              'weight': 1.0
            },
            '7': {
              'source': {'id': '7'},
              'target': {'id': '8'},
              'weight': 1.0
            },
            '8': {},
            '9': {
              'source': {'id': '9'},
              'target': {'id': '10'},
              'weight': 1.0
            },
            '10': {},
          }
        };

        //Act
        Map<String, dynamic> retrieved = graph.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString Edge syntax test", () {
        //Arrange
        String expectedValue =
            'DirectedGraph({SimpleVertex(id: 1): [SimpleDirectedEdge(source: 1 -> target: 2, weight: 1.0)], SimpleVertex(id: 2): [SimpleDirectedEdge(source: 2 -> target: 3, weight: 1.0), SimpleDirectedEdge(source: 2 -> target: 4, weight: 1.0)], SimpleVertex(id: 3): [SimpleDirectedEdge(source: 3 -> target: 4, weight: 1.0)], SimpleVertex(id: 4): [SimpleDirectedEdge(source: 4 -> target: 5, weight: 1.0), SimpleDirectedEdge(source: 4 -> target: 6, weight: 1.0)], SimpleVertex(id: 5): [SimpleDirectedEdge(source: 5 -> target: 9, weight: 1.0), SimpleDirectedEdge(source: 5 -> target: 8, weight: 1.0)], SimpleVertex(id: 6): [SimpleDirectedEdge(source: 6 -> target: 7, weight: 1.0)], SimpleVertex(id: 7): [SimpleDirectedEdge(source: 7 -> target: 8, weight: 1.0)], SimpleVertex(id: 8): [], SimpleVertex(id: 9): [SimpleDirectedEdge(source: 9 -> target: 10, weight: 1.0)], SimpleVertex(id: 10): []})';

        //Act
        String retrieved = graph.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
