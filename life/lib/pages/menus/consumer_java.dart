import 'package:flutter/material.dart';

import '../../icons/other_icons.dart';

class JavaWidget extends StatelessWidget {
  const JavaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Java',
        ),
        elevation: 0.0,
        leading: const Icon(OtherIcons.java),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Java Page'),
        ),
      ),
    );
  }
}
