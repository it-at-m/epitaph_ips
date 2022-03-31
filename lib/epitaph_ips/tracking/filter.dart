import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';

///Abstract class for specific filtering implementations
abstract class Filter {
  ///Filter [newPosition] and return the corresponding result
  Coordinate filter(Coordinate newPosition);

  ///Configure the filter with [initialPosition]
  void configFilter(Coordinate initialPosition);

  ///Reset Filter to default settings
  void reset();
}
