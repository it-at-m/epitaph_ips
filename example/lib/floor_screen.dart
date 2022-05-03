import 'package:flutter/material.dart';
import 'area_screen.dart';
import 'room_screen.dart';

class FloorScreen extends StatefulWidget {
  const FloorScreen({Key? key}) : super(key: key);

  @override
  State<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  final _formKey = GlobalKey<FormState>();
  final floorValues = {};

  void _updateValues(key, value) {
    setState(() {
      floorValues[key] = value;
    });
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, floorValues);
    }
  }

  void _newScreen(BuildContext context, screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    result.forEach((k, v) => _updateValues(k, v));

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show a Message.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Data saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Building: add floor")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    label: const Text('Add Room'),
                    icon: const Icon(Icons.meeting_room_outlined),
                    onPressed: () {
                      _newScreen(context, const RoomScreen());
                    },
                  ),
                  ElevatedButton.icon(
                    label: const Text('Add Area'),
                    icon: const Icon(Icons.square_foot_outlined),
                    onPressed: () {
                      _newScreen(context, const AreaScreen());
                    },
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: const Text('Create and save floor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
