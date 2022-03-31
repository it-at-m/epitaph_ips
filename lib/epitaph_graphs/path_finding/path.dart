import 'dart:collection';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

/// A PODO class for pathfinding purposes. A given [path] can be read.
class Path {
  Path(this.path);

  /// Saved path.
  Queue<Vertex> path;

  int length() => path.length;

  Vertex elementAt(int index) => path.elementAt(index);

  @override
  String toString() => 'Path($path)';
}
