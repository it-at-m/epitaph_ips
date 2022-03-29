import 'package:epitaph_ips/epitaph_ips.dart';
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
      home: const MyHomePage(title: 'Epitaph Demo Home Page'),
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


  final List<String> _epitaphAPI = <String>["Add one", "Add two", "Add three"];
  final List _epitaphCalls = [Calculator().addOne, Calculator().addTwo, Calculator().addThree];
  final List _outputs = [0, 0, 0];

  void _doNothing(){
    // stub
  }

  _incrementCounter(int i) {
    setState(() {
      _outputs[i] = _epitaphCalls[i](_outputs[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _outputs.length,
          itemBuilder: (BuildContext context, int index) {
            final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 30, color: Colors.white));
            return ElevatedButton(
              onPressed: () => _incrementCounter(index),
              style: style,
              child: Text("Test ${_epitaphAPI[index]}: " + _outputs[index].toString()),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _doNothing,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
