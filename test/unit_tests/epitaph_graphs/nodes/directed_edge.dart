import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

class DirectedEdgeTests {
  final _MockVertex testVertex = _MockVertex('test');
  final _MockVertex testVertex2 = _MockVertex('test2');
  late final _MockEdge testEdge = _MockEdge(testVertex, testVertex2, 99);

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all Edge Constructor unit tests
    group("*DirectedEdge Constructor Unit Tests*", () {
      test("DirectedEdge constructor throws no assertion test", () {
        //Arrange
        double weight = 1.2;

        //Act and expected
        expect(() => _MockEdge(testVertex, testVertex2, weight),
            isNot(throwsAssertionError));
      });
      test("DirectedEdge constructor negative float weight assertion test", () {
        //Arrange
        double weight = -4.7;

        //Act and expected
        expect(() => _MockEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
      test("DirectedEdge constructor negative weight assertion test", () {
        //Arrange
        double weight = -3;

        //Act and expected
        expect(() => _MockEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
    });
    //Run all Edge Method unit tests
    group("*DirectedEdge Method Unit Tests*", () {
      test("DirectedEdge equalToVertices test", () {
        //Arrange
        bool expectedValue = true;
        _MockVertex expVertex = _MockVertex('test');
        _MockVertex expVertex2 = _MockVertex('test2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("DirectedEdge not equalToVertices test", () {
        //Arrange
        bool expectedValue = false;
        _MockVertex expVertex = _MockVertex('tst');
        _MockVertex expVertex2 = _MockVertex('est2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("DirectedEdge equalToEdge test", () {
        //Arrange
        bool expectedValue = true;
        _MockVertex testVertex = _MockVertex('test');
        _MockVertex testVertex2 = _MockVertex('test2');
        _MockEdge expEdge = _MockEdge(testVertex, testVertex2, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("DirectedEdge equalToEdge test, inverted directionality", () {
        //Arrange
        bool expectedValue = false;
        _MockVertex testVertex2 = _MockVertex('test2');
        _MockVertex testVertex = _MockVertex('test');
        _MockEdge expEdge = _MockEdge(testVertex2, testVertex, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("DirectedEdge not equalToEdge test", () {
        //Arrange
        bool expectedValue = false;
        double weightA = 9.9;
        _MockVertex testVertex = _MockVertex('tst');
        _MockVertex testVertex2 = _MockVertex('est2');
        _MockEdge expEdge = _MockEdge(testVertex, testVertex2, weightA);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("copy test", () {
        //Arrange
        _MockEdge expected = testEdge;

        //Act
        _MockEdge actEdge = testEdge.copy() as _MockEdge;

        expect(actEdge, expected);
      });
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'source': {'id': 'test'},
          'target': {'id': 'test2'},
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
            "DirectedEdge(source: test -> target: test2, weight: 99.0)";

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

class _MockEdge extends DirectedEdge {
  _MockEdge(Vertex a, Vertex b, double weight) : super(a, b, weight);

  @override
  Edge copy() => this;

  @override
  Map<String, dynamic> toJson() =>
      {'source': a.toJson(), 'target': b.toJson(), 'weight': weight};
}
