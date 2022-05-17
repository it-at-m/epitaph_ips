import 'package:example/beacon_screen.dart';
import 'package:example/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'area_screen.dart';
import 'room_screen.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/floor.dart';
import 'custom_widgets.dart';

class FloorScreen extends StatefulWidget {
  const FloorScreen({Key? key}) : super(key: key);

  @override
  State<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  // final _formKey = GlobalKey<FormState>();
  final List<Floor> _floorList = [CustomBuilding.floor];

  _updateFloor(key, index, value) {
    setState(() {
      if (!_floorList.asMap().containsKey(index)) {
        _floorList.insert(index, CustomBuilding.floor);
      }
      if (key == 'floorNumber') {
        _floorList[index] = Floor(
            floorNumber: value,
            area: _floorList[index].area,
            rooms: _floorList[index].rooms,
            beacons: _floorList[index].beacons);
      }
      if (key == 'area') {
        _floorList[index] = Floor(
            floorNumber: _floorList[index].floorNumber,
            area: value,
            rooms: _floorList[index].rooms,
            beacons: _floorList[index].beacons);
      }
      if (key == 'rooms') {
        _floorList[index] = Floor(
            floorNumber: _floorList[index].floorNumber,
            area: _floorList[index].area,
            rooms: value,
            beacons: _floorList[index].beacons);
      }
      if (key == 'beacons') {
        _floorList[index] = Floor(
            floorNumber: _floorList[index].floorNumber,
            area: _floorList[index].area,
            rooms: _floorList[index].rooms,
            beacons: value);
      }
    });
  }

  _submit() {
    try {
      Navigator.pop(context, {'floors': _floorList});
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

  _addFloor() {
    setState(() {
      _floorList.add(CustomBuilding.floor);
    });
  }

  _deleteFloor(index) {
    setState(() {
      _floorList.removeAt(index);
    });
  }

  List<Widget> _floorFieldsBuilder() {
    return List.generate(_floorList.length, (index) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Floor Nr"),
              onChanged: (value) => _updateFloor("floorNumber", index, value),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                    icon: Icon(Icons.square_foot_rounded),
                    iconSize: 45,
                    onPressed: () {
                      _newScreen(context, index, const AreaScreen());
                    }),
                const Text('Add Area')
              ],
            ),
          ),
          Expanded(
            child: Column(children: [
              IconButton(
                icon: const Icon(Icons.meeting_room_rounded),
                iconSize: 45,
                onPressed: () {
                  _newScreen(context, index, const RoomScreen());
                },
              ),
              Text("Add Rooms")
            ]),
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                  iconSize: 45,
                  icon: const Icon(Icons.bluetooth_searching_outlined),
                  onPressed: () {
                    _newScreen(context, index, const BeaconScreen());
                  },
                ),
                const Text('Beacons'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    _deleteFloor(index);
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

  void _newScreen(BuildContext context, index, screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    result.forEach((k, v) => _updateFloor(k, index, v));

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show a Message.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Data saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Building: add floors")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addFloor();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(children: _floorFieldsBuilder()),
            ElevatedButton.icon(
              onPressed: () {
                _submit();
              },
              label: const Text('Save floors'),
              icon: const Icon(Icons.save_outlined),
            )
          ],
        ),
      ),
    );
  }
}
