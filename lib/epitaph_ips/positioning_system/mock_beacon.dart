import 'dart:math';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';

/// A beacon simulating how beacons would work in the real world. Can be used for
/// testing purposes. Use [sendRssiAdvertisement] to have the beacon send a value
/// in relation to its position and a given position. The returned value is a randomized
/// value trying to emulate real BLE beacons.
class MockBeacon extends Beacon {
  MockBeacon(String id, String name, Point position,
      {BeaconsConfiguration configuration = const BeaconsConfiguration()})
      : super(
            id: id,
            name: name,
            position: position,
            configuration: configuration);

  MockBeacon.fromJson(Map<String, dynamic> json)
      : super(
            id: json['id'],
            name: json['name'],
            position: Point.fromJson(json['position']));

  /// Determines a random value with noise that is sent for this advertisement cycle. Updates RSSI with [rssiUpdate] of the super class automatically.
  /// [PointForAd] is a assumed position of the devices that the end user is using.
  /// The ad is calculated with this position in mind.
  void sendRssiAdvertisement(Point pointForAd) {
    double calcRssi =
        _metersToRSSI(position.toVector().distanceTo(pointForAd.toVector()));
    int deviation = _rssiDeviation(calcRssi.toInt());
    int finalRssi = calcRssi.toInt() - deviation;
    super.rssiUpdate(finalRssi);
  }

  /// Reverse calculates from a meter value to the needed RSSI value.
  double _metersToRSSI(double meter) {
    return -((log(meter) / log(10)) * 10 * environmentalFactor - measuredPower);
  }

  final Map<Map<int, int>, Map<int, int>> _rssiDeviationModel =
      Map.unmodifiable({
    {0: -40}: {-1: 1},
    {-40: -70}: {-3: 3},
    {-70: -80}: {-5: 5},
    {-80: -90}: {-10: 10},
    {-90: -100}: {-20: 20},
  });

  /// Calculates random noise for a certain rssi value and adds it to the RSSI.
  int _rssiDeviation(int rssi) {
    assert(rssi < 0, 'A value of rssi cannot be greater than 0');

    Map<int, int> possibleDeviations = {};
    int deviation;

    for (Map<int, int> key in _rssiDeviationModel.keys) {
      if (_Range(rssi).isBetweenInclusive(key.values.first, key.keys.first)) {
        possibleDeviations = _rssiDeviationModel[key]!;
        break;
      }
    }

    deviation = _calculateRandomRssiNoise(
        possibleDeviations.keys.first, possibleDeviations.values.first);

    return deviation;
  }

  ///  Returns randomized noise in a certain range.
  int _calculateRandomRssiNoise(int from, int to) {
    int noise;
    Random rnd = Random();
    noise = rnd.nextIntInRange(from, to);

    return noise;
  }

  @override
  Beacon copy() => this;

  @override
  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'position': position.toJson()};
}

// two quick extension to make the code above a little cleaner
extension _Range on num {
  ///  A check if a number is in a range between two numbers. The range is inclusive of the given numbers.
  bool isBetweenInclusive(num from, num to) {
    return from <= this && this <= to;
  }
}

extension _RandomInRange on Random {
  /// Random number in a range between to numbers.
  int nextIntInRange(int from, int to) {
    int dist = (to - from).abs();
    int rn = nextInt(dist);
    int nmb = rn - from.abs();
    return nmb;
  }
}
