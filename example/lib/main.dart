import 'package:example/building_view.dart';
import 'package:flutter/material.dart';
import 'building_form.dart';
import 'mock_building.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epitaph Demo',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Epitaph Demo Home Page'),
        '/Create Building': (context) => const BuildingForm(),
        '/Create Graph': (context) => const BuildingForm(),
        '/Tracking': (context) => const BuildingForm(),
        '/Create Building/Building view': (context) => const BuildingView()

      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _routes = <String>[
    "Create Building",
    "Create Graph",
    "Tracking"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Epitaph Demo")),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _routes.length,
          itemBuilder: (BuildContext context, int index) {
            final ButtonStyle style = ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30, color: Colors.white));

            _onPressed() {
              Navigator.pushNamed(context, "/${_routes[index]}");
            }

            return ElevatedButton(
              onPressed: _onPressed,
              style: style,
              child: Text(_routes[index]),
            );
          }),
    );
  }
}
