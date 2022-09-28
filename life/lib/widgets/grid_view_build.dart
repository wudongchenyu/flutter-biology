import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../classes/consumer_router_delegate.dart';
import 'grid_icons.dart';

class GridViewBuildWidget extends StatefulWidget {
  const GridViewBuildWidget({Key? key}) : super(key: key);

  @override
  State<GridViewBuildWidget> createState() => _GridViewBuildWidgetState();
}

class _GridViewBuildWidgetState extends State<GridViewBuildWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: GridIcons.iconList.length,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150.0),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.black38,
          margin: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  GridIcons.iconList[index],
                  size: 48.0,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: () {
              if (kDebugMode) {
                print(GridIcons.iconList[index]);
                Delegate().push(
                  name: GridIcons.getRouter(GridIcons.iconList[index]),
                );
              }
            },
          ),
        );
      },
    );
  }
}
