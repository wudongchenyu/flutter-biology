import 'package:flutter/material.dart';

import '../../icons/other_icons.dart';

class IosWidget extends StatelessWidget {
  const IosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ios',
        ),
        elevation: 0.0,
        leading: const Icon(OtherIcons.app_store_ios),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Ios Page'),
        ),
      ),
    );
  }
}
