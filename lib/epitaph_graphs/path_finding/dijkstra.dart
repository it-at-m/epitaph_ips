import 'dart:collection';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

///A class with the tools needed to solve a shortest path problem with the Dijkstra algorithm.
class Dijkstra {
  Dijkstra(this.graph);

  ///[_graph] contains the graph to which the dijkstra algorithm is applied
  Map<Vertex, List<Edge>> graph;

  ///[_distance] contains the shortest distance from the start node to all other nodes of the graph
  final Map<Vertex, Map<Vertex, double>> _distances = {};

  ///[_unoptimized] contains all nodes that were not yet active during the dijkstra algorithm
  final List<Vertex> _unoptimized = [];

  ///A starting vertex [start] and a destination vertex [destination] are passed in order to solve the shortest path problem by
  ///using the dijkstra algorithm. A FIFO queue with each vertex is returned in which the shortest path is contained.
  Path solve(Vertex start, Vertex destination) {
    ///The current inspected node. ALWAYS [start] in the first iteration.
    Vertex activeNode;

    ///performs the initialisation using the start node
    _initialize(start);

    ///[activeNode] contains the currently active node, at the beginning the start node
    activeNode = graph.keys.firstWhere((element) => element.id == start.id);

    ///as long as there are still nodes that were not yet active, the distances to the starting point are calculated and updated if necessary
    while (_unoptimized.isNotEmpty) {
      ///for each neighbour of the active node the distance to the starting point is calculated, which arises on the current path
      ///if this distance is shorter than the previous one the new distance is entered and the active node is entered as predecessor

      List<Edge> currentEdges = [];

      for (var element in graph[activeNode]!) {
        Vertex? tmp;
        //Don't get me wrong I hate every single thing about this
        for (var node in graph.keys) {
          if (node.id == element.b.id) {
            tmp = node;
          }
        }
        if (_unoptimized.contains(tmp)) {
          currentEdges.add(element);
        }
      }
      for (var edge in currentEdges) {
        Map<Vertex, double> tmp = _distances[activeNode]!;

        //To correct floating point problems
        const int precision = 10;

        double checkingWeight =
            ((edge.weight + tmp.values.first) * precision).round() / precision;
        //This is only here because Dart isn't willing find element.target in the distance map.
        late Vertex keyToUpdate;
        _distances.forEach((key, value) {
          if (key.id == edge.b.id) {
            keyToUpdate = key;
          }
        });
        if (_distances[keyToUpdate]!.values.first != double.infinity) {
          if (checkingWeight < _distances[keyToUpdate]!.values.first) {
            _distances.update(
                keyToUpdate, (value) => {activeNode: checkingWeight});
          }
        } else {
          _distances.update(
              keyToUpdate, (value) => {activeNode: checkingWeight});
        }
      }

      ///the active node is deleted from the list [unoptimized]
      _unoptimized.remove(activeNode);

      late Vertex currentNearestVertex = _unoptimized.first;
      double currentLowestValue = double.infinity;
      for (var vertex in _unoptimized) {
        if (_distances[vertex]!.values.first < currentLowestValue) {
          currentLowestValue = _distances[vertex]!.values.first;
          currentNearestVertex = vertex;
        }
      }
      if (_unoptimized.isEmpty) break;
      activeNode = currentNearestVertex;
    }

    Vertex starting =
        graph.keys.firstWhere((element) => element.id == start.id);
    Vertex end =
        graph.keys.firstWhere((element) => element.id == destination.id);

    ///[path] contains the shortest path from start to end node
    Path path = _buildPath(starting, end);

    return path;
  }

  ///Finds vertices by their strings and uses these to find the shortest path in between them.
  Path solveByString(String start, String destination) {
    Vertex starting = graph.keys.firstWhere((element) => element.id == start);
    Vertex end = graph.keys.firstWhere((element) => element.id == destination);
    return solve(starting, end);
  }

  ///[_initialize] takes an initialisation of the class using the start node.
  void _initialize(Vertex start) {
    ///sets the distance of the start node to 0, the distance of the remaining nodes to infinity and adds all nodes to the list [available]
    for (var element in graph.keys) {
      if (element.id == start.id) {
        Map<Vertex, double> tmp = {element: 0};
        _distances[element] = tmp;
      } else {
        Map<Vertex, double> tmp = {SimpleVertex('empty'): double.infinity};
        _distances[element] = tmp;
      }

      _unoptimized.add(element);
    }
  }

  ///Sets up the queue which symbolizes the shortest path. Data in [_distances] is used
  ///to determine which are the vertices with the shortest distance to each other when looked at our starting node.
  Path _buildPath(Vertex start, Vertex destination) {
    Queue<Vertex> path = Queue();
    Vertex currentVertex = destination;
    if (start == destination) {
      path.add(start);
      return Path(path);
    }
    while (true) {
      path.addFirst(currentVertex);
      Vertex vertexIterator = _distances[currentVertex]!.keys.first;
      if (start.id == vertexIterator.id) {
        currentVertex = _distances[currentVertex]!.keys.first;
        path.addFirst(currentVertex);
        break;
      } else {
        currentVertex = _distances[currentVertex]!.keys.first;
      }
    }
    return Path(path);
  }
}
