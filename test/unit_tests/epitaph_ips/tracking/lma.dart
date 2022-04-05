import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/lma.dart';

class LMATests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group('*LMATests Constructor Unit Tests*', () {
      test('invalid _initialLambda', () {
        //Arrange, act and expected
        expect(() => LMA(initialLambda: -1), throwsAssertionError);
      });

      test('invalid _maxIterations', () {
        //Arrange, act and expected
        expect(() => LMA(maxIterations: 0), throwsAssertionError);
      });

      test('invalid _ftol', () {
        //Arrange, act and expected
        expect(() => LMA(ftol: -1), throwsAssertionError);
      });

      test('invalid _gtol', () {
        //Arrange, act and expected
        expect(() => LMA(gtol: -1), throwsAssertionError);
      });

      test('no assertion errors', () {
        //Arrange
        double initialLambda = 1;
        int maxIterations = 100;
        double ftol = 1e-12;
        double gtol = 1e-12;
        LMA expected = LMA();

        //Act
        LMA received = LMA(
            initialLambda: initialLambda,
            maxIterations: maxIterations,
            ftol: ftol,
            gtol: gtol);

        //Expected
        expect(received.maxIterations, expected.maxIterations);
        expect(received.ftol, expected.ftol);
        expect(received.gtol, expected.gtol);
        expect(received.initialLambda, expected.initialLambda);
        expect(received.initialCost, expected.initialCost);
        expect(received.finalCost, expected.finalCost);
        expect(received.gradient, expected.gradient);
        expect(received.hessian, expected.hessian);
        expect(received.negativeStep, expected.negativeStep);
        expect(received.residuals, expected.residuals);
        expect(received.jacobian, expected.jacobian);
      });
    });

    group('*LMATests Method Unit Tests*', () {
      test('reset', () {
        //Arrange
        LMA received =
            LMA(initialLambda: 117, maxIterations: 117, ftol: 117, gtol: 117);
        LMA expected = LMA();

        //Act
        received.reset();

        //Expected
        expect(received.initialCost, expected.initialCost);
        expect(received.finalCost, expected.finalCost);
        expect(received.gradient, expected.gradient);
        expect(received.hessian, expected.hessian);
        expect(received.jacobian, expected.jacobian);
        expect(received.negativeStep, expected.negativeStep);
        expect(received.residuals, expected.residuals);
      });
    });
  }
}
