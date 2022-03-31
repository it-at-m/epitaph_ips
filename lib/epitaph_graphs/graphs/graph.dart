import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

/// A class that is an abstract implementation of a graph with vertices and edges. Has basic methods and structure.
abstract class Graph {
  ///Searches [graph] and finds and returns a vertex.
  Vertex getVertex(Vertex vertex);

  ///Searches [graph] and finds and returns a vertex with the same name as the specified [source] string.
  Vertex getVertexByString(String source);

  /// Returns an [Edge] in a graph with [Vertex] [a] and [b]
  Edge getEdge(Vertex a, Vertex b);

  ///Searches [graph] and finds and returns an edge with the same name as the specified [a] and [b] string.
  Edge getEdgeByString(String a, String b);

  ///A Method to get the weight of an edge. Because the graph has directional nodes
  ///you need to specify a starting node [a] and an ending node [b]. Because this is a directed graph [a] and [b] are NOT interchangeable.
  double getEdgeWeight(Vertex a, Vertex b);

  ///Gets the weight of a specified [path]
  double getPathWeight(Path path);

  ///Returns a list of all edges in [graph].
  List<Edge> getAllEdges();

  ///Returns a list of all vertices in [graph].
  List<Vertex> getAllVertices();

  /// Gets all neighboring edges of a vertex
  List<Edge> getOutgoingEdges(Vertex vertex);

  /// Gets all neighboring edges of a [source] that gets searched by string in [graph]
  List<Edge> getOutgoingEdgesByString(String source);

  /// Gets all neighboring edges of an [edge]
  List<Edge> getNeighboringEdgesOfEdge(Edge edge);

  /// Gets all neighboring edges of an edge searched for by [a] and [b]
  List<Edge> getNeighboringEdgesOfEdgeByString(String a, String b);
}
