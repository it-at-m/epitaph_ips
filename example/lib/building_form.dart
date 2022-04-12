import 'package:flutter/material.dart';
import 'mock_building.dart';
import 'myWidgets.dart';

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

  final Map controllers = MyControllers.createControllers();
  final List formKeys = MyControllers.getKeys();
  final List formLabels = MyControllers.getLabels();
  final Map formKeyLabels = MyControllers.getKeyLabels();

  Item panel = Item(
    headerValue: 'Building',
    expandedValue: const Text(""),
  );

  void _saveLatestValue() {
    final List<Widget> children = [];
    final buildingView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
    for (var key in formKeys) {
      children.add(MyPadding(key, controllers[key].text));
      children.add(MyDivider());
    }
    panel.expandedValue = buildingView;
  }

  List<Widget> _createFields() {
    List<Widget> fields = [];
    formKeyLabels.forEach((key, label) {
      fields.add(MyField(label, controllers[key]));
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
              ExpansionPanelList(
                expansionCallback: (int i, bool isExpanded) {
                  setState(() {
                    panel.isExpanded = !isExpanded;
                  });
                },
                children: <ExpansionPanel>[
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(title: Text(panel.headerValue));
                    },
                    body: panel.expandedValue,
                    isExpanded: panel.isExpanded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
