import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_edge.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/epitaph_vertex.dart';
import 'package:epitaph_ips/epitaph_graphs/nodes/simple_vertex.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/coordinate.dart';
import 'package:ml_linalg/vector.dart';

class EpitaphEdgeTests {
  final EpitaphVertex testVertex = EpitaphVertex('test', Coordinate(0, 0));
  final EpitaphVertex testVertex2 = EpitaphVertex('test2', Coordinate(1, 1));
  late final EpitaphEdge testEdge = EpitaphEdge(testVertex, testVertex2, 99,
      EpitaphEdgeAttributes(isFloorChange: true), 180);

  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    //Run all EpitaphEdge Constructor unit tests
    group("*EpitaphEdge Constructor Unit Tests*", () {
      test("EpitaphEdge constructor throws no assertion test", () {
        //Arrange
        double weight = 1.2;

        //Act and expected
        expect(
            () => EpitaphEdge(testVertex, testVertex2, weight,
                EpitaphEdgeAttributes(isFloorChange: true), 180),
            isNot(throwsAssertionError));
      });
      test("EpitaphEdge constructor negative float weight assertion test", () {
        //Arrange
        double weight = -4.7;

        //Act and expected
        expect(
            () => EpitaphEdge(testVertex, testVertex2, weight,
                EpitaphEdgeAttributes(isFloorChange: true), 180),
            throwsAssertionError);
      });
      test("EpitaphEdge constructor negative weight assertion test", () {
        //Arrange
        double weight = -3;

        //Act and expected
        expect(
            () => EpitaphEdge(testVertex, testVertex2, weight,
                EpitaphEdgeAttributes(isFloorChange: true), 180),
            throwsAssertionError);
      });
      test("EpitaphEdge constructor cardinal dir < 0 assertion error", () {
        //Arrange
        double cardinal = -4.7;

        //Act and expected
        expect(
            () => EpitaphEdge(testVertex, testVertex2, 9.0,
                EpitaphEdgeAttributes(isFloorChange: true), cardinal),
            throwsAssertionError);
      });
      test("EpitaphEdge constructor cardinal dir > 360 assertion error", () {
        //Arrange
        double cardinal = 9001;

        //Act and expected
        expect(
            () => EpitaphEdge(testVertex, testVertex2, 9.0,
                EpitaphEdgeAttributes(isFloorChange: true), cardinal),
            throwsAssertionError);
      });
    });
    //Run all EpitaphEdgeAttributes Constructor unit tests
    group("*EpitaphEdgeAttributes Constructor Unit Tests*", () {
      test("EpitaphEdgeAttributes constructor default", () {
        //Arrange
        bool expected = false;

        //Act and expected
        EpitaphEdgeAttributes attr = EpitaphEdgeAttributes();
        expect(attr.isFloorChange, expected);
      });
      test("EpitaphEdgeAttributes constructor not default", () {
        //Arrange
        bool expected = true;

        //Act and expected
        EpitaphEdgeAttributes attr = EpitaphEdgeAttributes(isFloorChange: true);
        expect(attr.isFloorChange, expected);
      });
    });
    //Run all EpitaphEdge Method unit tests
    group("*EpitaphEdge Method Unit Tests*", () {
      test("EpitaphEdge equalToVertices test", () {
        //Arrange
        bool expectedValue = true;
        SimpleVertex expVertex = SimpleVertex('test');
        SimpleVertex expVertex2 = SimpleVertex('test2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("EpitaphEdge not equalToVertices test", () {
        //Arrange
        bool expectedValue = false;
        SimpleVertex expVertex = SimpleVertex('tst');
        SimpleVertex expVertex2 = SimpleVertex('est2');

        //Act
        bool retrieved = testEdge.equalToVertices(expVertex, expVertex2);

        //expected
        expect(retrieved, expectedValue);
      });
      test("EpitaphEdge equalToEdge test", () {
        //Arrange
        bool expectedValue = true;
        EpitaphVertex testVertex = EpitaphVertex('test', Coordinate(0, 0));
        EpitaphVertex testVertex2 = EpitaphVertex('test2', Coordinate(0, 0));
        EpitaphEdge expEdge = EpitaphEdge(testVertex, testVertex2, 99,
            EpitaphEdgeAttributes(isFloorChange: true), 180);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("EpitaphEdge equalToEdge test, inverted directionality", () {
        //Arrange
        bool expectedValue = false;
        EpitaphVertex testVertex2 = EpitaphVertex('test2', Coordinate(0, 0));
        EpitaphVertex testVertex = EpitaphVertex('test', Coordinate(0, 0));
        EpitaphEdge expEdge = EpitaphEdge(testVertex2, testVertex, 99,
            EpitaphEdgeAttributes(isFloorChange: true), 180);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test("EpitaphEdge not equalToEdge test", () {
        //Arrange
        bool expectedValue = false;
        double weightA = 9.9;
        EpitaphVertex testVertex = EpitaphVertex('tst', Coordinate(0, 0));
        EpitaphVertex testVertex2 = EpitaphVertex('est2', Coordinate(1, 1));
        EpitaphEdge expEdge = EpitaphEdge(testVertex, testVertex2, weightA,
            EpitaphEdgeAttributes(isFloorChange: true), 180);

        //Act
        bool retrieved = testEdge.equalToEdge(expEdge);

        //expected
        expect(retrieved, expectedValue);
      });
      test('shortestDistance test', () {
        //Arrange
        double expectedValue = 0.7071067811865476;

        //expected
        expect(testEdge.shortestDistance(Coordinate(.5, -0.5).toVector()),
            expectedValue);
      });
      test('vectorFromPosition test', () {
        //Arrange
        Vector expectedValue = Coordinate(-0.5, 0.5).toVector();

        //expected
        expect(testEdge.vectorFromPosition(Coordinate(.5, -0.5).toVector()),
            expectedValue);
      });
      test('shadowScale test', () {
        //Arrange
        double expectedValue = 0.000009499030348695355;

        //expected
        expect(testEdge.shadowScale(Coordinate(-0.053847, 0.146947).toVector()),
            expectedValue);
      });
      test('headingTowardsTarget test true', () {
        //Arrange
        bool expectedValue = true;
        double heading = 3;

        //Act
        EpitaphEdge edge = EpitaphEdge(
            testVertex, testVertex2, 3.0, EpitaphEdgeAttributes(), heading);

        //expected
        expect(edge.headingTowardsTarget(.34234), expectedValue);
      });
      test('headingTowardsTarget test false', () {
        //Arrange
        bool expectedValue = false;

        double heading = .5;

        //Act
        EpitaphEdge edge = EpitaphEdge(
            testVertex, testVertex2, 3.0, EpitaphEdgeAttributes(), heading);

        //expected
        expect(edge.headingTowardsTarget(190), expectedValue);
      });
      test("toVector test", () {
        //Arrange
        Vector expected = Vector.fromList([1.0, 1.0, 0]);

        //expected
        expect(testEdge.toVector(), expected);
      });
      test("copy test", () {
        //Arrange
        EpitaphEdge expected = testEdge;

        //Act
        EpitaphEdge actEdge = testEdge.copy();

        expect(actEdge, expected);
      });
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {
          'source': {
            'id': 'test',
            'coordinate': {'x': 0.0, 'y': 0.0, 'z': 0.0}
          },
          'target': {
            'id': 'test2',
            'coordinate': {'x': 1.0, 'y': 1.0, 'z': 0.0}
          },
          'weight': 99.0,
          'cardinalDir': 180.0,
          'attributes': {'isFloorChange': true}
        };

        //Act
        Map<String, dynamic> retrieved = testEdge.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString Edge syntax test", () {
        //Arrange
        String expectedValue =
            "EpitaphEdge(source: test -> target: test2, weight: 99.0, cardinalDir: 180.0, attributes: EpitaphEdgeAttributes(isFloorChange: true))";

        //Act
        String retrieved = testEdge.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
    group("*EpitaphEdgeAttributes Method Unit Tests*", () {
      EpitaphEdgeAttributes attributes = EpitaphEdgeAttributes();
      test("toJson test", () {
        //Arrange
        Map<String, dynamic> expectedValue = {'isFloorChange': false};

        //Act
        Map<String, dynamic> retrieved = attributes.toJson();

        //expected
        expect(retrieved, expectedValue);
      });
      test("toString Edge syntax test", () {
        //Arrange
        String expectedValue = "EpitaphEdgeAttributes(isFloorChange: false)";

        //Act
        String retrieved = attributes.toString();

        //expected
        expect(retrieved, expectedValue);
      });
    });
  }
}
