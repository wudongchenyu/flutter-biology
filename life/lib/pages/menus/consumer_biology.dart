import 'package:flutter/material.dart';

import '../../icons/other_icons.dart';
import 'biology_left_menus.dart';

class BiologyWidget extends StatelessWidget {
  const BiologyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '生物',
        ),
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(OtherIcons.dna),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      drawer: const LeftDrawerWidget(),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asserts/images/b0.jpeg'),
            ),
          ),
        ),
      ),
    );
  }
}
