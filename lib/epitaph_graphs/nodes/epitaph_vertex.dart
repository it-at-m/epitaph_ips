import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';

/// The specific [Vertex] implementation for this library to make navigation possible.
class EpitaphVertex extends Vertex {
  EpitaphVertex(String id, this.point) : super(id);

  EpitaphVertex.fromJson(Map<String, dynamic> json)
      : point = Point.fromJson(json['Point']),
        super(json['id']);

  final Point point;

  /// Returns the euclidean distance from this [EpitaphVertex] to another.
  double distanceTo(EpitaphVertex other) => point.distanceTo(other.point);

  @override
  Vertex copy() => this;

  @override
  Map<String, dynamic> toJson() => {'id': id, 'Point': point.toJson()};

  @override
  String toString() => 'EpitaphVertex(id: $id, Point: ${point.toString()})';
}
