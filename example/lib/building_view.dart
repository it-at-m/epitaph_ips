import 'package:flutter/material.dart';
import 'ui_constants.dart';
import 'myWidgets.dart';
import 'package:epitaph_ips/epitaph_ips/buildings/building.dart';

class BuildingView extends StatelessWidget {
  const BuildingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Divider myDivider = Divider(
      color: ColorConstants.black,
      indent: 1,
      endIndent: 1,
      thickness: 2,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: MyAppBar("Building", context),
      ),
      body: SafeArea(
        child: Container(
          height: 0.3 * MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(2),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4, left: 2, right: 2),
                  child: Row(
                    children: [
                      Text('MAC Address'),
                      Spacer(),
                      Text(
                        'Text',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                myDivider,
                Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    children: [
                      Text('Name'),
                      Spacer(),
                      Text(
                        'Text',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                myDivider,
                Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    children: [
                      Text('RSSI'),
                      Spacer(),
                      Text(
                        'Text',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                myDivider,
                Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    children: [
                      Text('Approximated Distance'),
                      Spacer(),
                      Text(
                        'Text',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                myDivider,
                Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    children: [
                      Text('Coordinates'),
                      Spacer(),
                      Text(
                        'x: , y:',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                myDivider,
                Padding(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    children: [
                      Text('Floor'),
                      Spacer(),
                      Text(
                        'Text',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
class BuildingView extends StatefulWidget {
  const BuildingView({Key? key, required this.building}) : super(key: key);
  final Building building;

  @override
  State<BuildingView> createState() => _BuildingViewState();
}

class _BuildingViewState extends State<BuildingView> {
  @override
  Widget build(BuildContext context) {
    return const Text("Hallo");
  }
}
*/
