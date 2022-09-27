import 'package:flutter/material.dart';

import '../../icons/all_icons.dart';

class Html5Widget extends StatelessWidget {
  const Html5Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Html5',
        ),
        elevation: 0.0,
        leading: const Icon(AllIcons.html5),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Html5 Page'),
        ),
      ),
    );
  }
}
