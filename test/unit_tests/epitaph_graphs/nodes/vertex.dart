import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/vertex.dart';

class VertexTests {
  final _MockVertex testVertex = _MockVertex('test');

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all Vertex Constructor unit tests
    group("*Vertex Constructor Unit Tests*", () {
      test("Vertex constructor string name cannot be length 0 test", () {
        //Arrange
        String name = "";

        //Act and expected
        expect(() => _MockVertex(name), throwsAssertionError);
      });
      test("Vertex constructor throws no assertion test", () {
        //Arrange
        String name = "Start";

        //Act and expected
        expect(() => _MockVertex(name), isNot(throwsAssertionError));
      });
    });
    //Run all Vertex getter unit tests
    group("*Vertex getter Unit Tests*", () {
      test("get id of Vertex", () {
        //Arrange
        String expectedValue = "Start";

        //Act
        Vertex start = _MockVertex('Start');

        String retrieved = start.id;

        //expected
        expect(retrieved, expectedValue);
      });
    });
    //Run all Vertex Method unit tests
    group("*Vertex Method Unit Tests*", () {
      test("equalsById of Vertex true", () {
        //Arrange
        bool expectedValue = true;

        //Act
        Vertex pillar = _MockVertex("TechDoor");
        Vertex secondPillar = _MockVertex("TechDoor");

        bool retrieved = pillar.equalsById(secondPillar);

        //expected
        expect(retrieved, expectedValue);
      });
      test("equalsById of Vertex false", () {
        //Arrange
        bool expectedValue = false;

        //Act
        Vertex meetingDoor = _MockVertex("MeetingDoor");
        Vertex meeting = _MockVertex("Meeting");

        bool retrieved = meetingDoor.equalsById(meeting);

        //expected
        expect(retrieved, expectedValue);
      });
      test("copy test", () {
        //Arrange
        String expected = 'test';

        //Act
        _MockVertex copy = testVertex.copy() as _MockVertex;
        String id = copy.id;

        expect(id, expected);
      });
      test("equalsById with copy test", () {
        //Arrange
        bool expected = true;

        //Act
        _MockVertex copy = testVertex.copy() as _MockVertex;
        bool retrieved = testVertex.equalsById(copy);

        expect(retrieved, expected);
      });
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {'id': 'test'};

        //Act
        Map<String, dynamic> retrieved = testVertex.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString Vertex syntax test", () {
        //Arrange
        String expectedValue = 'Vertex(ID: CoDoor)';

        //Act
        Vertex coDoor = _MockVertex("CoDoor");

        String retrieved = coDoor.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}

class _MockVertex extends Vertex {
  _MockVertex(String id) : super(id);

  @override
  Vertex copy() => _MockVertex(id);

  @override
  Map<String, dynamic> toJson() => {'id': id};

  @override
  String toString() => 'Vertex(ID: $id)';
}
