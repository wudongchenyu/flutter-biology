import 'package:flutter/material.dart';

import '../../icons/all_icons.dart';

class WinWidget extends StatelessWidget {
  const WinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Win',
        ),
        elevation: 0.0,
        leading: const Icon(AllIcons.win8),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Win Page'),
        ),
      ),
    );
  }
}
