import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';

///Abstract class for specific filtering implementations
abstract class Filter {
  ///Filter [newPosition] and return the corresponding result
  Point filter(Point newPosition);

  ///Configure the filter with [initialPosition]
  void configFilter(Point initialPosition);

  ///Reset Filter to default settings
  void reset();
}
