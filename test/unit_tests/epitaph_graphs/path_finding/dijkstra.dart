import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/graphs/directed_graph.dart';
import 'package:epitaph_ips/epitaph_graphs/graphs/undirected_graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_undirected_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/dijkstra.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

class DijkstraTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    Map<SimpleVertex, List<SimpleDirectedEdge>> directedGraph = {
      SimpleVertex('1'): [
        SimpleDirectedEdge(SimpleVertex('1'), SimpleVertex('2'), 1)
      ],
      SimpleVertex('2'): [
        SimpleDirectedEdge(SimpleVertex('2'), SimpleVertex('3'), 1)
      ],
      SimpleVertex('3'): [
        SimpleDirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
      ],
      SimpleVertex('4'): [
        SimpleDirectedEdge(SimpleVertex('4'), SimpleVertex('2'), 1),
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

    Map<SimpleVertex, List<SimpleUndirectedEdge>> undirectedGraph = {
      SimpleVertex('1'): [
        SimpleUndirectedEdge(SimpleVertex('1'), SimpleVertex('2'), 1)
      ],
      SimpleVertex('2'): [
        SimpleUndirectedEdge(SimpleVertex('2'), SimpleVertex('3'), 1)
      ],
      SimpleVertex('3'): [
        SimpleUndirectedEdge(SimpleVertex('3'), SimpleVertex('4'), 1)
      ],
      SimpleVertex('4'): [
        SimpleUndirectedEdge(SimpleVertex('4'), SimpleVertex('2'), 1),
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

    group("*Dijkstra DirectedGraph*", () {
      test('Solve DirectedGraph', () {
        DirectedGraph dGraph = DirectedGraph(directedGraph);

        SimpleVertex start = SimpleVertex('2');
        SimpleVertex destination = SimpleVertex('4');

        Dijkstra dijkstra = Dijkstra(dGraph.graph);

        Path expected = Path(Queue.from(
            [SimpleVertex('2'), SimpleVertex('3'), SimpleVertex('4')]));

        Path retrieved = dijkstra.solve(start, destination);

        for (int i = 0; i < retrieved.path.length; i++) {
          expect(retrieved.path.elementAt(i).id, expected.path.elementAt(i).id);
        }
      });
      test('SolveByString DirectedGraph', () {
        DirectedGraph dGraph = DirectedGraph(directedGraph);
        Dijkstra dijkstra = Dijkstra(dGraph.graph);

        Path expected = Path(Queue.from(
            [SimpleVertex('2'), SimpleVertex('3'), SimpleVertex('4')]));

        Path retrieved = dijkstra.solveByString('2', '4');

        for (int i = 0; i < retrieved.path.length; i++) {
          expect(retrieved.path.elementAt(i).id, expected.path.elementAt(i).id);
        }
      });
    });

    group("*Dijkstra UndirectedGraph*", () {
      test('Solve UndirectedGraph', () {
        UndirectedGraph uGraph = UndirectedGraph(undirectedGraph);
        SimpleVertex start = SimpleVertex('2');
        SimpleVertex destination = SimpleVertex('4');

        Dijkstra dijkstra = Dijkstra(uGraph.graph);

        Path expected =
            Path(Queue.from([SimpleVertex('2'), SimpleVertex('4')]));

        Path retrieved = dijkstra.solve(start, destination);

        for (int i = 0; i < retrieved.path.length; i++) {
          expect(retrieved.path.elementAt(i).id, expected.path.elementAt(i).id);
        }
      });
      test('SolveByString UndirectedGraph', () {
        UndirectedGraph uGraph = UndirectedGraph(undirectedGraph);
        Dijkstra dijkstra = Dijkstra(uGraph.graph);

        Path expected =
            Path(Queue.from([SimpleVertex('2'), SimpleVertex('4')]));

        Path retrieved = dijkstra.solveByString('2', '4');

        for (int i = 0; i < retrieved.path.length; i++) {
          expect(retrieved.path.elementAt(i).id, expected.path.elementAt(i).id);
        }
      });
    });
  }
}
