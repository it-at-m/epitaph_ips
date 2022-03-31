import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/graphs/undirected_graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_undirected_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/undirected_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

class UndirectedGraphTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Map<SimpleVertex, List<SimpleUndirectedEdge>> testMap = {
      SimpleVertex('1'): [
        SimpleUndirectedEdge(SimpleVertex('1'), SimpleVertex('2'), 1)
      ],
      SimpleVertex('2'): [
        SimpleUndirectedEdge(SimpleVertex('2'), SimpleVertex('3'), 1),
        SimpleUndirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1)
      ],
      SimpleVertex('3'): [
        SimpleUndirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
      ],
      SimpleVertex('4'): [
        SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1),
        SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1)
      ],
      SimpleVertex('5'): [
        SimpleUndirectedEdge(SimpleVertex('5'), SimpleVertex('9'), 1),
        SimpleUndirectedEdge(SimpleVertex('5'), SimpleVertex('8'), 1)
      ],
      SimpleVertex('6'): [
        SimpleUndirectedEdge(SimpleVertex('6'), SimpleVertex('7'), 1)
      ],
      SimpleVertex('7'): [
        SimpleUndirectedEdge(SimpleVertex('7'), SimpleVertex('8'), 1)
      ],
      SimpleVertex('8'): [],
      SimpleVertex('9'): [
        SimpleUndirectedEdge(SimpleVertex('9'), SimpleVertex('10'), 1)
      ],
      SimpleVertex('10'): []
    };

    UndirectedGraph graph = UndirectedGraph(testMap);

    //Run all Edge Constructor unit tests
    group("*UndirectedGraph Constructor Unit Tests*", () {});
    //Run all Edge Method unit tests
    group("*UndirectedGraph Method Unit Tests*", () {
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
      test("Edge equalToEdge test", () {
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
        SimpleUndirectedEdge expectedValue =
            graph.getEdgeByString("2", "3") as SimpleUndirectedEdge;

        //Act
        SimpleUndirectedEdge retrieved =
            graph.getEdge(source, target) as SimpleUndirectedEdge;

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getEdgeByString in graph", () {
        //Arrange
        SimpleVertex source = graph.getVertexByString("2") as SimpleVertex;
        SimpleVertex target = graph.getVertexByString("3") as SimpleVertex;
        SimpleUndirectedEdge expectedValue =
            graph.getEdge(source, target) as SimpleUndirectedEdge;

        //Act
        SimpleUndirectedEdge retrieved =
            graph.getEdgeByString("2", "3") as SimpleUndirectedEdge;

        //Assert
        expect(retrieved, expectedValue);
      });
      test("getAllEdges in graph", () {
        //Arrange
        List<UndirectedEdge> expected = [
          UndirectedEdge(SimpleVertex('1'), SimpleVertex('2'), 1.0),
          UndirectedEdge(SimpleVertex('2'), SimpleVertex('3'), 1.0),
          UndirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1.0),
          UndirectedEdge(SimpleVertex('2'), SimpleVertex('1'), 1.0),
          UndirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1.0),
          UndirectedEdge(SimpleVertex('3'), SimpleVertex('2'), 1.0),
          UndirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1.0),
          UndirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1.0),
          UndirectedEdge(SimpleVertex('4'), SimpleVertex('2'), 1.0),
          UndirectedEdge(SimpleVertex('4'), SimpleVertex('3'), 1.0),
          UndirectedEdge(SimpleVertex('5'), SimpleVertex('9'), 1.0),
          UndirectedEdge(SimpleVertex('5'), SimpleVertex('8'), 1.0),
          UndirectedEdge(SimpleVertex('5'), SimpleVertex('4'), 1.0),
          UndirectedEdge(SimpleVertex('6'), SimpleVertex('7'), 1.0),
          UndirectedEdge(SimpleVertex('6'), SimpleVertex('4'), 1.0),
          UndirectedEdge(SimpleVertex('7'), SimpleVertex('8'), 1.0),
          UndirectedEdge(SimpleVertex('7'), SimpleVertex('6'), 1.0),
          UndirectedEdge(SimpleVertex('8'), SimpleVertex('5'), 1.0),
          UndirectedEdge(SimpleVertex('8'), SimpleVertex('7'), 1.0),
          UndirectedEdge(SimpleVertex('9'), SimpleVertex('10'), 1.0),
          UndirectedEdge(SimpleVertex('9'), SimpleVertex('5'), 1.0),
          UndirectedEdge(SimpleVertex('10'), SimpleVertex('9'), 1.0),
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
        List<SimpleUndirectedEdge> expected = [
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1),
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1),
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('2'), 1),
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('3'), 1),
        ];

        //Act
        List<Edge> retrieved =
            graph.getOutgoingEdges(graph.getVertexByString("4"));

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getOutgoingEdgesByString in graph", () {
        //Arrange
        List<SimpleUndirectedEdge> expected = [
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('5'), 1),
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('6'), 1),
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('2'), 1),
          SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('3'), 1),
        ];

        //Act
        List<Edge> retrieved = graph.getOutgoingEdgesByString('4');

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getNeighboringEdgesOfEdge in graph", () {
        List<SimpleUndirectedEdge> expected = [
          SimpleUndirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1),
          SimpleUndirectedEdge(SimpleVertex('2'), SimpleVertex('1'), 1),
          SimpleUndirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
        ];

        //Act
        List<UndirectedEdge> retrieved = graph.getNeighboringEdgesOfEdge(
          graph.getEdgeByString(
            SimpleVertex('2').id,
            SimpleVertex('3').id,
          ),
        );

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("getNeighboringEdgesOfEdgeByString in graph", () {
        List<SimpleUndirectedEdge> expected = [
          SimpleUndirectedEdge(SimpleVertex('2'), SimpleVertex('4'), 1),
          SimpleUndirectedEdge(SimpleVertex('2'), SimpleVertex('1'), 1),
          SimpleUndirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
        ];

        //Act
        List<UndirectedEdge> retrieved =
            graph.getNeighboringEdgesOfEdgeByString('2', '3');

        //Assert
        expect(retrieved.toString(), expected.toString());
      });
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'graph': {
            '1': {
              'a': {'id': '1'},
              'b': {'id': '2'},
              'weight': 1.0
            },
            '2': {
              'a': {'id': '2'},
              'b': {'id': '1'},
              'weight': 1.0
            },
            '3': {
              'a': {'id': '3'},
              'b': {'id': '2'},
              'weight': 1.0
            },
            '4': {
              'a': {'id': '4'},
              'b': {'id': '3'},
              'weight': 1.0
            },
            '5': {
              'a': {'id': '5'},
              'b': {'id': '4'},
              'weight': 1.0
            },
            '6': {
              'a': {'id': '6'},
              'b': {'id': '4'},
              'weight': 1.0
            },
            '7': {
              'a': {'id': '7'},
              'b': {'id': '6'},
              'weight': 1.0
            },
            '8': {
              'a': {'id': '8'},
              'b': {'id': '7'},
              'weight': 1.0
            },
            '9': {
              'a': {'id': '9'},
              'b': {'id': '5'},
              'weight': 1.0
            },
            '10': {
              'a': {'id': '10'},
              'b': {'id': '9'},
              'weight': 1.0
            }
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
            'UndirectedGraph({SimpleVertex(id: 1): [UndirectedEdge(a: 1, b: 2, weight: 1.0)], SimpleVertex(id: 2): [UndirectedEdge(a: 2, b: 3, weight: 1.0), UndirectedEdge(a: 2, b: 4, weight: 1.0), UndirectedEdge(a: 2, b: 1, weight: 1.0)], SimpleVertex(id: 3): [UndirectedEdge(a: 3, b: 4, weight: 1.0), UndirectedEdge(a: 3, b: 2, weight: 1.0)], SimpleVertex(id: 4): [UndirectedEdge(a: 4, b: 5, weight: 1.0), UndirectedEdge(a: 4, b: 6, weight: 1.0), UndirectedEdge(a: 4, b: 2, weight: 1.0), UndirectedEdge(a: 4, b: 3, weight: 1.0)], SimpleVertex(id: 5): [UndirectedEdge(a: 5, b: 9, weight: 1.0), UndirectedEdge(a: 5, b: 8, weight: 1.0), UndirectedEdge(a: 5, b: 4, weight: 1.0)], SimpleVertex(id: 6): [UndirectedEdge(a: 6, b: 7, weight: 1.0), UndirectedEdge(a: 6, b: 4, weight: 1.0)], SimpleVertex(id: 7): [UndirectedEdge(a: 7, b: 8, weight: 1.0), UndirectedEdge(a: 7, b: 6, weight: 1.0)], SimpleVertex(id: 8): [UndirectedEdge(a: 8, b: 5, weight: 1.0), UndirectedEdge(a: 8, b: 7, weight: 1.0)], SimpleVertex(id: 9): [UndirectedEdge(a: 9, b: 10, weight: 1.0), UndirectedEdge(a: 9, b: 5, weight: 1.0)], SimpleVertex(id: 10): [UndirectedEdge(a: 10, b: 9, weight: 1.0)]})';
        //Act
        String retrieved = graph.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
