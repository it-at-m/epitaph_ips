import 'package:flutter_test/flutter_test.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/merwe_function.dart';
import 'package:epitaph_ips/epitaph_ips/tracking/simple_ukf.dart';
import 'package:ml_linalg/linalg.dart';

class SimpleUKFTests {
  Future<void> runTests() async {
    setUpAll(() {});
    tearDownAll(() {});

    group("*SimpleUKFTest Method Unit Tests*", () {
      test("predict", () {
        //Arrange
        Matrix expectedX = Matrix.fromList([
          [11.00006103515625, 3.0, 10.99993896484375, 3.0]
        ]);

        Matrix expectedP = Matrix.fromList([
          [11.000001907348633, 3.000000476837158, -1.4959368854761124e-8, 0.0],
          [3.000000476837158, 2.000000476837158, 0.0, 0.0],
          [-1.4959368854761124e-8, 0.0, 11.000000953674316, 3.000000476837158],
          [0.0, 0.0, 3.000000476837158, 2.000000476837158]
        ]);

        int dimX = 4, dimZ = 2;
        double dt = 3;

        List arg = [11];

        //act
        MerweFunction points = MerweFunction(4, 0.1, 2.0, -1);
        SimpleUKF filter = SimpleUKF(dimX, dimZ, dt, hxUserLocation,
            fxUserLocation, points, points.numberOfSigmaPoints());

        filter.x = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0],
        ]);

        filter.predict(args: arg);

        //expect
        expect(filter.x, expectedX);
        expect(filter.p, expectedP);
      });
      test("update", () {
        //Arrange
        Matrix expectedX = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0]
        ]);

        Matrix expectedP = Matrix.fromList([
          [1.0, 0.0, 0.0, 0.0],
          [0.0, 1.0, 0.0, 0.0],
          [0.0, 0.0, 1.0, 0.0],
          [0.0, 0.0, 0.0, 1.0]
        ]);

        int dimX = 4, dimZ = 2;
        double dt = 3;

        List arg = [11];

        //act
        MerweFunction points = MerweFunction(4, 0.1, 2.0, -1);

        SimpleUKF filter = SimpleUKF(dimX, dimZ, dt, hxUserLocation,
            fxUserLocation, points, points.numberOfSigmaPoints());

        filter.x = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0],
        ]);

        filter.update(null, args: arg);

        //expect
        expect(filter.x, expectedX);
        expect(filter.p, expectedP);
      });

      test("unscentedTransform", () {
        //Arrange
        Matrix expectedX = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0]
        ]);

        Matrix expectedP = Matrix.fromList([
          [1.0, 0.0, 0.0, 0.0],
          [0.0, 1.0, 0.0, 0.0],
          [0.0, 0.0, 1.0, 0.0],
          [0.0, 0.0, 0.0, 1.0]
        ]);

        List expectedValue = [
          Matrix.fromList([
            [11.00006103515625, 3.0, 10.99993896484375, 3.0]
          ]),
          Matrix.fromList([
            [
              11.000001907348633,
              3.000000476837158,
              -1.4959368854761124e-8,
              0.0
            ],
            [3.000000476837158, 2.000000476837158, 0.0, 0.0],
            [
              -1.4959368854761124e-8,
              0.0,
              11.000000953674316,
              3.000000476837158
            ],
            [0.0, 0.0, 3.000000476837158, 2.000000476837158]
          ])
        ];

        int dimX = 4, dimZ = 2;
        double dt = 3;

        //act
        MerweFunction points = MerweFunction(4, 0.1, 2.0, -1);

        SimpleUKF filter = SimpleUKF(dimX, dimZ, dt, hxUserLocation,
            fxUserLocation, points, points.numberOfSigmaPoints());

        filter.x = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0],
        ]);

        Matrix sigmas = Matrix.fromList([
          [11.0, 3.0, 11.0, 3.0],
          [11.173205375671387, 3.0, 11.0, 3.0],
          [11.519615173339844, 3.1732051372528076, 11.0, 3.0],
          [11.0, 3.0, 11.173205375671387, 3.0],
          [11.0, 3.0, 11.519615173339844, 3.1732051372528076],
          [10.826794624328613, 3.0, 11.0, 3.0],
          [10.480384826660156, 2.8267948627471924, 11.0, 3.0],
          [11.0, 3.0, 10.826794624328613, 3.0],
          [11.0, 3.0, 10.480384826660156, 2.8267948627471924]
        ]);

        Matrix weightsM = Matrix.fromList([
          [
            -132.3333282470703,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379
          ],
        ]);

        Matrix weightsC = Matrix.fromList([
          [
            -129.3433380126953,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379
          ],
        ]);

        Matrix noise = Matrix.fromList([
          [1.0, 0.0, 0.0, 0.0],
          [0.0, 1.0, 0.0, 0.0],
          [0.0, 0.0, 1.0, 0.0],
          [0.0, 0.0, 0.0, 1.0],
        ]);

        List retrievedValue = filter
            .unscentedTransform(sigmas, weightsM, weightsC, noiseCov: noise);

        //expect
        expect(filter.x, expectedX);
        expect(filter.p, expectedP);
        expect(retrievedValue, expectedValue);
      });
      test("simple unscentedTransform", () {
        //Arrange
        Matrix expectedX = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0]
        ]);

        Matrix expectedP = Matrix.fromList([
          [1.0, 0.0, 0.0, 0.0],
          [0.0, 1.0, 0.0, 0.0],
          [0.0, 0.0, 1.0, 0.0],
          [0.0, 0.0, 0.0, 1.0]
        ]);

        List expectedValue = [
          Matrix.fromList([
            [-164.66665649414062, -247.0, -905.6666259765625, -247.0]
          ]),
          Matrix.fromList([
            [-2203980.5, -3305972.5, -12121898.0, -3305972.5],
            [-3305972.5, -4958957.5, -18182848.0, -4958958.5],
            [-12121898.0, -18182848.0, -66670436.0, -18182848.0],
            [-3305972.5, -4958958.5, -18182848.0, -4958957.5]
          ])
        ];

        int dimX = 4, dimZ = 2;
        double dt = 3;

        //act
        MerweFunction points = MerweFunction(4, 0.1, 2.0, -1);

        SimpleUKF filter = SimpleUKF(dimX, dimZ, dt, hxUserLocation,
            fxUserLocation, points, points.numberOfSigmaPoints());

        filter.x = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0],
        ]);

        Matrix sigmas = Matrix.fromList([
          [2, 3.0, 11.0, 3.0],
          [2, 3.0, 11.0, 3.0],
          [2, 3.0, 11.0, 3.0],
          [2, 3.0, 11.0, 3.0],
        ]);

        Matrix weightsM = Matrix.fromList([
          [
            -132.3333282470703,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379
          ],
        ]);

        Matrix weightsC = Matrix.fromList([
          [
            -129.3433380126953,
            16.66666603088379,
            16.66666603088379,
            16.66666603088379
          ],
        ]);

        Matrix noise = Matrix.fromList([
          [1.0, 0.0, 0.0, 0.0],
          [0.0, 1.0, 0.0, 0.0],
          [0.0, 0.0, 1.0, 0.0],
          [0.0, 0.0, 0.0, 1.0],
        ]);

        List retrievedValue = filter
            .unscentedTransform(sigmas, weightsM, weightsC, noiseCov: noise);

        //expect
        expect(filter.x, expectedX);
        expect(filter.p, expectedP);
        expect(retrievedValue, expectedValue);
      });
      test("computeProcessSigmas", () {
        //Arrange
        Matrix expectedX = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0]
        ]);

        Matrix expectedP = Matrix.fromList([
          [1.0, 0.0, 0.0, 0.0],
          [0.0, 1.0, 0.0, 0.0],
          [0.0, 0.0, 1.0, 0.0],
          [0.0, 0.0, 0.0, 1.0]
        ]);

        int dimX = 4, dimZ = 2;
        double dt = 3;

        List arg = [11];

        //act
        MerweFunction points = MerweFunction(4, 0.1, 2.0, -1);

        SimpleUKF filter = SimpleUKF(dimX, dimZ, dt, hxUserLocation,
            fxUserLocation, points, points.numberOfSigmaPoints());

        filter.x = Matrix.fromList([
          [2.0, 3.0, 2.0, 3.0],
        ]);

        filter.computeProcessSigmas(dt, arg);

        //expect
        expect(filter.x, expectedX);
        expect(filter.p, expectedP);
      });
      group('*calculateQWhiteNoise*', () {
        test("throws matrix dimension assertion test", () {
          //Arrange
          int dimX = 4;
          int dimZ = 2;
          double dt = 3;
          MerweFunction points = MerweFunction(4, 0.1, 2.0, -1);
          SimpleUKF filter = SimpleUKF(dimX, dimZ, dt, hxUserLocation,
              fxUserLocation, points, points.numberOfSigmaPoints());

          filter.x = Matrix.fromList([
            [2.0, 3.0, 2.0, 3.0],
          ]);

          //act and expect
          expect(() => filter.calculateQWhiteNoise(1, dt, 0.03, 1, true),
              throwsAssertionError);
        });

        test("no assertion", () {
          //Arrange
          Matrix expected = Matrix.fromList([
            [0.6074999570846558, 0.4050000011920929],
            [0.4050000011920929, 0.26999998092651367]
          ]);

          int dimX = 4;
          int dimZ = 2;
          double dt = 3;
          MerweFunction points = MerweFunction(4, 0.1, 2.0, -1);
          SimpleUKF filter = SimpleUKF(dimX, dimZ, dt, hxUserLocation,
              fxUserLocation, points, points.numberOfSigmaPoints());

          filter.x = Matrix.fromList([
            [2.0, 3.0, 2.0, 3.0],
          ]);

          //act
          Matrix received = filter.calculateQWhiteNoise(2, dt, 0.03, 1, true);

          //expect
          expect(received, expected);
        });
      });
    });
  }
}

Matrix fxUserLocation(Matrix x, double dt, List? args) {
  List<double> list = [
    x[1][0] * dt + x[0][0],
    x[1][0],
    x[3][0] * dt + x[2][0],
    x[3][0]
  ];
  return Matrix.fromFlattenedList(list, 4, 1);
}

Matrix hxUserLocation(Matrix x, List? args) {
  return Matrix.row([x[0][0], x[0][2]]);
}

Matrix fxBeacon(Matrix x, double dt, List? args) {
  List<double> outputList = [];
  outputList.add(x[1][0] * dt + x[0][0]);
  outputList.add(x[1][0]);
  return Matrix.fromFlattenedList(outputList, 2, 1);
}

Matrix hxBeacon(Matrix x, List? args) => Matrix.scalar(x[0][0], 1);
