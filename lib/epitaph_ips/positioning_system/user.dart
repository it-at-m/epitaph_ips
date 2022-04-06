import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';

/// Representation of a to be located entity. Their current [position] [location] and [cardinalDir] can be saved.
class User {
  User({this.position, this.location, cardinalDir = 0.0})
      : assert(cardinalDir >= 0 && cardinalDir <= 360,
            "Cardinality can only be between 0 and 360"),
        _cardinalDir = cardinalDir;

  Point? position;
  double _cardinalDir = 0;
  WorldLocation? location;

  double get cardinalDir => _cardinalDir;

  set cardinalDir(double cardinalDir) {
    assert(cardinalDir >= 0 && cardinalDir <= 360,
        "Cardinality can only be between 0 and 360");
    _cardinalDir = cardinalDir;
  }

  @override
  String toString() =>
      'User(position: $position, cardinalDir: $cardinalDir, location: $location)';
}
