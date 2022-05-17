import 'package:example/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/point.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/beacon.dart';
import 'package:epitaph_ips/epitaph_ips/positioning_system/mock_beacon.dart';
import 'custom_widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class BeaconScreen extends StatefulWidget {
  const BeaconScreen({Key? key}) : super(key: key);

  @override
  State<BeaconScreen> createState() => _BeaconScreenState();
}

class _BeaconScreenState extends State<BeaconScreen> {
  final List<Beacon> _beaconList = [CustomBuilding.bc1];

  _updateBeacon(key, index, value) {
    setState(() {
      if (!_beaconList.asMap().containsKey(index)) {
        _beaconList.insert(index, CustomBuilding.bc1);
      }
      if (key == 'id') {
        _beaconList[index] = MockBeacon(
            value, _beaconList[index].name, _beaconList[index].position);
      }
      if (key == 'name') {
        _beaconList[index] = MockBeacon(
            _beaconList[index].id, value, _beaconList[index].position);
      }
      if (key == 'position_x') {
        _beaconList[index] =
            MockBeacon(_beaconList[index].id, _beaconList[index].name, Point(value, _beaconList[index].position.y));
      }
      if (key == 'position_y') {
        _beaconList[index] =
            MockBeacon(_beaconList[index].id, _beaconList[index].name, Point(_beaconList[index].position.x, value));
      }
    });
  }

  _submit() {
    try {
      Navigator.pop(context, {'Beacons': _beaconList});
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

  _addMockBeacon() {
    setState(() {
      _beaconList.add(CustomBuilding.bc1);
    });
  }

  _deleteMockBeacon(index) {
    setState(() {
      _beaconList.removeAt(index);
    });
  }

  List<Widget> _beaconFieldsBuilder() {
    return List.generate(_beaconList.length, (index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(labelText: "UUID"),
              onChanged: (value) => _updateBeacon("id", index, value),
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(labelText: "Name"),
              onChanged: (value) => _updateBeacon("name", index, value),
            ),
          ),
          Expanded(
            child: CustomSpinBox(
              axis: Text("Pos_x"),
              value: _beaconList[index].position.x,
              onChanged: (value) => _updateBeacon("position_x", index, value),
            ),
          ),
          Expanded(
            child: CustomSpinBox(
              axis: Text("Pos_y"),
              value: _beaconList[index].position.y,
              onChanged: (value) => _updateBeacon("position_y", index, value),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    _deleteMockBeacon(index);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Building: add Beacons")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addMockBeacon();
        },
        tooltip: "Add Mockbeacon",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(children: _beaconFieldsBuilder()),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              Expanded(
                  child: ElevatedButton(
                child: const Icon(Icons.save_rounded),
                onPressed: () {
                  _submit();
                },
              )),
            ]),
          ],
        ),
      ),
    );
  }
}
