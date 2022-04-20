import 'package:flutter/material.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/floor.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';

class CustomPadding extends Padding {
  CustomPadding(String label, String text, {Key? key})
      : super(
          key: key,
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Row(
            children: [
              Text(label),
              const Spacer(),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
        );
}

class CustomDivider extends Divider {
  const CustomDivider({Key? key})
      : super(
          key: key,
          color: Colors.black,
          indent: 1,
          endIndent: 1,
          thickness: 2,
        );
}

class CustomField extends TextFormField {
  CustomField(label, controller, {Key? key, required this.fieldKey})
      : super(
          key: key,
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
          validator: (value) => _validator(fieldKey, value),
        );
  final String fieldKey;

  static _validator(fieldKey, value) {
    switch (fieldKey) {
      case 'streetNumber':
        try {
          int.parse(value);
        } on FormatException {
          return 'Please enter numeric value';
        }
        break;
      default:
        break;
    }
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}

class FieldBuilder {
  final List<Widget> fields = [];
  FieldBuilder(String type, controllers) {
    CustomLabels.fieldTypes[type].forEach((key, label) {
      fields.add(CustomField(label, controllers[key], fieldKey: key));
    });
  }
}

class CustomController {
  final Map controllers = {};
  CustomController(keys) {
    for (var k in keys) {
      controllers[k] = TextEditingController();
    }
  }
}

class CustomLabels {
  static final Map fieldTypes = {
    "Building": _building,
    "Location": _location,
  };
  static final Map _building = {
    'key': 'Building name',
  };
  static final Map _location = {
    'streetName': 'Street name',
    'streetNumber': 'Street number',
    'extra': 'Extra Info (Postal Code, City...)'
  };
}

class CustomBuilding extends Building {
  CustomBuilding({Key? key, required this.values})
      : super(
            key: values["key"],
            location: WorldLocation(
                streetName: values['streetName'],// values["streetName"]
                streetNumber: values['streetNumber'], // int.parse(values["streetNumber"]),
                extra: values['extra']), // values["extra"]),
            floors: stages,
            area: buildingArea);

  final Map values;

  @override
  Map<String, dynamic> toJson() {
    List<dynamic> floorList = [];
    for (var element in floors) {
      floorList.add(element.toJson());
    }

    return {
      'Name': key,
      'Address': location.toFullName(),
    };
  }

  static MockBeacon bc1 = MockBeacon("001", "bc1", Point(1, 1));
  static MockBeacon bc2 = MockBeacon("002", "bc2", Point(10, 1));
  static List<MockBeacon> beacons = [bc1, bc2];
  static List<Point> roomPoints1 = [
    Point(1, 1),
    Point(1, 10),
    Point(10, 10),
    Point(10, 1)
  ];
  static List<Point> roomPoints2 = [
    Point(11, 1),
    Point(11, 10),
    Point(20, 20),
    Point(20, 1)
  ];
  static List<Point> floorPoints = [
    Point(0, 0),
    Point(0, 21),
    Point(21, 21),
    Point(21, 0)
  ];
  static List<Point> buildingPoints = [
    Point(-1, -1),
    Point(-1, 22),
    Point(22, 22),
    Point(22, -1)
  ];

  static PolygonalArea roomArea1 = PolygonalArea(points: roomPoints1);
  static PolygonalArea roomArea2 = PolygonalArea(points: roomPoints2);
  static PolygonalArea floorArea = PolygonalArea(points: floorPoints);
  static PolygonalArea buildingArea = PolygonalArea(points: buildingPoints);

  static Room room1 = Room(key: "01", area: roomArea1);
  static Room room2 = Room(key: "02", area: roomArea2);
  static List<Room> rooms = [room1, room2];
  static List<Floor> stages = [
    Floor(area: floorArea, floorNumber: 0, beacons: beacons, rooms: rooms)
  ];
}