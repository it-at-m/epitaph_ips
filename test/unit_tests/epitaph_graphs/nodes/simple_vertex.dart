import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';

class SimpleVertexTests {
  final SimpleVertex simpleVertex = SimpleVertex('sVertex');

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all Vertex Constructor unit tests
    group("*SimpleVertex Constructor Unit Tests*", () {
      test("SimpleVertex constructor string name cannot be length 0 test", () {
        //Arrange
        String name = "";

        //Act and expected
        expect(() => SimpleVertex(name), throwsAssertionError);
      });
      test("SimpleVertex constructor throws no assertion test", () {
        //Arrange
        String name = "Start";

        //Act and expected
        expect(() => SimpleVertex(name), isNot(throwsAssertionError));
      });
      test("SimpleVertex constructor fromJson", () {
        //Arrange
        String expName = 'sVertex';

        //Act
        SimpleVertex vertex = SimpleVertex.fromJson({'id': 'sVertex'});

        //expect
        expect(vertex.id, expName);
      });
    });
    //Run all Vertex getter unit tests
    group("*SimpleVertex getter Unit Tests*", () {
      test("get id of SimpleVertex", () {
        //Arrange
        String expectedValue = "sVertex";

        //Act
        String retrieved = simpleVertex.id;

        //expected
        expect(retrieved, expectedValue);
      });
      //Run all Vertex Method unit tests
      group("*Vertex Method Unit Tests*", () {
        test("equalName of SimpleVertex true", () {
          //Arrange
          bool expectedValue = true;

          //Act
          SimpleVertex simpleVertex2 = SimpleVertex("sVertex");

          bool retrieved = simpleVertex.equalsById(simpleVertex2);

          //expected
          expect(retrieved, expectedValue);
        });
        test("equalByID of SimpleVertex false", () {
          //Arrange
          bool expectedValue = false;

          //Act
          SimpleVertex meeting = SimpleVertex("Meeting");

          bool retrieved = simpleVertex.equalsById(meeting);

          //expected
          expect(retrieved, expectedValue);
        });
        test("copy test", () {
          //Arrange
          String expected = 'sVertex';

          //Act
          SimpleVertex copy = simpleVertex.copy() as SimpleVertex;
          String id = copy.id;

          expect(id, expected);
        });
        test("equalsById  with copy test", () {
          //Arrange
          bool expected = true;

          //Act
          SimpleVertex copy = simpleVertex.copy() as SimpleVertex;
          bool retrieved = copy.equalsById(copy);

          expect(retrieved, expected);
        });
        test("toJson test", () {
          //Arrange
          Map<String, dynamic> expectedValue = {'id': 'sVertex'};

          //Act
          Map<String, dynamic> retrieved = simpleVertex.toJson();

          //expected
          expect(retrieved, expectedValue);
        });
        test("toString test", () {
          //Arrange
          String expectedValue = 'SimpleVertex(id: sVertex)';

          //Act
          String retrieved = simpleVertex.toString();

          //expected
          expect(retrieved, expectedValue);
        });
      });
    });
  }
}
