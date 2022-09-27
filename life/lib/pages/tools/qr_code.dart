import 'package:flutter/material.dart';

import '../../widgets/consumer_tools.dart';

class QrcodeWidget extends StatelessWidget {
  const QrcodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Qrcode',
        ),
        elevation: 0.0,
        leading: const Icon(Icons.qr_code_2),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Qrcode Page'),
        ),
      ),
    );
  }
}
