import 'dart:collection';
import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/path_finding/path.dart';

class PathTests {
  final Queue<_MockVertex> _v = Queue.from(
      [_MockVertex('test'), _MockVertex('test2'), _MockVertex('test3')]);
  late final Path path = Path(_v);

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group("*Path getter Unit Tests*", () {
      test("get path", () {
        //Arrange
        Queue<_MockVertex> expectedValue = Queue.from(
            [_MockVertex('test'), _MockVertex('test2'), _MockVertex('test3')]);

        //Act
        Queue<_MockVertex> retrieved = path.path as Queue<_MockVertex>;

        //expected
        expect(retrieved.elementAt(0).id, expectedValue.elementAt(0).id);
        expect(retrieved.elementAt(1).id, expectedValue.elementAt(1).id);
        expect(retrieved.elementAt(2).id, expectedValue.elementAt(2).id);
      });
    });
    group("*Path method Unit Tests*", () {
      test("toString", () {
        //Arrange
        String expected =
            'Path({Vertex(ID: test), Vertex(ID: test2), Vertex(ID: test3)})';

        //Act
        String retrieved = path.toString();

        //expected
        expect(retrieved, expected);
      });
    });
  }
}

class _MockVertex extends Vertex {
  _MockVertex(String id) : super(id);

  @override
  Vertex copy() => this;

  @override
  Map<String, dynamic> toJson() => {'id': id};

  @override
  String toString() => 'Vertex(ID: $id)';
}
