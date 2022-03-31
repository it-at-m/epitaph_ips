import 'dart:collection';
import 'package:epitaph_ips/epitaph_graphs/graphs/graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

/// A specific implementation used for indoor positioning purposes. Use this one if you want to represent rooms in your buildings.
class EpitaphGraph extends Graph {
  EpitaphGraph(this.graph);

  ///This map is the representation of your directed graph.
  late final Map<EpitaphVertex, List<EpitaphEdge>> graph;

  @override
  EpitaphVertex getVertex(Vertex vertex) =>
      graph.keys.firstWhere((element) => vertex.id == element.id);

  @override
  EpitaphVertex getVertexByString(String source) =>
      graph.keys.firstWhere((element) => source == element.id);

  @override
  List<EpitaphVertex> getAllVertices() {
    List<EpitaphVertex> vertexList = [];
    for (var element in graph.keys) {
      vertexList.add(element);
    }
    return vertexList;
  }

  @override
  EpitaphEdge getEdge(Vertex a, Vertex b) =>
      graph[a]!.firstWhere((element) => element.b.equalsById(b));

  @override
  EpitaphEdge getEdgeByString(String a, String b) =>
      graph[getVertexByString(a)]!
          .firstWhere((element) => element.b.equalsById(getVertexByString(b)));

  @override
  double getEdgeWeight(Vertex a, Vertex b) => graph[getVertex(a)]!
      .firstWhere((element) => element.b.equalsById(b))
      .weight;

  @override
  List<EpitaphEdge> getAllEdges() {
    List<EpitaphEdge> tmp = [];
    for (var element in graph.values) {
      tmp.addAll(element);
    }

    return tmp;
  }

  @override
  List<EpitaphEdge> getNeighboringEdgesOfEdge(Edge edge) {
    List<EpitaphEdge> found = [];
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
  List<EpitaphEdge> getNeighboringEdgesOfEdgeByString(String a, String b) {
    List<EpitaphEdge> found = [];
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
  List<EpitaphEdge> getOutgoingEdges(Vertex vertex) {
    List<EpitaphEdge> found = [];
    found.addAll(graph[getVertex(vertex)] as List<EpitaphEdge>);
    return found;
  }

  @override
  List<EpitaphEdge> getOutgoingEdgesByString(String source) {
    List<EpitaphEdge> tmp = [];
    tmp.addAll(graph[getVertexByString(source)]!);
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

  /*@override
  Map<String, dynamic> toJson() {
    // Lists cannot be automatically be generated, this is why this method is convoluted
    Map<dynamic, List<dynamic>> pointsMap = Map();
    graph.forEach((k, v) {
      List<dynamic> edgeList = [];
      if (v.isNotEmpty) {
        v.forEach((element) {
          edgeList.add(element.toJson());
        });
      } else {
        edgeList.add({});
      }
      pointsMap[k.toJson()] = edgeList;
    });

    return {'graph': pointsMap};
  }*/

  @override
  String toString() => 'EpitaphGraph($graph)';
}
