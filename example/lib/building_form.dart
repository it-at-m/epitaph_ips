import 'package:example/building_view.dart';
import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'building_screens.dart';

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
  final Map rawValues = {};

  void _updateValues(key, value) {
    setState(() {
      rawValues[key] = value;
    });
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BuildingView(rawValues: rawValues),
        ),
      );
    }
  }

  void _newScreen(BuildContext context, screen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
    result.forEach((k, v) => _updateValues(k, v));

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Location saved')));

  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    controllers.forEach((k, v) => v.addListener(()=>_updateValues(k, v.text)));
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
      appBar: AppBar(title: const Text("Building creation")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(height: 3.0),
              Column(
                children: FieldBuilder("Building", controllers).fields,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    icon: const Icon(Icons.control_point),
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
    );
  }
}
