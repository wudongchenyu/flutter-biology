import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../widgets/grid_view_build.dart';
import '../../widgets/consumer_tools.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StreamController<String> _streamController =
      StreamController(onListen: () {
    if (kDebugMode) {
      print('listen');
    }
  }, onCancel: () {
    if (kDebugMode) {
      print('onCancel');
    }
  });

  // final Stream<Result<String>> _textStream = ApiService().post<Result<String>>('/log/in');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '首页',
        ),
        elevation: 0.0,
        leading: const Icon(Icons.home),
        backgroundColor: Colors.black54,
        centerTitle: true,
        actions: const <Widget>[
          ToolsWidget(),
        ],
      ),
      body: const SafeArea(
        child: GridViewBuildWidget(),
      ),
    );
  }
}
