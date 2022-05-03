import 'package:example/building_view.dart';
import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'location_screen.dart';
import 'area_screen.dart';
import 'floor_screen.dart';

// Define a custom Form widget.
class BuildingForm extends StatefulWidget {
  const BuildingForm({Key? key}) : super(key: key);

  @override
  BuildingFormState createState() {
    return BuildingFormState();
  }
}

class BuildingFormState extends State<BuildingForm> {
  final _formKey = GlobalKey<FormState>();

  static final Map fieldsNames = CustomLabels.fieldTypes["Building"];
  final Map controllers = CustomController(fieldsNames.keys).controllers;
  final Map buildingValues = {};

  void _updateValues(key, value) {
    setState(() {
      buildingValues[key] = value;
    });
  }

  _submit() {
    try {
      if (_formKey.currentState!.validate()) {
        final Map building = CustomBuilding(values: buildingValues).toJson();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuildingView(building: building),
          ),
        );
      }
    } catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("$e"),
              content: Text(buildingValues.toString()),
            );
          });
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
  void initState() {
    super.initState();

    // Start listening to changes.
    controllers
        .forEach((k, v) => v.addListener(() => _updateValues(k, v.text)));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllers.forEach((k, v) => v.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Building creation")),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Divider(height: 3.0),
              Column(
                children: FieldBuilder("Building", controllers).fields,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    label: const Text("Add location"),
                    icon: const Icon(Icons.location_on_outlined),
                    onPressed: () {
                      _newScreen(context, const LocationScreen());
                    },
                  ),
                  ElevatedButton.icon(
                    label: const Text('Add Floor'),
                    icon: const Icon(Icons.map_outlined),
                    onPressed: () {
                      _newScreen(context, const FloorScreen());
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
                child: const Text('Create Building'),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
