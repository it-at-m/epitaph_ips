import 'package:example/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'area_screen.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/room.dart';
import 'custom_widgets.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final List<Room> _roomList = [CustomBuilding.room1];

  _updateRoom(key, index, value) {
    setState(() {
      if (!_roomList.asMap().containsKey(index)) {
        _roomList.insert(index, CustomBuilding.room1);
      }
      if (key == 'key') {
        _roomList[index] = Room(key: value, area: _roomList[index].area);
      }
      if (key == 'area') {
        _roomList[index] = Room(key: _roomList[index].key, area: value);
      }
    });
  }

  _submit() {
    try {
      Navigator.pop(context, {'Rooms': _roomList});
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

  _addRoom() {
    setState(() {
      _roomList.add(CustomBuilding.room1);
    });
  }

  _deleteRoom(index) {
    setState(() {
      _roomList.removeAt(index);
    });
  }

  List<Widget> _roomFieldsBuilder() {
    return List.generate(_roomList.length, (index) {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(labelText: "Room Id"),
              onChanged: (value) => _updateRoom("key", index, value),
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
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    _deleteRoom(index);
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
    result.forEach((k, v) => _updateRoom(k, index, v));

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show a Message.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Data saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Building: add Rooms")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addRoom();
        },
        tooltip: "Add room",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(children: _roomFieldsBuilder()),
            const SizedBox(height: 20,),
            Row( children: [Expanded(child: ElevatedButton(
                child: const Icon(Icons.save_rounded),
                onPressed: () {
                  _submit();
                },
              )),]
            ),
          ],
        ),
      ),
    );
  }
}
