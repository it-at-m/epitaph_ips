import 'dart:math';
import 'package:epitaph_ips/epitaph_graphs/nodes/directed_edge.dart';
import 'package:ml_linalg/linalg.dart';
import 'epitaph_vertex.dart';

///An [Edge] specifically programmed for Indoor Navigation purposes.
class EpitaphEdge extends DirectedEdge {
  EpitaphEdge._(EpitaphVertex source, EpitaphVertex target, double weight,
      this.attributes, this.cardinalDir)
      : assert(cardinalDir < 360 && cardinalDir >= 0,
            'cardinalDir has to be between 0 and 360. Please check your input.'),
        super(source, target, weight);

  factory EpitaphEdge(EpitaphVertex source, EpitaphVertex target, double weight,
      EpitaphEdgeAttributes attributes, double cardinalDir) {
    return EpitaphEdge._(source, target, weight, attributes, cardinalDir);
  }

  /// An attribute for the edge. Can be checked for.
  final EpitaphEdgeAttributes attributes;

  /// Cardinal point of the edge in the real world.
  final double cardinalDir;

  @override
  EpitaphVertex get source => super.source as EpitaphVertex;

  @override
  EpitaphVertex get target => super.target as EpitaphVertex;

  /// Returns the shortest distance from [position] to this edge
  double shortestDistance(Vector position) =>
      vectorFromPosition(position).norm();

  /// Returns vector with the shortest distance from [position] to this edge
  Vector vectorFromPosition(Vector position) {
    double scale = shadowScale(position);

    if (scale <= 0) {
      return source.point.toVector() - position;
    } else if (scale >= 1) {
      return target.point.toVector() - position;
    } else {
      Vector shadow = source.point.toVector() + toVector() * scale;
      return shadow - position;
    }
  }

  /// Returns the relative scale of the shortest source-position vector to this edge
  double shadowScale(Vector position) {
    Vector sourcePosition = position - source.point.toVector();
    return sourcePosition.dot(toVector()) / pow(weight, 2);
  }

  /// Checks heading of edge toward the target.
  bool headingTowardsTarget(double userHeading) {
    double source = (cardinalDir - 180) % 360;
    source = source < 0 ? source + 360 : source;
    double userSource = ((userHeading - source) + 180) % 360 - 180;
    double userTarget = ((userHeading - cardinalDir) + 180) % 360 - 180;
    return userTarget.abs() <= userSource.abs();
  }

  Vector toVector() => target.point.toVector() - source.point.toVector();

  @override
  EpitaphEdge copy() => this;

  @override
  String toString() =>
      'EpitaphEdge(source: ${source.id} -> target: ${target.id}, weight: $weight, cardinalDir: $cardinalDir, attributes: $attributes)';

  @override
  Map<String, dynamic> toJson() {
    return {
      'source': source.toJson(),
      'target': target.toJson(),
      'weight': weight,
      'cardinalDir': cardinalDir,
      'attributes': attributes.toJson()
    };
  }
}

class EpitaphEdgeAttributes {
  EpitaphEdgeAttributes({this.isFloorChange = false});

  EpitaphEdgeAttributes.fromJson(Map<String, dynamic> json)
      : isFloorChange = json['isFloorChange'];

  final bool isFloorChange;

  @override
  String toString() => 'EpitaphEdgeAttributes(isFloorChange: $isFloorChange)';

  Map<String, dynamic> toJson() => {'isFloorChange': isFloorChange};
}
