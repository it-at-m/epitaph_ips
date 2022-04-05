///This class houses a location in the real world. A [streetName] and [streetNumber] need to be provided.
class WorldLocation {
  WorldLocation(
      {required this.streetName, required this.streetNumber, this.extra});

  factory WorldLocation.fromJson(Map<String, dynamic> json) {
    return WorldLocation(
        streetName: json['streetName'],
        streetNumber: json['streetNumber'],
        extra: json['extra']);
  }

  final String streetName;
  final int streetNumber;
  final String? extra;

  Map<String, dynamic> toJson() =>
      {'streetName': streetName, 'streetNumber': streetNumber, 'extra': extra};

  /// Returns a human readable name.
  String toFullName() {
    if (extra != null) {
      return '$streetName $streetNumber$extra';
    } else {
      return '$streetName $streetNumber';
    }
  }

  @override
  String toString() =>
      'WorldLocation(streetName: $streetName, streetNumber: $streetNumber, extra: $extra)';
}
