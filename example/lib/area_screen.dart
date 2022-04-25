import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({Key? key}) : super(key: key);

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  final Map<int, dynamic> coord = {
    0: {"x": 0.0, "y": 0.0},
    1: {"x": 0.0, "y": 0.0},
    2: {"x": 0.0, "y": 0.0},
    3: {"x": 0.0, "y": 0.0}
  };

  _updatePoint(axis, index, value) {
    setState(() {
      coord[index][axis] = value;
    });
  }

  _submit() {
    try {
      final List<Point> points = [];
      coord.forEach((key, value) {
        points.add(Point(value['x'], value['y']));
      });
      PolygonalArea area = PolygonalArea(points: points);
      Navigator.pop(context, {'area': area});
    } catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("$e"),
              title: Text(coord.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Building: add area")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(4, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: CustomSpinBox(
                        axis: "x$index",
                        onChanged: (value) => _updatePoint("x", index, value),
                      ),
                    ),
                    Expanded(
                      child: CustomSpinBox(
                        axis: "y$index",
                        onChanged: (value) => _updatePoint("y", index, value),
                      ),
                    )
                  ],
                );
              }),
            ),
            ElevatedButton(
              onPressed: () {
                _submit();
              },
              child: const Text('Add Area'),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSpinBox extends SpinBox {
  CustomSpinBox({Key? key, required String axis, required onChanged})
      : super(
          key: key,
          min: 0.0,
          value: 0.0,
          decimals: 1,
          step: 0.1,
          acceleration: 0.1,
          decoration: InputDecoration(labelText: axis),
          onChanged: onChanged,
        );
}
