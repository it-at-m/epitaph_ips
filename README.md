<div id="top"></div>
<!-- PROJECT SHIELDS -->
<!-- END OF PROJECT SHIELDS -->

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="#">
    <img src="https://github.com/it-at-m/epitaph_ips/blob/main/images/logo.png?raw=true" alt="Logo" height="200">
  </a>

<h3 align="center">Epitaph IPS</h3>

  <p align="center">
    <i>Library with utilities to calculate a users position written in Dart</i>
    <br /><a href="https://github.com/it-at-m/epitaph_ips/issues/new?assignees=&labels=&template=bug_report.md&title=">Report Bug</a>
    ·
    <a href="https://github.com/it-at-m/epitaph_ips/issues/new?assignees=&labels=&template=feature_request.md&title=">Request Feature</a>
  </p>
</div>

## Table of Contents
- [About The Project](#about-the-project)
- [Usage](#usage)
- [Documentation](#documentation)
- [Contributing](#contributing)
- [Roadmap](#roadmap)
- [License](#license)
- [Contact](#contact)

<!-- ABOUT THE PROJECT -->

## About The Project

Epitaph has a wide array of utilities to position your user in a building. The project is intended to be used to only calculate the position on the user's device.
It has been written in Dart using the Flutter framework. Bluetooth Low Energy (BLE) beacons are used to make the calculations possible.
Received Signal Strength Indication (RSSI) values are used to calculate the user’s location in the real world.

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

This library has been build with:

- [Flutter](https://flutter.dev/)

<p align="right">(<a href="#top">back to top</a>)</p>

## Usage

<i>In Progress</i>

### Tracking

The tracking system consists of multiple modules that can theoretically be used individually as well.

#### Module descriptions

- **Calculator** - module for calculating a raw position through the use of read values, i.e. RSSI-values from BLE beacons
- **Filter** - module for smoothening out raw positions. This can be particularly useful when values tend to be noisy
- **Tracker** - module that uses Calculator and Filter to contininuosly track the user's position
- **Mapper** (inherits from Tracker) - module for tracking a user's position on a map (with correlating graph, nodes and edges)

#### Calculator (abstract)

- consists of `Point calculate(List<Beacon>)`
- reads certain values from said list and calculates a position using those values
- Epitaph IPS provides an implemented (nonlinear trilateration) Calculator, which uses a simple Levenberg-Marquardt algorithm

#### Filter (abstract)

- consists of `Point filter(Point)`, `void configFilter(Point)`, `void reset()`
- an implemented filter should continuously take in a point, process it and save the result for upcoming processing
- Epitaph IPS provieds an implemented filter in the form of simple unscented Kalmen filter

#### Tracker

- first calculates a raw position (using a Calculator), then filters the result (using a Filter)
- the resulting position can be processed further, if need be
- while Tracker consists of multiple methods, `void initiateTrackingCycle(List<Beacon>)` encompasses all relevant methods

#### Mapper

- inherits from Tracker
- additionally to Tracker functionality, Mapper takes the resulting position after calculation and filtering and tries to make more sense of it in context of a a map, with correlating graphs, nodes and edges
- consists of many additional methods, the most important one being an overrided `void initiateTrackingCycle(List<Beacon>)`

#### Example

```javascript
//Initialize calculator
Calculator calculator = LMA();

//Very basic models for unscented Kalman filter
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

//Sigma point function for unscented Kalman filter
SigmaPointFunction sigmaPoints = MerweFunction(4, 0.1, 2.0, 1.0);

//Initialize filter
Filter filter = SimpleUKF(4, 2, 0.3, hxUserLocation, fxUserLocation, sigmaPoints, sigmaPoints.numberOfSigmaPoints());

//Initialize tracker
Tracker tracker = Tracker(calculator, filter);

//Engage tracker by calling this method with a list with at least 3 Beacon instances
tracker.initiateTrackingCycle(...);

//The result of the tracker can be called as follows
tracker.finalPosition;

//Raw calculated position and filtered position can be called as well
tracker.calculatedPosition;
tracker.filteredPosition;

//Filter can be used independently from tracker; provide Point instance for filter method
filter.filter(...);

//Calculator can be used independently from tracker; provide a list with at least 3 Beacon instances
calculator.calculate(...);
```

## Documentation

Learn with the latest updates directly from our [Documentation.](https://pub.dev/documentation/epitaph_ips/latest/)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please open an issue with the tag "enhancement", fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Open an issue with the tag "enhancement"
2. Fork the Project
3. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
4. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the Branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

The Flutter Team has a great guide [here](https://docs.flutter.dev/get-started/install) how to set up everything needed.

We also would suggest looking into the Flutter Team's style guide [here](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)

More about this in the [CODE_OF_CONDUCT](/CODE_OF_CONDUCT.md) file.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

See the [open issues](#) for a full list of proposed features, known issues and out latest Roadmap.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE` file for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

it@m - opensource@muenchendigital.io

[join our slack channel](https://join.slack.com/t/epitaph-ips/shared_invite/zt-164oqyxvl-pNIGa9n6jA1fJZmk1h6zeg)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
