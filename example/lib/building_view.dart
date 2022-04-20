import 'custom_widgets.dart';
import 'package:flutter/material.dart';

class BuildingView extends StatefulWidget {
  const BuildingView({Key? key, required this.rawValues}) : super(key: key);
  final Map rawValues;

  @override
  State<BuildingView> createState() => _BuildingViewState();
}

class _BuildingViewState extends State<BuildingView> {
  List<Widget> getValues() {
    final List<Widget> children = [];
    final Map values = CustomBuilding(values: widget.rawValues).toJson();
    setState(() {
      for (var key in values.keys) {
        children.add(CustomPadding(key, values[key]));
        children.add(const CustomDivider());
      }
    });

    return children;
  }

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
              children: getValues(),
            ),
          ),
        ),
      ),
    );
  }
}