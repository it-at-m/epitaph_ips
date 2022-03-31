import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/calculator.dart';
import 'package:ml_linalg/linalg.dart';
import 'filter.dart';

///This class manages the position of the user.
class Tracker {
  Tracker(this._calculator, this._filter);

  double _accuracy = 2;
  int _counter = 0;
  Coordinate _calculatedPosition = Coordinate.origin();
  Coordinate _filteredPosition = Coordinate.origin();
  Coordinate _finalPosition = Coordinate.origin();
  Coordinate _prevFinal = Coordinate.origin();
  Coordinate _comparison = Coordinate.origin();
  final Calculator _calculator;
  final Filter _filter;

  double get accuracy => _accuracy;

  Coordinate get calculatedPosition => _calculatedPosition;

  Coordinate get filteredPosition => _filteredPosition;

  Coordinate get finalPosition => _finalPosition;

  /// Resets the members of this class to their original value.
  void reset() {
    _filter.reset();
    _accuracy = 2.0;
    _calculatedPosition = Coordinate.origin();
    _filteredPosition = Coordinate.origin();
    _prevFinal = Coordinate.origin();
    _finalPosition = Coordinate.origin();
  }

  /// calling this engages the positioning system
  void initiateTrackingCycle(List<Beacon> beacons) {
    _calculatedPosition = calculatePosition(beacons);
    _filteredPosition = filterPosition();
    _calculateAccuracy();
    _smartTrack();
  }

  void initiateFirstScan(List<Beacon> beacons) {
    _calculatedPosition = calculatePosition(beacons);
    _filter.configFilter(_calculatedPosition);
    _filteredPosition = _calculatedPosition.copy();
    _finalPosition = _calculatedPosition.copy();
    _prevFinal = _calculatedPosition.copy();
  }

  ///Calculates the user's position using a list of known coordinates
  Coordinate calculatePosition(List<Beacon> beacons) {
    return _calculator.calculate(beacons);
  }

  ///Filter calculated position
  Coordinate filterPosition([Coordinate? position]) {
    position = position ?? _calculatedPosition;
    return _filter.filter(position);
  }

  void _smartTrack() {
    double distance = _filteredPosition.distanceTo(_prevFinal);

    if (distance > _accuracy) {
      Vector vector = (_filteredPosition - _prevFinal).toVector();
      _finalPosition = Coordinate.vector(_prevFinal.toVector() + vector * 0.5);
    } else {
      _finalPosition = _prevFinal.copy();
    }

    _prevFinal = _finalPosition.copy();
  }

  void _calculateAccuracy() {
    if (_counter < 4) {
      if (_counter == 0) {
        _comparison = _calculatedPosition.copy();
      }

      _counter++;
    } else {
      double newAccuracy = _comparison.distanceTo(_calculatedPosition);

      if (newAccuracy < 2) {
        _accuracy = 2;
      } else if (newAccuracy > 2.5) {
        _accuracy = 2.5;
      }

      _counter = 0;
    }
  }
}
