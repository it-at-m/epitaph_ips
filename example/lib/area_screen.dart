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
  final List<Point> _points = [Point(0, 0)];

  _updatePoint(axis, index, value) {
    setState(() {
      if (!_points.asMap().containsKey(index)) {
        _points.insert(index, Point(0, 0));
      }
      if (axis == 'x') {
        _points[index] = Point(value, _points[index].y);
      }
      if (axis == 'y') {
        _points[index] = Point(_points[index].x, value);
      }
    });
  }

  _submit() {
    try {
      PolygonalArea area = PolygonalArea(points: _points);
      Navigator.pop(context, {'area': area});
    } catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("$e"),
              title: const Text("Something went wrong..."),
            );
          });
    }
  }

  _addPointField() {
    setState(() {
      _points.add(Point(0, 0));
    });
  }

  _deletePointField(index) {
    setState(() {
      _points.removeAt(index);
    });
  }

  List<Widget> _pointFieldsBuilder() {
    return List.generate(_points.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomSpinBox(
              axis: Text("x($index)"),
              value: _points[index].x,
              onChanged: (value) => _updatePoint("x", index, value),
            ),
          ),
          Expanded(
            child: CustomSpinBox(
              axis: Text("y($index)"),
              value: _points[index].y,
              onChanged: (value) => _updatePoint("y", index, value),
            ),
          ),
          IconButton(
            onPressed: () {
              _deletePointField(index);
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Building: add area")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addPointField();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Column(children: _pointFieldsBuilder()),
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
