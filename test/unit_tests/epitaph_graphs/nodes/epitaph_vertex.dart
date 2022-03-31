import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_vertex.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';

class EpitaphVertexTests {
  final EpitaphVertex epitaphVertex =
      EpitaphVertex('eVertex', Coordinate(1, 1));

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all Vertex Constructor unit tests
    group("*EpitaphVertex Constructor Unit Tests*", () {
      test("constructor string name cannot be length 0 test", () {
        //Arrange
        String name = "";
        Coordinate coordinate = Coordinate(0, 0);

        //Act and expected
        expect(() => EpitaphVertex(name, coordinate), throwsAssertionError);
      });
      test("constructor throws no assertion test", () {
        //Arrange
        String name = "eVertex";
        Coordinate coordinate = Coordinate(0, 0);

        //Act and expected
        expect(
            () => EpitaphVertex(name, coordinate), isNot(throwsAssertionError));
      });
      test("constructor fromJson", () {
        //Arrange
        String expName = 'eVertex';
        Coordinate expCoordinate = Coordinate(0, 0);

        //Act
        EpitaphVertex vertex = EpitaphVertex.fromJson({
          'id': 'eVertex',
          'coordinate': {'x': 0.0, 'y': 0.0, 'z': 0.0}
        });

        //expect
        expect(vertex.id, expName);
        expect(vertex.coordinate.toString(), expCoordinate.toString());
      });
    });
    //Run all Vertex getter unit tests
    group("*EpitaphVertex getter Unit Tests*", () {
      test("get id of EpitaphVertex", () {
        //Arrange
        String expectedValue = "eVertex";

        //Act
        String retrieved = epitaphVertex.id;

        //expected
        expect(retrieved, expectedValue);
      });
      test("get coordinate of EpitaphVertex", () {
        //Arrange
        String expectedValue = 'Coordinate(x: 1.0, y: 1.0, z: 0.0)';

        //Act
        String retrieved = epitaphVertex.coordinate.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
    //Run all Vertex Method unit tests
    group("*EpitaphVertex Method Unit Tests*", () {
      test("equalName of EpitaphVertex true", () {
        //Arrange
        bool expectedValue = true;

        //Act
        EpitaphVertex epiVertex2 =
            EpitaphVertex("eVertex", Coordinate.origin());

        bool retrieved = epitaphVertex.equalsById(epiVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("equalByID of EpitaphVertex false", () {
        //Arrange
        bool expectedValue = false;

        //Act
        EpitaphVertex meeting = EpitaphVertex("Meeting", Coordinate.origin());

        bool retrieved = epitaphVertex.equalsById(meeting);

        //expected
        expect(retrieved, expectedValue);
      });
      test("copy test", () {
        //Arrange
        String expected = 'eVertex';

        //Act
        EpitaphVertex copy = epitaphVertex.copy() as EpitaphVertex;
        String id = copy.id;

        expect(id, expected);
      });
      test("equalsById  with copy test", () {
        //Arrange
        bool expected = true;

        //Act
        EpitaphVertex copy = epitaphVertex.copy() as EpitaphVertex;
        bool retrieved = copy.equalsById(copy);

        expect(retrieved, expected);
      });
      test("distanceTo test", () {
        //Arrange
        double expected = 1.4142135623730951;

        //Act
        EpitaphVertex other = EpitaphVertex("other", Coordinate(2, 2));
        double retrieved = epitaphVertex.distanceTo(other);

        //expected
        expect(retrieved, expected);
      });
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'id': 'eVertex',
          'coordinate': {'x': 1.0, 'y': 1.0, 'z': 0.0}
        };

        //Act
        Map<String, dynamic> retrieved = epitaphVertex.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString test", () {
        //Arrange
        String expectedValue =
            'EpitaphVertex(id: eVertex, coordinate: Coordinate(x: 1.0, y: 1.0, z: 0.0))';

        //Act
        String retrieved = epitaphVertex.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
