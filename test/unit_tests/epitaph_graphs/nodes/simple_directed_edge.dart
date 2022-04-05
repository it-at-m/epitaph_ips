import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_directed_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';

class SimpleDirectedEdgeTests {
  final SimpleVertex testVertex = SimpleVertex('test');
  final SimpleVertex testVertex2 = SimpleVertex('test2');
  late final SimpleDirectedEdge testEdge =
      SimpleDirectedEdge(testVertex, testVertex2, 99);

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all Edge Constructor unit tests
    group("*SimpleDirectedEdge Constructor Unit Tests*", () {
      test("SimpleDirectedEdge constructor throws no assertion test", () {
        //Arrange
        double weight = 1.2;

        //Act and expected
        expect(() => SimpleDirectedEdge(testVertex, testVertex2, weight),
            isNot(throwsAssertionError));
      });
      test(
          "SimpleDirectedEdge constructor negative float weight assertion test",
          () {
        //Arrange
        double weight = -4.7;

        //Act and expected
        expect(() => SimpleDirectedEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
      test("SimpleDirectedEdge constructor negative weight assertion test", () {
        //Arrange
        double weight = -3;

        //Act and expected
        expect(() => SimpleDirectedEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
    });
    //Run all Edge Method unit tests
    group("*SimpleDirectedEdge Method Unit Tests*", () {
      test("SimpleDirectedEdge equalToVertices test", () {
        //Arrange
        bool expectedValue = true;
        SimpleVertex expVertex = SimpleVertex('test');
        SimpleVertex expVertex2 = SimpleVertex('test2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("SimpleDirectedEdge not equalToVertices test", () {
        //Arrange
        bool expectedValue = false;
        SimpleVertex expVertex = SimpleVertex('tst');
        SimpleVertex expVertex2 = SimpleVertex('est2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("SimpleDirectedEdge equalToEdge test", () {
        //Arrange
        bool expectedValue = true;
        SimpleVertex testVertex = SimpleVertex('test');
        SimpleVertex testVertex2 = SimpleVertex('test2');
        SimpleDirectedEdge expEdge =
            SimpleDirectedEdge(testVertex, testVertex2, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("SimpleDirectedEdge equalToEdge test, inverted directionality", () {
        //Arrange
        bool expectedValue = false;
        SimpleVertex testVertex2 = SimpleVertex('test2');
        SimpleVertex testVertex = SimpleVertex('test');
        SimpleDirectedEdge expEdge =
            SimpleDirectedEdge(testVertex2, testVertex, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("SimpleDirectedEdge not equalToEdge test", () {
        //Arrange
        bool expectedValue = false;
        double weightA = 9.9;
        SimpleVertex testVertex = SimpleVertex('tst');
        SimpleVertex testVertex2 = SimpleVertex('est2');
        SimpleDirectedEdge expEdge =
            SimpleDirectedEdge(testVertex, testVertex2, weightA);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("copy test", () {
        //Arrange
        SimpleDirectedEdge expected = testEdge;

        //Act
        SimpleDirectedEdge actEdge = testEdge.copy() as SimpleDirectedEdge;

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
            "SimpleDirectedEdge(source: test -> target: test2, weight: 99.0)";

        //Act
        String retrieved = testEdge.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
