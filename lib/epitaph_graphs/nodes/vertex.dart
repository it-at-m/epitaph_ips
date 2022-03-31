///[Vertex] represents a node from a graph.
///[id] is the a unique identifier of the vertex/node.
abstract class Vertex {
  Vertex(this.id) : assert(id.isNotEmpty, "Vertex id cannot be empty.");

  late final String id;

  /// A check if the this vertex is equal to [other] by its given id.
  bool equalsById(Vertex other) => id == other.id;

  /// Returns a copy of the instance of your object
  Vertex copy();

  /// Serializes an object
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'Vertex(id: $id)';
  }
}
