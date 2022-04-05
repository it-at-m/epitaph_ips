import 'package:epitaph_ips/epitaph_graphs/nodes/undirected_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

/// A simple implementation of an [UndirectedEdge]. For quick and easy use.
class SimpleUndirectedEdge extends UndirectedEdge {
  SimpleUndirectedEdge(Vertex a, Vertex b, double weight) : super(a, b, weight);

  @override
  SimpleUndirectedEdge copy() => SimpleUndirectedEdge(a, b, weight);

  @override
  SimpleUndirectedEdge reversedEdge() => SimpleUndirectedEdge(b, a, weight);

  @override
  Map<String, dynamic> toJson() =>
      {'a': a.toJson(), 'b': b.toJson(), 'weight': weight};
}
