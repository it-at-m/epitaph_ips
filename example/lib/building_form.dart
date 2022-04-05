import 'mock_building.dart';
import 'package:flutter/material.dart';


/* _functionDemo(int i) {

  setState(() {
      _outputs[i] = _epitaphCalls[i](_outputs[i]);
    });
}*/

final ButtonStyle style = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 30, color: Colors.white));


class BuildingForm extends StatelessWidget {
  const BuildingForm({Key? key}) : super(key: key);

  _onPressed(){
    debugPrint(createBuilding().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Building creation'),
      ),
      body: Center(
        child: Column(children: [
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
          ),
        ]),
      ),
    );
  }
}
