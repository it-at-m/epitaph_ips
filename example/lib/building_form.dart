import 'package:example/building_view.dart';
import 'myWidgets.dart';
import 'mock_building.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:flutter/material.dart';
import 'ui_constants.dart';

    //const TextStyle(fontSize: 30, color: Colors.white));

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
  static Building mockupBuilding = createBuilding();
  final buildingName = TextEditingController(text: mockupBuilding.key);
  final location =
      TextEditingController(text: mockupBuilding.location.toFullName());

  _onPressed() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      showDialog(
        context: context,
        builder: (context) {
          return const BuildingView();
          //AlertDialog(
          //content: Text("Name: ${buildingName.text}\nLocation ${location.text}"),);
        },
      );
    }
  }

  _validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    buildingName.dispose();
    location.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: TextStyleConstants.buttonTextBold(context));

    return Scaffold(
      appBar: MyAppBar("Building creation", context),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: buildingName,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Building name',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) => _validator(value),
            ),
            TextFormField(
              controller: location,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) => _validator(value),
            ),
            ElevatedButton(
              onPressed: () {
                _onPressed();
              },
              child: const Text('Create'),
              style: style,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
