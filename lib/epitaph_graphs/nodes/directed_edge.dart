import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

/// An implementation of an [Edge] in which a directionality exists.
abstract class DirectedEdge extends Edge {
  DirectedEdge(Vertex source, Vertex target, double weight)
      : super(source, target, weight);

  /// Source [Vertex] of your current [DirectedEdge]
  Vertex get source => super.a;

  /// Target [Vertex] of your current [DirectedEdge]
  Vertex get target => super.b;

  /// For checking if an Edge contains the [source] and [target] Vertices. This method has a directionality. [source] and [target] are not interchangeable.
  @override
  bool equalToVertices(Vertex source, Vertex target) =>
      this.source.equalsById(source) && this.target.equalsById(target);

  @override
  String toString() =>
      'DirectedEdge(source: ${source.id} -> target: ${target.id}, weight: $weight)';
}
