import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_undirected_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';

class SimpleUndirectedEdgeTests {
  final SimpleVertex testVertex = SimpleVertex('test');
  final SimpleVertex testVertex2 = SimpleVertex('test2');
  late final SimpleUndirectedEdge testEdge =
      SimpleUndirectedEdge(testVertex, testVertex2, 99);

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all Edge Constructor unit tests
    group("*SimpleUndirectedEdge Constructor Unit Tests*", () {
      test("SimpleUndirectedEdge constructor throws no assertion test", () {
        //Arrange
        double weight = 1.2;

        //Act and expected
        expect(() => SimpleUndirectedEdge(testVertex, testVertex2, weight),
            isNot(throwsAssertionError));
      });
      test(
          "SimpleUndirectedEdge constructor negative float weight assertion test",
          () {
        //Arrange
        double weight = -4.7;

        //Act and expected
        expect(() => SimpleUndirectedEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
      test("SimpleUndirectedEdge constructor negative weight assertion test",
          () {
        //Arrange
        double weight = -3;

        //Act and expected
        expect(() => SimpleUndirectedEdge(testVertex, testVertex2, weight),
            throwsAssertionError);
      });
    });
    //Run all Edge Method unit tests
    group("*UndirectedEdge Method Unit Tests*", () {
      test("UndirectedEdge equalToVertices test", () {
        //Arrange
        bool expectedValue = true;
        SimpleVertex expVertex = SimpleVertex('test');
        SimpleVertex expVertex2 = SimpleVertex('test2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge not equalToVertices test", () {
        //Arrange
        bool expectedValue = false;
        SimpleVertex expVertex = SimpleVertex('tst');
        SimpleVertex expVertex2 = SimpleVertex('est2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge equalToEdge test", () {
        //Arrange
        bool expectedValue = true;
        SimpleVertex testVertex = SimpleVertex('test');
        SimpleVertex testVertex2 = SimpleVertex('test2');
        SimpleUndirectedEdge expEdge =
            SimpleUndirectedEdge(testVertex, testVertex2, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge equalToEdge test, inverted directionality", () {
        //Arrange
        bool expectedValue = true;
        SimpleVertex testVertex2 = SimpleVertex('test2');
        SimpleVertex testVertex = SimpleVertex('test');
        SimpleUndirectedEdge expEdge =
            SimpleUndirectedEdge(testVertex2, testVertex, 99);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("UndirectedEdge not equalToEdge test", () {
        //Arrange
        bool expectedValue = false;
        double weightA = 9.9;
        SimpleVertex testVertex = SimpleVertex('tst');
        SimpleVertex testVertex2 = SimpleVertex('est2');
        SimpleUndirectedEdge expEdge =
            SimpleUndirectedEdge(testVertex, testVertex2, weightA);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("copy test", () {
        //Act
        SimpleUndirectedEdge actEdge = testEdge.copy();

        expect(actEdge.a.id, testEdge.a.id);
        expect(actEdge.b.id, testEdge.b.id);
      });
      test("reverseEdge test", () {
        //Act
        SimpleUndirectedEdge actEdge = testEdge.reversedEdge();

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
