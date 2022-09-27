import 'package:flutter/material.dart';

import '../../icons/all_icons.dart';

class AndroidWidget extends StatelessWidget {
  const AndroidWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Android',
        ),
        elevation: 0.0,
        leading: const Icon(AllIcons.android),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Android Page'),
        ),
      ),
    );
  }
}
