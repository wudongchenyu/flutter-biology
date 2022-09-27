import 'package:flutter/material.dart';

class BlankPageWidget extends StatelessWidget {
  const BlankPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Error',
        ),
        elevation: 0.0,
        leading: const Icon(Icons.developer_board_rounded),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Image(image: AssetImage('asserts/images/404.jpeg')),
        ),
      ),
    );
  }
}
