import 'package:flutter/material.dart';

import '../../widgets/consumer_tools.dart';

class ScanWidget extends StatelessWidget {
  const ScanWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan',
        ),
        elevation: 0.0,
        leading: const Icon(Icons.crop_free_outlined),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Scan Page'),
        ),
      ),
    );
  }
}
