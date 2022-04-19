import 'package:example/building_view.dart';
import 'package:flutter/material.dart';
import 'mock_building.dart';
import 'custom_widgets.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';

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
  static MockBuilding mockupBuilding = MockBuilding();

  final Map controllers = CustomControllers.createControllers();
  final List formKeys = CustomControllers.getKeys();
  final List formLabels = CustomControllers.getLabels();
  final Map formKeyLabels = CustomControllers.getKeyLabels();
  final Map values = {};

  void _saveLatestValue() {
    final Map rawValues = {};
    for (var key in formKeys) {
      rawValues[key] = controllers[key].text;
    }
    final String location = WorldLocation(
        streetName: rawValues["streetName"],
        streetNumber: rawValues["streetNumber"],
        extra: rawValues["extra"])
        .toFullName();

    setState(() {
      values["Name"] = rawValues["key"];
      values["Location"] = location;
    });
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BuildingView(values: values),
        ),
      );
    }
  }

  List<Widget> _createFields() {
    List<Widget> fields = [];
    formKeyLabels.forEach((key, label) {
      fields.add(CustomField(label, controllers[key]));
    });
    return fields;
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    controllers.forEach((k, v) => v.addListener(_saveLatestValue));
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
              Column(
                children: _createFields(),
              ),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
