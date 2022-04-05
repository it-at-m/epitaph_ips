import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';

///Abstract class for implementations that calculate an unknown position from at least one known coordinate
abstract class Calculator {
  Coordinate calculate(List<Beacon> beacons);
}
