import 'dart:collection';
import 'package:epitaph_ips/epitaph_graphs/graphs/graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

/// An implementation of a graph with directed edges.
class DirectedGraph extends Graph {
  DirectedGraph(this.graph);

  ///This map is the representation of your directed graph.
  final Map<Vertex, List<Edge>> graph;

  @override
  Vertex getVertex(Vertex vertex) =>
      graph.keys.firstWhere((element) => vertex.id == element.id);

  @override
  Vertex getVertexByString(String source) =>
      graph.keys.firstWhere((element) => source == element.id);

  @override
  List<Vertex> getAllVertices() {
    List<Vertex> vertexList = [];
    for (var element in graph.keys) {
      vertexList.add(element);
    }
    return vertexList;
  }

  @override
  Edge getEdge(Vertex a, Vertex b) =>
      graph[a]!.firstWhere((element) => element.b.equalsById(b));

  @override
  Edge getEdgeByString(String a, String b) => graph[getVertexByString(a)]!
      .firstWhere((element) => element.b.equalsById(getVertexByString(b)));

  @override
  double getEdgeWeight(Vertex a, Vertex b) => graph[getVertex(a)]!
      .firstWhere((element) => element.b.equalsById(b))
      .weight;

  @override
  List<Edge> getAllEdges() {
    List<Edge> tmp = [];
    for (var element in graph.values) {
      tmp.addAll(element);
    }

    return tmp;
  }

  @override
  List<DirectedEdge> getNeighboringEdgesOfEdge(Edge edge) {
    List<DirectedEdge> found = [];
    getOutgoingEdges(edge.a).forEach((element) {
      found.add(element);
    });

    getOutgoingEdges(edge.b).forEach((element) {
      if (element.target != edge.a) {
        found.add(element);
      }
    });

    // Remove the edge itself
    found.remove(edge);

    return found;
  }

  @override
  List<DirectedEdge> getNeighboringEdgesOfEdgeByString(String a, String b) {
    List<DirectedEdge> found = [];
    getOutgoingEdgesByString(a).forEach((element) {
      found.add(element);
    });

    getOutgoingEdgesByString(b).forEach((element) {
      found.add(element);
    });

    found.remove(getEdgeByString(a, b));

    return found;
  }

  @override
  List<DirectedEdge> getOutgoingEdges(Vertex vertex) {
    List<DirectedEdge> found = [];
    found.addAll(graph[getVertex(vertex)] as List<DirectedEdge>);
    return found;
  }

  @override
  List<DirectedEdge> getOutgoingEdgesByString(String source) {
    List<DirectedEdge> tmp = [];
    tmp.addAll(graph[getVertexByString(source)]! as List<DirectedEdge>);
    return tmp;
  }

  @override
  double getPathWeight(Path path) {
    double pathWeight = 0;
    Queue<Vertex> pathList = path.path;

    for (int i = 0; i < pathList.length - 1; i++) {
      pathWeight +=
          getEdgeWeight(pathList.elementAt(i), pathList.elementAt(i + 1));
    }

    return pathWeight;
  }

  Map<String, dynamic> toJson() {
    // Lists cannot be automatically be generated, this is why this method is convoluted
    Map<String, dynamic> pointsMap = {};
    graph.forEach((k, v) {
      if (v.isNotEmpty) {
        for (var element in v) {
          pointsMap[k.id] = element.toJson();
        }
      } else {
        pointsMap[k.id] = {};
      }
    });

    return {'graph': pointsMap};
  }

  @override
  String toString() => 'DirectedGraph($graph)';
}
