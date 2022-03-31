import 'dart:collection';
import 'package:epitaph_ips/epitaph_graphs/graphs/graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/undirected_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

/// An implementation of a weighted, undirected graph.
class UndirectedGraph extends Graph {
  UndirectedGraph(Map<Vertex, List<UndirectedEdge>> graph) {
    Map<Vertex, List<UndirectedEdge>> secondList = {};
    graph.forEach((key, value) {
      secondList[key] = value;
    });

    graph.forEach((vertex, edgeList) {
      for (var edge in edgeList) {
        bool modify = true;
        Vertex vertex =
            secondList.keys.firstWhere((element) => edge.b.id == element.id);

        for (var targets in secondList[vertex]!) {
          if (targets.a == edge.reversedEdge().a &&
              targets.b == edge.reversedEdge().b) modify = false;
        }

        if (modify) secondList[vertex]!.add(edge.reversedEdge());
      }
    });
    this.graph = secondList;
  }

  late final Map<Vertex, List<Edge>> graph;

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
  Edge getEdge(Vertex a, Vertex b) {
    UndirectedEdge foundEdge;
    if (graph[a]!.any((element) => element.b.equalsById(b))) {
      foundEdge = graph[a]!.firstWhere((element) => element.b.equalsById(b))
          as UndirectedEdge;
    } else {
      foundEdge = graph[b]!.firstWhere((element) => element.a.equalsById(a))
          as UndirectedEdge;
    }
    return foundEdge;
  }

  @override
  Edge getEdgeByString(String a, String b) => graph[getVertexByString(a)]!
      .firstWhere((element) => element.b.equalsById(getVertexByString(b)));

  @override
  double getEdgeWeight(Vertex a, Vertex b) => graph[getVertex(a)]!
      .firstWhere((element) => element.b.equalsById(b))
      .weight;

  @override
  List<UndirectedEdge> getNeighboringEdgesOfEdge(Edge edge) {
    List<UndirectedEdge> found = [];
    getOutgoingEdges(edge.a).forEach((element) {
      found.add(element);
    });

    getOutgoingEdges(edge.b).forEach((element) {
      if (element.b != edge.a) {
        found.add(element);
      }
    });

    // Remove the edge itself
    found.remove(edge);
    found.remove(UndirectedEdge(edge.b, edge.a, edge.weight));

    return found;
  }

  @override
  List<UndirectedEdge> getNeighboringEdgesOfEdgeByString(String a, String b) {
    List<UndirectedEdge> found = [];
    getOutgoingEdgesByString(a).forEach((element) {
      found.add(element);
    });

    getOutgoingEdgesByString(b).forEach((element) {
      found.add(element);
    });

    found.remove(getEdgeByString(a, b));
    found.remove(getEdgeByString(b, a));

    return found;
  }

  @override
  List<UndirectedEdge> getOutgoingEdges(Vertex vertex) {
    List<UndirectedEdge> found = [];
    found.addAll(graph[getVertex(vertex)] as List<UndirectedEdge>);
    return found;
  }

  @override
  List<UndirectedEdge> getOutgoingEdgesByString(String source) {
    List<UndirectedEdge> tmp = [];
    tmp.addAll(graph[getVertexByString(source)]! as List<UndirectedEdge>);
    return tmp;
  }

  @override
  List<Edge> getAllEdges() {
    List<Edge> tmp = [];
    for (var element in graph.values) {
      tmp.addAll(element);
    }

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
      for (var element in v) {
        pointsMap[k.id] = element.toJson();
      }
    });

    return {'graph': pointsMap};
  }

  @override
  String toString() => 'UndirectedGraph($graph)';
}
