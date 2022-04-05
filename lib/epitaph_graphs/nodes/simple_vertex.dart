import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

/// A simple implementation of [Vertex] that can be used in a fast manner if no special implementation is needed.
class SimpleVertex extends Vertex {
  SimpleVertex(String id) : super(id);

  SimpleVertex.fromJson(Map<String, dynamic> json) : super(json['id']);

  @override
  Vertex copy() => this;

  @override
  Map<String, dynamic> toJson() => {'id': id};

  @override
  String toString() => 'SimpleVertex(id: $id)';
}
