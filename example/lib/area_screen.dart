import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/polygonal_area.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({Key? key}) : super(key: key);

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  //final List<Point> _points = [Point(0,0)];
  final Map _coord = {};
  int _i = 1;

  _updatePoint(axis, index, value) {
    setState(() {
      if (!_coord.containsKey(index)) {
        _coord[index] = Point(0, 0);
      }
      if (axis == 'x') {
        _coord[index] = Point(value, _coord[index].y);
      }
    });
  }

  _submit() {
    try {
      final List<Point> points = [];
      _coord.forEach((key, value) {
        points.add(value);
      });
      PolygonalArea area = PolygonalArea(points: points);
      Navigator.pop(context, {'area': area});
    } catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("$e"),
              title: Text(_coord.toString()),
            );
          });
    }
  }

  _addPointField() {
    setState(() {
      _i++;
    });
  }

  _deletePointField() {
    setState(() {});
  }

  List<Widget> _pointFieldsBuilder() {
    return List.generate(_i, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomSpinBox(
              axis: Text("x($index)"),
              onChanged: (value) => _updatePoint("x", index, value),
            ),
          ),
          Expanded(
            child: CustomSpinBox(
              axis: Text("y($index)"),
              onChanged: (value) => _updatePoint("y", index, value),
            ),
          ),
          IconButton(
            onPressed: _deletePointField(),
            icon: const Icon(Icons.delete),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Building: add area")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Column(children: _pointFieldsBuilder()),
            ElevatedButton.icon(
              icon: const Icon(Icons.control_point_outlined),
              onPressed: () {
                _addPointField();
              },
              label: const Text('Add Point'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _submit();
              },
              label: const Text('Create and save area'),
              icon: const Icon(Icons.save_outlined),
            )
          ],
        ),
      ),
    );
  }
}

/*
 0: {"x": 0.0, "y": 0.0},
    1: {"x": 0.0, "y": 0.0},
    2: {"x": 0.0, "y": 0.0},
    3: {"x": 0.0, "y": 0.0}
 */
