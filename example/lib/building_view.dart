import 'custom_widgets.dart';
import 'package:flutter/material.dart';

class BuildingView extends StatelessWidget {
  const BuildingView({Key? key, required this.values}) : super(key: key);
  final Map values;

  List<Widget> _get_values(){
    final List<Widget> children = [];
    for (var key in values.keys) {
      children.add(CustomPadding(key, values[key]));
      children.add(const CustomDivider());
    }
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
              children: _get_values(),
            ),
          ),
        ),
      ),
    );
  }
}