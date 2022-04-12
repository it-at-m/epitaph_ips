//Run all application tests
import 'package:flutter_test/flutter_test.dart';
import 'unit_tests/epitaph_graphs/graphs/directed_graph.dart';
import 'unit_tests/epitaph_graphs/graphs/epitaph_graph.dart';
import 'unit_tests/epitaph_graphs/graphs/graph.dart';
import 'unit_tests/epitaph_graphs/graphs/undirected_graph.dart';
import 'unit_tests/epitaph_graphs/nodes/directed_edge.dart';
import 'unit_tests/epitaph_graphs/nodes/epitaph_edge.dart';
import 'unit_tests/epitaph_graphs/nodes/epitaph_vertex.dart';
import 'unit_tests/epitaph_graphs/nodes/simple_undirected_edge.dart';
import 'unit_tests/epitaph_graphs/nodes/simple_directed_edge.dart';
import 'unit_tests/epitaph_graphs/nodes/simple_vertex.dart';
import 'unit_tests/epitaph_graphs/nodes/undirected_edge.dart';
import 'unit_tests/epitaph_graphs/path_finding/dijkstra.dart';
import 'unit_tests/epitaph_graphs/path_finding/path.dart';
import 'unit_tests/epitaph_graphs/nodes/edge.dart';
import 'unit_tests/epitaph_graphs/nodes/vertex.dart';
import 'unit_tests/epitaph_ips/buildings/area.dart';
import 'unit_tests/epitaph_ips/buildings/building.dart';
import 'unit_tests/epitaph_ips/buildings/circular_area.dart';
import 'unit_tests/epitaph_ips/buildings/point.dart';
import 'unit_tests/epitaph_ips/buildings/floor.dart';
import 'unit_tests/epitaph_ips/buildings/landmark.dart';
import 'unit_tests/epitaph_ips/buildings/polygonal_area.dart';
import 'unit_tests/epitaph_ips/buildings/room.dart';
import 'unit_tests/epitaph_ips/buildings/world_location.dart';
import 'unit_tests/epitaph_ips/positioning_system/beacon.dart';
import 'unit_tests/epitaph_ips/positioning_system/mock_beacon.dart';
import 'unit_tests/epitaph_ips/positioning_system/real_beacon.dart';
import 'unit_tests/epitaph_ips/positioning_system/user.dart';
import 'unit_tests/epitaph_ips/tracking/filter.dart';
import 'unit_tests/epitaph_ips/tracking/lma.dart';
import 'unit_tests/epitaph_ips/tracking/lma_function.dart';
import 'unit_tests/epitaph_ips/tracking/mapper.dart';
import 'unit_tests/epitaph_ips/tracking/matrix_helpers.dart';
import 'unit_tests/epitaph_ips/tracking/multilateration_function.dart';
import 'unit_tests/epitaph_ips/tracking/sigma_point_function.dart';
import 'unit_tests/epitaph_ips/tracking/simple_ukf.dart';
import 'unit_tests/epitaph_ips/tracking/tracker.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  VertexTests vertexTests = VertexTests();
  vertexTests.runTests();

  SimpleVertexTests simpleVertexTests = SimpleVertexTests();
  simpleVertexTests.runTests();

  EpitaphVertexTests epitaphVertexTests = EpitaphVertexTests();
  epitaphVertexTests.runTests();

  EdgeTests edgeTests = EdgeTests();
  edgeTests.runTests();

  UndirectedEdgeTests undirectedEdgeTests = UndirectedEdgeTests();
  undirectedEdgeTests.runTests();

  SimpleUndirectedEdgeTests simpleUndirectedEdgeTests =
      SimpleUndirectedEdgeTests();
  simpleUndirectedEdgeTests.runTests();

  DirectedEdgeTests directedEdgeTests = DirectedEdgeTests();
  directedEdgeTests.runTests();

  SimpleDirectedEdgeTests simpleDirectedEdgeTests = SimpleDirectedEdgeTests();
  simpleDirectedEdgeTests.runTests();

  EpitaphEdgeTests epitaphEdgeTests = EpitaphEdgeTests();
  epitaphEdgeTests.runTests();

  GraphTests graphTests = GraphTests();
  graphTests.runTests();

  DirectedGraphTests directedGraphTests = DirectedGraphTests();
  directedGraphTests.runTests();

  EpitaphGraphTests epitaphGraphTests = EpitaphGraphTests();
  epitaphGraphTests.runTests();

  UndirectedGraphTests undirectedGraphTests = UndirectedGraphTests();
  undirectedGraphTests.runTests();

  PointTests pointTest = PointTests();
  pointTest.runTests();

  WorldLocationTests worldLocationTests = WorldLocationTests();
  worldLocationTests.runTests();

  LandmarkTests landmarkTests = LandmarkTests();
  landmarkTests.runTests();

  RoomTests roomTests = RoomTests();
  roomTests.runTests();

  AreaTests areaTests = AreaTests();
  areaTests.runTests();

  PolygonalAreaTests polygonalAreaTests = PolygonalAreaTests();
  polygonalAreaTests.runTests();

  CircularAreaTests circularAreaTests = CircularAreaTests();
  circularAreaTests.runTests();

  PathTests pathTests = PathTests();
  pathTests.runTests();

  DijkstraTests dijkstraTests = DijkstraTests();
  dijkstraTests.runTests();

  FilterTests filterTests = FilterTests();
  filterTests.runTests();

  SimpleUKFTests ukfTests = SimpleUKFTests();
  ukfTests.runTests();

  LMAFunctionTests lmaFunctionTests = LMAFunctionTests();
  lmaFunctionTests.runTests();

  MatrixHelpersTest matrixHelpersTest = MatrixHelpersTest();
  matrixHelpersTest.runTests();

  SigmaPointFunctionTests sigmaPointFunctionTests = SigmaPointFunctionTests();
  sigmaPointFunctionTests.runTests();

  TrackerTests trackerTests = TrackerTests();
  trackerTests.runTests();

  MapperTests mapperTests = MapperTests();
  mapperTests.runTests();

  MultilaterationFunctionTests multilaterationFunctionTests =
      MultilaterationFunctionTests();
  multilaterationFunctionTests.runTests();

  LMATests lmaTests = LMATests();
  lmaTests.runTests();

  MatrixHelpersTest matrixManipulationsTest = MatrixHelpersTest();
  matrixManipulationsTest.runTests();

  BeaconTests beaconTests = BeaconTests();
  beaconTests.runTests();

  MockBeaconTests mockBeaconTests = MockBeaconTests();
  mockBeaconTests.runTests();

  RealBeaconTests realBeaconTests = RealBeaconTests();
  realBeaconTests.runTests();

  FloorTests floorTests = FloorTests();
  floorTests.runTests();

  BuildingTests buildingTests = BuildingTests();
  buildingTests.runTests();

  UserTests userTests = UserTests();
  userTests.runTests();
}
