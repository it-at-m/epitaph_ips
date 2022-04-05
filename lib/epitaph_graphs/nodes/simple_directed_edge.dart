import 'package:epitaph_ips/epitaph_graphs/nodes/directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

/// A Simple implementation for quick use an a directed edge. A directed edge has a [source] -> [target] relation which does not work the other way around.
class SimpleDirectedEdge extends DirectedEdge {
  SimpleDirectedEdge(Vertex source, Vertex target, double weight)
      : super(source, target, weight);

  @override
  Edge copy() => this;

  @override
  Map<String, dynamic> toJson() =>
      {'source': source.toJson(), 'target': target.toJson(), 'weight': weight};

  @override
  String toString() =>
      'SimpleDirectedEdge(source: ${source.id} -> target: ${target.id}, weight: $weight)';
}
