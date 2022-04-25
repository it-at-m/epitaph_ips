import 'custom_widgets.dart';
import 'package:flutter/material.dart';

class BuildingView extends StatefulWidget {
  const BuildingView({Key? key, required this.building}) : super(key: key);
  final Map building;

  @override
  State<BuildingView> createState() => _BuildingViewState();
}

class _BuildingViewState extends State<BuildingView> {
  List<Widget> getValues() {
    final List<Widget> children = [];
    final Map values = widget.building;
    setState(() {
      for (var key in values.keys) {
        children.add(CustomRow(key, values[key]));
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
      body: SingleChildScrollView(
        child: Column(
          children: getValues(),
        ),
      ),
    );
  }
}
