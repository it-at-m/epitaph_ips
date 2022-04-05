import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';

/// The specific [Vertex] implementation for this library to make navigation possible.
class EpitaphVertex extends Vertex {
  EpitaphVertex(String id, this.coordinate) : super(id);

  EpitaphVertex.fromJson(Map<String, dynamic> json)
      : coordinate = Coordinate.fromJson(json['coordinate']),
        super(json['id']);

  final Coordinate coordinate;

  /// Returns the euclidean distance from this [EpitaphVertex] to another.
  double distanceTo(EpitaphVertex other) =>
      coordinate.distanceTo(other.coordinate);

  @override
  Vertex copy() => this;

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'coordinate': coordinate.toJson()};

  @override
  String toString() =>
      'EpitaphVertex(id: $id, coordinate: ${coordinate.toString()})';
}
