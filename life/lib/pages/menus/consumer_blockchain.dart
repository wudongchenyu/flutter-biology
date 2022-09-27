import 'package:flutter/material.dart';

import '../../icons/all_icons.dart';

class BlockchainWidget extends StatelessWidget {
  const BlockchainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blockchain',
        ),
        elevation: 0.0,
        leading: const Icon(AllIcons.chain),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Blockchain Page'),
        ),
      ),
    );
  }
}
