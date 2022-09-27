import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:life/icons/all_icons.dart';
import 'package:life/pages/menus/left_menu_item.dart';

import '../../classes/base_net_work.dart';
import '../../classes/model/species.dart';
import '../../classes/result/result.dart';

class MenuListTitleWidget extends StatefulWidget {
  const MenuListTitleWidget({Key? key}) : super(key: key);

  @override
  State<MenuListTitleWidget> createState() => _MenuListTitleWidgetState();
}

class _MenuListTitleWidgetState extends State<MenuListTitleWidget> {
  final StreamController<ListTile> _streamController =
      StreamController(onListen: () {
    if (kDebugMode) {
      print('listen');
    }
  }, onCancel: () {
    if (kDebugMode) {
      print('onCancel');
    }
  });

  final Stream<List<Species>> _tileStream = ApiService()
      .post<String>('/species/find/tree',
          params: {"sign": "string", "timestamp": 0, "data": {}})
      .map((event) => Results.fromJson(event))
      .map((event) => Results(
          code: event.code,
          message: event.message,
          success: event.success,
          timestamp: event.timestamp,
          data: event.data.map((e) => Species.fromJson(e)).toList()))
      .map((event) => event.data);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  late bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<List<Species>>(
          stream: _tileStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Species>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
            }
            late List<Species> root = snapshot.data ?? [];
            List<Species> sps = [];
            root.map((e) => acquireChildren(e, sps)).toList();
            return ExpansionTile(
              title: TextButton(
                onPressed: () {
                },
                style: const ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
                child: const Text(
                  '菜单',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),

                ),
              ),
              trailing: const SizedBox(),
              onExpansionChanged: (e) {
                setState(() {
                  selected = !e;
                });
              },
              initiallyExpanded: true,
              // leading: const Icon(
              //   AllIcons.ice_cube,
              //   color: Colors.white,
              // ),
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              childrenPadding: const EdgeInsets.all(0.0),
              children: root
                  .map((e) => LeftMenuItemWidget(
                      species: e, open: e.level != 0, speciesList: sps))
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  void acquireChildren(Species e, List<Species> sps) {
    sps.add(e);
    List<Species> children = e.children ?? [];

    for (var element in children) {
      if (element.children != null) {
        acquireChildren(element, sps);
      }
    }
  }
}
