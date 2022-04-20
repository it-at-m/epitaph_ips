import 'package:flutter/material.dart';
import 'custom_widgets.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _formKey = GlobalKey<FormState>();
  static final Map fieldsNames = CustomLabels.fieldTypes["Location"];
  final Map controllers = CustomController(fieldsNames.keys).controllers;
  final rawValues = {};

  void _updateValues(key, value) {
    setState(() {
      rawValues[key] = value;
    });
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, rawValues);
    }
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
      appBar: AppBar(title: const Text("Building: add location")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: FieldBuilder("Location", controllers).fields,
              ),
              ElevatedButton(
                onPressed: () {
                  _submit();
                },
                child: const Text('Add location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FloorScreen extends StatefulWidget {
  const FloorScreen({Key? key}) : super(key: key);

  @override
  State<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Building: add floor")),
        body: Container());
  }
}

class AreaScreen extends StatefulWidget {
  const AreaScreen({Key? key}) : super(key: key);

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Building: add area")),
        body: Container());
  }
}
