import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/undirected_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

class UndirectedEdgeTests {
  final _MockVertex testVertex = _MockVertex('test');
  final _MockVertex testVertex2 = _MockVertex('test2');
  late final UndirectedEdge testEdge =
      UndirectedEdge(testVertex, testVertex2, 99);

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all Edge Constructor unit tests
    group("*UndirectedEdge Constructor Unit Tests*", () {
      test("UndirectedEdge constructor throws no assertion test", () {
        //Arrange
        double weight = 1.2;

        //Act and expected
        expect(() => UndirectedEdge(testVertex, testVertex2, weight),
            isNot(throwsAssertionError));
      });
      test("UndirectedEdge constructor negative float weight assertion test",
          () {
        //Arrange
        double weight = -4.7;

        //Act and expected
        expect(() => UndirectedEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
      test("UndirectedEdge constructor negative weight assertion test", () {
        //Arrange
        double weight = -3;

        //Act and expected
        expect(() => UndirectedEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
    });
    //Run all Edge Method unit tests
    group("*UndirectedEdge Method Unit Tests*", () {
      test("UndirectedEdge equalToVertices test", () {
        //Arrange
        bool expectedValue = true;
        _MockVertex expVertex = _MockVertex('test');
        _MockVertex expVertex2 = _MockVertex('test2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge not equalToVertices test", () {
        //Arrange
        bool expectedValue = false;
        _MockVertex expVertex = _MockVertex('tst');
        _MockVertex expVertex2 = _MockVertex('est2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge equalToEdge test", () {
        //Arrange
        bool expectedValue = true;
        _MockVertex testVertex = _MockVertex('test');
        _MockVertex testVertex2 = _MockVertex('test2');
        UndirectedEdge expEdge = UndirectedEdge(testVertex, testVertex2, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge equalToEdge test, inverted directionality", () {
        //Arrange
        bool expectedValue = true;
        _MockVertex testVertex2 = _MockVertex('test2');
        _MockVertex testVertex = _MockVertex('test');
        UndirectedEdge expEdge = UndirectedEdge(testVertex2, testVertex, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge not equalToEdge test", () {
        //Arrange
        bool expectedValue = false;
        double weightA = 9.9;
        _MockVertex testVertex = _MockVertex('tst');
        _MockVertex testVertex2 = _MockVertex('est2');
        UndirectedEdge expEdge =
            UndirectedEdge(testVertex, testVertex2, weightA);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("copy test", () {
        //Act
        UndirectedEdge actEdge = testEdge.copy();

        expect(actEdge.a.id, testEdge.a.id);
        expect(actEdge.b.id, testEdge.b.id);
      });
      test("reverseEdge test", () {
        //Act
        UndirectedEdge actEdge = testEdge.reversedEdge();

        expect(actEdge.a.id, testEdge.b.id);
        expect(actEdge.b.id, testEdge.a.id);
      });
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'a': {'id': 'test'},
          'b': {'id': 'test2'},
          'weight': 99.0
        };

        //Act
        Map<String, dynamic> retrieved = testEdge.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString Edge syntax test", () {
        //Arrange
        String expectedValue =
            "UndirectedEdge(a: test, b: test2, weight: 99.0)";

        //Act
        String retrieved = testEdge.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}

class _MockVertex extends Vertex {
  _MockVertex(String id) : super(id);

  @override
  Vertex copy() {
    return _MockVertex(id);
  }

  @override
  Map<String, dynamic> toJson() => {'id': id};

  @override
  String toString() => 'Vertex(ID: $id)';
}
