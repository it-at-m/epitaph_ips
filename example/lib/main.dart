import 'package:epitaph_ips/epitaph_graphs/graphs/graph.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/tracker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epitaph Demo',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(title: 'Epitaph Demo Home Page'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/Create Building': (context) => const BuildingForm(),
        '/Create Graph': (context) => const BuildingForm(),
        '/Tracking': (context) => const BuildingForm(),
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

  _functionDemo(int i) {
    Navigator.pushNamed(context, "/${_routes[i]}");
    /*setState(() {
      _outputs[i] = _epitaphCalls[i](_outputs[i]);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _routes.length,
          itemBuilder: (BuildContext context, int index) {
            final ButtonStyle style = ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30, color: Colors.white));

            _onPressed() {
              return _functionDemo(index);
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

class BuildingForm extends StatelessWidget {
  const BuildingForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the first screen by popping the current route
            // off the stack.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
