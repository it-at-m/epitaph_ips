import 'package:flutter/material.dart';
import 'custom_widgets.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/world_location.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _formKey = GlobalKey<FormState>();
  static final Map fieldsNames = CustomLabels.fieldTypes["Location"];
  final Map controllers = CustomController(fieldsNames.keys).controllers;
  final worldLocationValues = {};

  void _updateValues(key, value) {
    setState(() {
      worldLocationValues[key] = value;
    });
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      WorldLocation location = WorldLocation(
          streetName: worldLocationValues['streetName'],
          streetNumber: int.parse(worldLocationValues["streetNumber"]),
          extra: worldLocationValues['extra']);
      Navigator.pop(context, {"location": location});
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
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Form(
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
      ),
    );
  }
}
