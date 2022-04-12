import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';

///Abstract class for implementations that calculate an unknown position from at least one known Point
abstract class Calculator {
  Point calculate(List<Beacon> beacons);
}
