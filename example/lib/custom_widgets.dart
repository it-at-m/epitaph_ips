import 'package:flutter/material.dart';

class CustomPadding extends Padding {
  CustomPadding(String label, String text, {Key? key})
      : super(
          key: key,
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Row(
            children: [
              Text(label),
              const Spacer(),
              Text(
                text,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
        );
}

class CustomDivider extends Divider {
  const CustomDivider({Key? key})
      : super(
          key: key,
          color: Colors.black,
          indent: 1,
          endIndent: 1,
          thickness: 2,
        );
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });
  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}

class CustomControllers {

  //['key', 'streetName', 'streetNumber', 'extra', 'floors', 'area', 'points', 'x', 'y', 'z', floorNumber, beacons: [{id: 001, name: bc1, position: {x: 1.0, y: 1.0, z: 0.0}}, {id: 002, name: bc2, position: {x: 10.0, y: 1.0, z: 0.0}}], rooms: [{key: 01, area: {points: [{x: 1.0, y: 1.0, z: 0.0}, {x: 1.0, y: 10.0, z: 0.0}, {x: 10.0, y: 10.0, z: 0.0}, {x: 10.0, y: 1.0, z: 0.0}]}}, {key: 02, area: {points: [{x: 11.0, y: 1.0, z: 0.0}, {x: 11.0, y: 10.0, z: 0.0}, {x: 20.0, y: 20.0, z: 0.0}, {x: 20.0, y: 1.0, z: 0.0}]}}], landmarks: []}], area: {points: [{x: -1.0, y: -1.0, z: 0.0}, {x: -1.0, y: 22.0, z: 0.0}, {x: 22.0, y: 22.0, z: 0.0}, {x: 22.0, y: -1.0, z: 0.0}]}};
  static final List _formKeys = ['key', 'streetName', 'streetNumber', 'extra'];
  static final List _formLabels = [
    'Building name',
    'Street name',
    'Street number',
    'Extra Info (Postal Code, City...)'
  ];
  static final Map  _formKeyLabels = Map.fromIterables(_formKeys, _formLabels);

  static List getKeys() {
    return _formKeys;
  }
  static List getLabels() {
    return _formLabels;
  }
  static Map getKeyLabels(){
    return _formKeyLabels;
  }

  static Map createControllers() {
    Map controllers = {};
    for (var k in _formKeys) {
      controllers[k] = TextEditingController();
    }
    return controllers;
  }
}

class CustomField extends TextFormField {
  CustomField(String label, controller, {Key? key})
      : super(
          key: key,
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: label,
          ),
          validator: (value) => _validator(value),
        );

  static _validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }
}

