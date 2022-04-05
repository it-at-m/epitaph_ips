import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

/// The representation of an edge.
abstract class Edge {
  Edge(this.a, this.b, this.weight)
      : assert(!weight.isNegative, 'weight is not allowed to be negative.');

  ///One of the points of the edge
  Vertex a;

  ///One of the points of the edge
  Vertex b;

  ///Weight of this edge.
  final double weight;

  /// For checking if an Edge contains Vertices [a] and [b].
  bool equalToVertices(Vertex a, Vertex b) {
    return this.a.equalsById(a) && this.b.equalsById(b) ||
        this.a.equalsById(b) && this.b.equalsById(a);
  }

  /// For checking if an Edge contains the same vertices as [other].
  bool equalToEdge(Edge other) {
    return equalToVertices(other.a, other.b);
  }

  /// Returns a copy of the instance of your object
  Edge copy();

  /// Serializes an object
  Map<String, dynamic> toJson();

  @override
  String toString() => 'Edge(a: ${a.id}, b: ${b.id}, weight: $weight)';
}
