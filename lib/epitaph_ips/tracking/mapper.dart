import 'dart:collection';
import 'package:epitaph_ips/epitaph_graphs/graphs/epitaph_graph.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/dijkstra.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/filter.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/tracker.dart';
import 'package:ml_linalg/vector.dart';
import 'calculator.dart';

///Handles interaction between tracking and graphs
class Mapper extends Tracker {
  Mapper._(Calculator calculator, Filter filter, this._graph, this._dijkstra,
      this._building)
      : super(calculator, filter);

  factory Mapper(Calculator calculator, Filter filter, EpitaphGraph graph,
      Building building) {
    return Mapper._(calculator, filter, graph, Dijkstra(graph.graph), building);
  }

  ///Graph to map on
  final EpitaphGraph _graph;

  ///Dijkstra instance for logical graph traversal
  final Dijkstra _dijkstra;

  ///Building to map in
  final Building _building;

  ///Mapped position
  Point _mappedPosition = Point.origin();

  ///Path to current destination
  Path path = Path(Queue<EpitaphVertex>());

  ///Current edge associated with current position
  EpitaphEdge? currentEdge;

  ///Attribute to save edges for comparisons
  EpitaphEdge? _savedEdge;

  ///Signifies if current position is within an area
  bool _inArea = false;

  Point get mappedPosition => _mappedPosition;

  bool get inArea => _inArea;

  ///Saves current edge
  void saveCurrentEdge() {
    _savedEdge = currentEdge!.copy();
  }

  ///Checks if current edge equals saved edge
  bool onSavedEdge() => currentEdge!.equalToEdge(_savedEdge!);

  //  TODO (Christopher Wisse): Clean this up
  /// Sets the user position on the map to the nearest edge
  void _mapPosition([EpitaphEdge? edge]) {
    edge ??= currentEdge!;
    double scale = edge.shadowScale(finalPosition.toVector());
    _inArea = false;
    Room? currentRoom = _building.getCurrentRoom(finalPosition);

    if (currentRoom != null) {
      if (currentRoom.area.pointInArea(edge.source.point)) {
        _mappedPosition = edge.source.point;
        _inArea = true;
        return;
      } else if (currentRoom.area.pointInArea(edge.target.point)) {
        _mappedPosition = edge.target.point;
        _inArea = true;
        return;
      }
    }

    if (scale <= 0) {
      _mappedPosition = edge.source.point;
    } else if (scale >= 1) {
      _mappedPosition = edge.target.point;
    } else {
      Vector originShadow = edge.toVector() * scale;
      Vector shadow = edge.source.point.toVector() + originShadow;
      _mappedPosition = Point.vector(shadow);
    }
  }

  @override
  void initiateTrackingCycle(List<Beacon> beacons) {
    super.initiateTrackingCycle(beacons);
    currentEdge = getClosestEdge();
    _mapPosition();
    determineShortestPath(path.path.last.id);
  }

  ///Returns the closest edge (in [edges]) from [position]
  EpitaphEdge getClosestEdge([Vector? position, List<EpitaphEdge>? edges]) {
    position ??= finalPosition.toVector();
    edges ??= _graph.getAllEdges();
    Room? currentRoom = _building.getCurrentRoom(finalPosition);

    EpitaphEdge output = edges.first;
    double tmp = 0;

    for (EpitaphEdge edge in edges) {
      double shortestDistance = edge.shortestDistance(position);

      if (currentRoom?.area.pointInArea(edge.source.point) ?? false) {
        shortestDistance = 0;
      } else if (currentRoom?.area.pointInArea(edge.target.point) ?? false) {
        shortestDistance = 0;
      }

      if (shortestDistance == 0) {
        return edge;
      }

      if (tmp > shortestDistance) {
        tmp = shortestDistance;
        output = edge;
      }
    }

    return output;
  }

  ///Sets the [path] to the shortest path from [start] to [destination]
  void determineShortestPath(String destination, [String? start]) {
    path = getShortestPath(destination, start);
  }

  ///Engages Dijkstra and returns the shortest path from [start] to [destination]
  Path getShortestPath(String destination, [String? start]) {
    Path path =
        _dijkstra.solveByString(start ?? currentEdge!.source.id, destination);

    if (currentEdge != null && path.path.length > 1) {
      EpitaphVertex targetVertex = currentEdge!.target;

      if (!targetVertex.equalsById(path.path.elementAt(1))) {
        path.path.addFirst(targetVertex);
        currentEdge = _graph.getEdgeByString(
            path.path.first.id, path.path.elementAt(1).id);
      }
    }

    return path;
  }

  ///Indicates if current position is close enough to current destination
  bool closeToDestination([int pathLength = 3, double distance = 2]) {
    return path.length() == pathLength && distanceToDestination() <= distance;
  }

  /// Returns the Euclidean distance from the user's position to the final destination
  double distanceToDestination([Point? start]) {
    EpitaphVertex last = path.path.last as EpitaphVertex;
    return (start ?? _mappedPosition).distanceTo(last.point);
  }
}
