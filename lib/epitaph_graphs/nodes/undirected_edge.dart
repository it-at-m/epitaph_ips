import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

/// Abstract class extending [Edge]. When building an undirected [Edge] this class should be extended.
/// An undirected edge in a graph has ne directionality. That means that using a [Vertex] [a] or [b] as a starting point
/// will not change if an operation is true or not.
class UndirectedEdge extends Edge {
  UndirectedEdge(Vertex a, Vertex b, double weight) : super(a, b, weight);

  @override
  UndirectedEdge copy() => UndirectedEdge(a, b, weight);

  UndirectedEdge reversedEdge() => UndirectedEdge(b, a, weight);

  @override
  Map<String, dynamic> toJson() =>
      {'a': a.toJson(), 'b': b.toJson(), 'weight': weight};

  @override
  String toString() =>
      'UndirectedEdge(a: ${a.id}, b: ${b.id}, weight: $weight)';
}
