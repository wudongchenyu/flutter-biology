import 'package:flutter/material.dart';

import '../../widgets/consumer_tools.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
        ),
        elevation: 0.0,
        leading: const Icon(Icons.settings),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Setting Page'),
        ),
      ),
    );
  }
}
