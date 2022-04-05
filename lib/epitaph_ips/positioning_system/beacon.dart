import 'dart:math';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';

/// [Beacon] serves as a representation for a BLE-Beacon in the world.
abstract class Beacon {
  Beacon(
      {required this.id,
      required this.name,
      required this.position,
      this.configuration = const BeaconsConfiguration()})
      : assert(id.isNotEmpty, "Beacon id cannot be empty."),
        assert(name.isNotEmpty, "Beacon name cannot be empty.");

  /// [id] is the UUID of the beacon. Mostly used to determine which beacon is sending the signals.
  final String id;

  /// Name of the beacon determined by producer.
  final String name;

  /// [position] is the Location of the Beacon in the world mapped to a cartesian coordinate system.
  final Coordinate position;

  final BeaconsConfiguration configuration;

  ///Received Signal Strength Indication (RSSI)
  double _rssi = double.negativeInfinity;

  ///Distance in Meters
  double _distanceToUser = double.infinity;

  double get distanceToUser => _distanceToUser;

  double get rssi => _rssi;

  int get measuredPower => configuration.measuredPower;

  int get environmentalFactor => configuration.environmentalFactor;

  double get interval => configuration.advertisementInterval;

  double get intervalInMilliseconds =>
      configuration.advertisementInterval * 1000;

  double get x => position.x;

  double get y => position.y;

  /// Checks if [rssi] has been changed
  bool get isModified => _rssi != double.negativeInfinity;

  /// updated the [rssi] value stored in the class. RSSI stands for Received Signal Strength Indication.
  void rssiUpdate(int input) {
    assert(input < 0, "RSSI cannot be greater than zero");
    _rssi = input.toDouble();
    double distance = _rssiToMeters(_rssi);

    _distanceToUser = distance;
  }

  /// Calculates the distance in m from user to beacon with its [rssi] value
  double _rssiToMeters(double rssi) {
    return pow(10, (measuredPower - rssi) / (10 * environmentalFactor))
        as double;
  }

  /// Similar to [toString], but in List<double> form so it can be easily logged
  List<double> getXYDistanceRSSI() => [x, y, _distanceToUser, rssi.toDouble()];

  /// This method resets this class' members.
  void reset() {
    _rssi = double.negativeInfinity;
    _distanceToUser = double.infinity;
  }

  Beacon copy();

  Map<String, dynamic> toJson();

  @override
  String toString() =>
      'Beacon(id: $id, name: $name, position: $position, rssi: $_rssi, distanceToUser: $_distanceToUser)';
}

/// A standard configuration class for beacons, with needed constant values.
class BeaconsConfiguration {
  const BeaconsConfiguration(
      {this.measuredPower = -57,
      this.environmentalFactor = 2,
      this.advertisementInterval = 0.3})
      : assert(measuredPower < 0, 'measuredPower cannot be greater than 0'),
        assert(environmentalFactor >= 2,
            'environmentalFactor cannot be less than 2'),
        assert(advertisementInterval >= 0.1,
            'advertisementInterval cannot be less than 0.1');

  /// The higher the number, the more obstructive the environment is towards
  /// Bluetooth signals
  final int measuredPower;

  /// RSSI reading at 1 meter distance
  final int environmentalFactor;

  /// update frequency of the beacons in seconds
  final double advertisementInterval;
}
