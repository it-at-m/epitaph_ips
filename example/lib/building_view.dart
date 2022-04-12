import 'package:example/myWidgets.dart';
import 'package:flutter/material.dart';

class BuildingView extends StatelessWidget {
  const BuildingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(title: const Text("Building")),
      ),
      body: SafeArea(
        child: Container(
          height: 0.3 * MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(2),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyPadding("Building Name", "Test"),
                MyDivider(),
                MyPadding("Location", "Test"),
                MyDivider(),
                MyPadding("Area", "Test"),
                MyDivider(),
                MyPadding("Test", "Test"),
                MyDivider(),
                MyPadding("Test", "Test"),
                MyDivider(),
                MyPadding("Test", "Test"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
ElevatedButton(
                onPressed: () {
                  _onPressed();
                },
                child: const Text('Create building'),
                style: style,
              ),

_onPressed() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/Create Building/Building view');
    }
  }

 */